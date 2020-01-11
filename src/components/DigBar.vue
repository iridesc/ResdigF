<template>
  <b-container class="textCenter">
    <b-row>
      <b-col></b-col>
      <b-col sm="10" md="8" lg="6">
        
        <b-input-group>
          <b-form-input
            v-model="keyword"
            class="shadow"
            :state="checkKeyword"
            placeholder="请输入关键词"
          ></b-form-input>
          <b-form-invalid-feedback v-if="keyword.length != 0">
            {{ keywordInvalidInfo }}
          </b-form-invalid-feedback>

          <b-input-group-append v-if="keywordValid">
            <b-button @click="dig" class="shadow" variant="success"
              >Dig</b-button
            >
          </b-input-group-append>
        </b-input-group>
        <!-- 用户的搜索历史 -->
        <b-badge
          v-for="userKeyword in userKeywords"
          @click="
            keyword = userKeyword;
            dig();
          "
          class="speaceX"
        >
          {{ userKeyword }}
        </b-badge>
        <!-- <GuessList :keyword="keyword"></GuessList> -->
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import GuessList from "./GuessList";
import crypto from "../js/crypto";

export default {
  name: "DigBar",
  components: {
    GuessList
  },
  props: ["makeToast", "resBoardData",'PASSWORD'],
  methods: {
    dig() {
      let KW = this.keyword;

      let userKeywordIndex = this.userKeywords.indexOf(KW);
      if (userKeywordIndex == -1) {
        this.userKeywords.unshift(KW);
      } else {
        this.userKeywords.splice(userKeywordIndex, 1);
        this.userKeywords.unshift(KW);
      }

      this.axios
        .post(
          "/api/",
          crypto.encrypt(
            {
              reason: "checkKeyword",
              keyword: KW
            },
            this.PASSWORD
          )
        )
        .then(response => {
          let data = response.data;
          let status = data.status;
          console.log(status);

          if (status == "recorded") {
            let url = "/movie/" + encodeURIComponent(KW) + "/";
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
              .post(
                "/api/",
                crypto.encrypt(
                  {
                    reason: "dig",
                    keyword: KW
                  },
                  this.PASSWORD
                )
              )
              .then(response => {
                this.makeToast(
                  "Digging...",
                  '"' + KW + '"' + "未收录，但已加入任务列表，请查看！",
                  "info"
                );
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
    }
  },
  computed: {
    checkKeyword: function() {
      if (this.keyword.length == 0 || this.keyword.length > 50) {
        this.keywordValid = false;
        this.keywordInvalidInfo = "Keyword length must in the range of 1-50.";
      } else if (this.keyword.search(/\s\s+/) != -1) {
        this.keywordValid = false;
        this.keywordInvalidInfo = "Keyword shall not contain continuous space.";
      } else if (this.keyword.search(/(^\s)|(\s$)/) != -1) {
        this.keywordValid = false;
        this.keywordInvalidInfo =
          "Space shall not at the start/end of the keyword.";
      } else {
        this.keywordValid = true;
      }
      return this.keywordValid;
    }
  },
  created: function() {
    // 载入用户搜索历史
    console.log(this.$cookies.get("userKeywords"));
    if (this.$cookies.isKey("userKeywords")) {
      this.userKeywords = JSON.parse(this.$cookies.get("userKeywords"));
    } else {
      this.$cookies.set("userKeywords", JSON.stringify([]));
    }
  },
  watch: {
    userKeywords: function() {
      this.$cookies.set("userKeywords", JSON.stringify(this.userKeywords));
    }
  },
  data() {
    return {
      keyword: "",
      keywordValid: false,
      keywordInvalidInfo: "",
      userKeywords: []
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
