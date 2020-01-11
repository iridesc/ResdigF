<template>
  <!-- Res Table -->
  <div class="textCenter">
    <!-- redig -->

    <b-container class=" round shadow">
      <b-row class="shadow round">
        <b-col>
          <h1 class="speace ">{{ resBoardData.keyword }}</h1>
        </b-col>
        <b-col>
          <b-button
            class="shadow speace"
            pill
            size="sm"
            variant="success"
            @click="redig"
            >Re Dig</b-button
          >
        </b-col>
      </b-row>
      <br />
      <!-- table -->
      <b-row>
        <b-col
          v-for="item in sortedRess"
          v-if="item.ress.length > 0"
          sm="auto"
          md="auto"
          lg="6"
          xl="6"
        >
          <h3>{{ item.type + " : " }} {{ item.ress.length }}</h3>

          <b-table
            head-variant="dark"
            fixed
            striped
            hover
            sticky-header="800px"
            class="shadow"
            :items="item.ress"
            :fields="fields"
          >
            <template v-slot:cell(Action)="data">
              <b-button
                variant="secondary"
                @click="data.item.jump()"
                class="speaceX shadow"
                size="sm"
                pill
                >原址</b-button
              >
              <b-button
                variant="success"
                v-clipboard:copy="data.item.link"
                v-clipboard:success="onCopySuc"
                v-clipboard:error="onCopyError"
                class="speaceX shadow"
                size="sm"
                pill
                >复制</b-button
              >
            </template>
            <template v-slot:cell(Filename)="data"
              ><p style="word-break:break-all">
                {{ data.index + 1 + ":"
                }}{{
                  data.item.filename == null
                    ? data.item.link.slice(0, 40) + "..."
                    : data.item.filename.slice(0, 40) + "..."
                }}
              </p>
            </template>
            <template v-slot:cell(Size&Tech)="data">
              <b-badge
                v-for="tag in data.item.tags"
                :variant="tag.color"
                class="shadow"
                >{{ tag.name }}</b-badge
              >
            </template>
          </b-table>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import crypto from "../js/crypto";
export default {
  name: "ResBoard",
  props: ["resBoardData", "makeToast", "PASSWORD"],
  methods: {
    redig() {
      this.axios
        .post(
          "/api/",
          crypto.encrypt(
            {
              reason: "dig",
              keyword: this.resBoardData.keyword
            },
            this.PASSWORD
          )
        )
        .then(response => {
          let data = crypto.decrypt(response.data,this.PASSWORD);
          // console.log(data);
          if (data.suc) {
            // console.log("SUC");
            this.makeToast(
              "Success!",
              this.resBoardData.keyword + "已加入任务列表！",
              "success"
            );
          } else {
            if (data.reason == "inTasks") {
              this.makeToast(
                "In tasks!",
                this.resBoardData.keyword + "已在任务列表！请关注任务列表！",
                "info"
              );
            } else if (data.reason == "timeLocked") {
              this.makeToast(
                "Rejected!",
                this.resBoardData.keyword + "上次挖掘据今还未超出一天！",
                "warning"
              );
            } else if (data.reason == "keywordInvalid") {
              this.makeToast(
                "Error!",
                this.resBoardData.keyword + "关键字无效！",
                "danger"
              );
            } else {
              this.makeToast(
                "Error!",
                this.resBoardData.keyword + "未知的错误",
                "danger"
              );
            }
          }
        })
        .catch();
    },

    onCopySuc: function(e) {
      this.makeToast("Success!", "复制成功!", "success");
    },
    onCopyError: function(e) {
      alert("复制失败！请手动复制：\n" + e.text);
    }
  },

  created: function() {
    let newList = [];
    // score setting
    let total_score = 100;
    let filesize_score_rate = 0.3;
    let pic_score_rate = 0.45;
    let sound_score_rate = 0.1;
    let bluray_score_rate = 0.15;
    let total_size = 0;
    let fileamount = 1;
    this.resBoardData.ress.forEach(res => {
      if (res.filesize != 0) {
        total_size += res.filesize;
        fileamount += 1;
      }
    });
    let average_size = total_size / fileamount;

    // 记分
    for (let index = 0; index < this.resBoardData.ress.length; index++) {
      const res = this.resBoardData.ress[index];
      let filesize_score;
      let pic_score;
      let bluray_score;
      let sound_score;
      // console.log('*');
      res.tags = [];
      filesize_score = (1 + (res.filesize - average_size) / average_size) / 2;

      res.tags.push({
        color: "warning",
        name:
          res.filesize == 0
            ? " 未知大小"
            : (res.filesize / 1024).toFixed(2) + "GB"
      });

      if (res.filename != null) {
        //  picture quality
        if (
          res.filename.indexOf("1080p") > -1 ||
          res.filename.indexOf("BD1920") > -1
        ) {
          pic_score = 0.8;
          res.tags.push({ color: "primary", name: "1080p" });
        } else if (
          res.filename.indexOf("720p") > -1 ||
          res.filename.indexOf("BD1280") > -1
        ) {
          pic_score = 0.6;
          res.tags.push({ color: "success", name: "720p" });
        } else if (res.filename.indexOf("480p") > -1) {
          pic_score = 0.4;
          res.tags.push({ color: "secondary", name: "HD1280" });
        } else {
          pic_score = 0.2;
        }

        // BluRay
        if (res.filename.indexOf("BluRay") > -1) {
          bluray_score = 1;
          res.tags.push({ color: "primary", name: "BluRay" });
        } else {
          bluray_score = 0;
        }

        // sounds quality
        if (res.filename.indexOf("DTS-HD") > -1) {
          sound_score = 1;
          res.tags.push({ color: "info", name: "DTS-HD" });
        } else if (res.filename.indexOf("DTS") > -1) {
          sound_score = 0.7;
          res.tags.push({ color: "info", name: "DTS" });
        } else if (res.filename.indexOf("DD5.1") > -1) {
          sound_score = 0.5;
          res.tags.push({ color: "info", name: "Dolby" });
        } else {
          sound_score = 0;
        }
      } else {
        sound_score = 0;
        pic_score = 0;
        bluray_score = 0;
      }
      // sum
      res.total_score =
        total_score *
        (pic_score * pic_score_rate +
          sound_score * sound_score_rate +
          filesize_score * filesize_score_rate +
          bluray_score * bluray_score_rate);
      newList.push(res);
    }

    // 排序
    function SortByScore(a, b) {
      return b.total_score - a.total_score;
    }
    newList.sort(SortByScore);

    // 分类
    for (let index = 0; index < newList.length; index++) {
      const element = newList[index];
      // 添加跳转函数
      element.jump = function() {
        window.open(element.web);
      };
      // 选取 HQR50
      if (this.sortedRess.HQR50.count < 50) {
        element._rowVariant = "info";
        this.sortedRess.HQR50.ress.push(element);
        this.sortedRess.HQR50.count += 1;
      }
      // 分类装载
      if (element.type == "thunder") {
        element._rowVariant = "primary";
        this.sortedRess.thunder.ress.push(element);
        this.sortedRess.thunder.count += 1;
      } else if (element.type == "magnet") {
        element._rowVariant = "success";
        this.sortedRess.magnet.ress.push(element);
        this.sortedRess.magnet.count += 1;
      } else if (element.type == "ed2k") {
        element._rowVariant = "info";
        this.sortedRess.ed2k.ress.push(element);
        this.sortedRess.ed2k.count += 1;
      } else {
        // console.log("unknow type");
      }
    }

    // console.log(this.sortedRess);
  },

  data() {
    return {
      textForCopy: "",

      fields: [
        { key: "Filename", sortable: true },

        { key: "Size&Tech", sortable: true },
        "Action"
      ],
      sortedRess: {
        HQR50: {
          type: "HQR-50",
          ress: [],
          count: 0
        },
        magnet: {
          type: "magnet",
          ress: [],
          count: 0
        },
        ed2k: {
          type: "ed2k",
          ress: [],
          count: 0
        },
        thunder: {
          type: "thunder",
          ress: [],
          count: 0
        }
      }
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
