<template>
  <div>
    <br />
    <br />
    <br />
    <br />
    <b-container class="textCenter">
      <b-row>
        <b-col></b-col>

        <b-col sm="10" md="8" lg="6">
          <h1>Resdig</h1>
          <b-input-group>
            <b-form-input
              v-model="keyword"
              class="shadow round"
              placeholder="请输入搜索关键词"
            ></b-form-input>
            <b-input-group-append>
              <b-button
                v-if="!connecting"
                @click="dig"
                pill
                class="shadow"
                variant="success"
                >Dig</b-button
              >
            </b-input-group-append>
            <b-form-text>
              <!-- <b-badge
                v-for="task in tasks"
                :variant="task.style"
              >{{ task.keyword }} {{ task.progress }}</b-badge>-->
            </b-form-text>
          </b-input-group>
          <!-- <GuessList :keyword="keyword"></GuessList> -->
        </b-col>
        <b-col></b-col>
      </b-row>
    </b-container>
    <br />
    <br />
    <br />
    <br />
  </div>
</template>

<script>
import GuessList from "./GuessList";

export default {
  name: "DigBar",
  components: {
    GuessList
  },
  props: ["makeToast", "resBoardData", "api", "baseUrl"],
  methods: {
    dig() {
      this.resBoardData.open = false;
      this.connecting = true;
      let KW = this.keyword;
      this.makeToast("Connecting...", "正在连接。。。。", "info");

      this.axios
        .post(this.api, {
          reason: "checkKeyword",
          keyword: KW
        })
        .then(response => {
          let data = response.data;
          let status = data.status;
          console.log(status);

          if (status == "recorded") {
            let url = encodeURI("/movie/" + KW + "/");
            window.location.href = url;
          } else if (status == "digging") {
            this.makeToast(
              "Digging...",
              '"' + KW + '"' + "正在挖掘，请查看任务列表！",
              "info"
            );
            console.log(status);
          } else if (status == "notRecord") {
            // 未收录
            this.axios
              .post(this.api, {
                reason: "dig",
                keyword: KW
              })
              .then(response => {
                this.makeToast(
                  "Digging...",
                  '"' + KW + '"' + "未收录，但已加入任务列表，请查看！",
                  "info"
                );
                this.resBoardData.open = false;
              })
              .catch(error =>
                this.makeToast("Warning!", "似乎你的关键字无效！", "warning")
              );
          } else {
            // 未知的返回
            makeToast("Error!", "似乎出了点问题....", "danger");
          }
        })
        .catch(error => console.log(error)); // 失败的返回
      this.connecting = false;
      // window.location.href = "https://baidu.com";
    }
  },
  data() {
    return {
      keyword: "",
      connecting: false
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
