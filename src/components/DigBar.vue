<template>
  <b-container :class="resBoardData.open ? 'textCenter' : 'textCenter pageCenter'">
    <b-row>
      <b-col></b-col>
      <b-col sm="10" md="8" lg="6">
        <h1>Resdig</h1>
        <b-input-group>
          <b-form-input v-model="keyword" placeholder="请输入搜索关键词"></b-form-input>
          <b-input-group-append>
            <b-button @click="dig" variant="success">Dig</b-button>
          </b-input-group-append>
        </b-input-group>
        <!-- <GuessList :keyword="keyword"></GuessList> -->
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import GuessList from "./GuessList";

export default {
  name: "DigBar",
  components: {
    GuessList
  },
  props: ["resBoardData", "pushAlert"],
  methods: {
    dig() {
      console.log("Dig clicked!", this.keyword);
      let KW = this.keyword;
      this.axios
        .post("api/", {
          reason: "checkKeyword",
          keyword: KW
        })
        .then(response => {
          let data = response.data;
          let status = data.status;
          console.log(status);

          if (status == "recorded") {
            // 已经收录
            this.axios
              .post("api/", {
                reason: "getRess",
                keyword: KW
              })
              .then(response => {
                this.pushAlert('"' + KW + '"' + "已获取!", "success", 1);
                this.resBoardData.ress = response.data.ress;
                this.resBoardData.keyword = KW;
                this.resBoardData.open = true;
              })
              .catch(error => this.pushAlert(error, "warning", 10));
          } else if (status == "digging") {
            this.pushAlert(
              '"' + KW + '"' + "正在挖掘，请查看任务列表！",
              "info",
              5
            );
            console.log(status);
          } else if (status == "notRecord") {
            // 未收录
            this.axios
              .post("api/", {
                reason: "dig",
                keyword: KW
              })
              .then(response => {
                this.pushAlert(
                  '"' + KW + '"' + "未收录，但已加入任务列表，请查看！"
                );
                this.resBoardData.open = false;
              })
              .catch(error =>
                this.pushAlert("似乎你的关键字无效！", "warning", 2)
              );
          } else {
            // 未知的返回
            pushAlert("似乎出了点问题....", "warning");
          }
        })
        .catch(error => console.log("--------\n", error)); // 失败的返回
    }
  },
  data() {
    return {
      keyword: ""
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.pageCenter {
  position: absolute;
  margin: auto;
  width: 100%;
  top: 25%;
  left: 0;
  right: 0;
}
</style>
