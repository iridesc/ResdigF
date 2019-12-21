<template>
  <div id="watch-example">
    <li v-for="(item, index) in guessList" :key="index">{{ item }}</li>
  </div>
</template>

<script>
import _ from "lodash";
export default {
  name: "GussList",
  props: ["keyword"],
  watch: {
    // 如果 `keyword` 发生改变，这个函数就会运行
    keyword: function(newQuestion, oldQuestion) {
      this.guessList = ["waiting inputing..."];
      this.debouncedGuess();
    }
  },
  created: function() {
    this.debouncedGuess = _.debounce(this.guess, 1000);
  },
  methods: {
    guess: function() {
      if (this.keyword.length > 0) {
        this.guessList = ["Thinking..."];
        var vm = this;
        // this.axios
        //   .get("/movie/top250")
        //   .then(res => {

        //     res = res.data;
        //     if (res.errno === ERR_OK) {
        //       this.themeList = res.data;
        //     }
        //   })
        //   .catch(error => {
        //     console.warn(error);
        //   });

        this.axios
          .get("j/subject_suggest/", {
            params: {
              q: this.keyword
            },
            headers: {
              "User-Agent":
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",

              Accept:
                "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
              "Accept-Language": "zh-CN,zh;q=0.8"
            }
          })
          .then(response => {
            console.log("*****************");
            console.log(response.data); // 成功的返回
          })
          .catch(error => console.log("--------\n", error)); // 失败的返回
      }
    }
  },
  data() {
    return {
      guessList: []
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
