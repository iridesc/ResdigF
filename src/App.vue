<template>
  <!-- 页面载入出错 -->
  <div id="app" class="textCenter" v-if="loadError">
    <h1 style="color:red">Load Error !</h1>
    <h3 style>
      Try refresh later / go to
      <a href="/">homepage</a>
    </h3>
  </div>
  <!-- 正在载入 -->
  <div id="app" v-else-if="appLoadingValue < 100">
    <div class=" pageCenter textCenter speace">
      <h1>Loading...</h1>
      <b-progress
        :value="appLoadingValue"
        :max="appLoadMax"
        animated
      ></b-progress>
    </div>
  </div>
  <!-- 载入成功 -->
  <div id="app" v-else>
    <!-- 状态栏 -->
    <StatusBar :tasks="tasks" :engines="engines"></StatusBar>
    <!-- 搜索框 -->
    <DigBar
      class="speaceY"
      :makeToast="makeToast"

      :resBoardData="resBoardData"
    ></DigBar>
    <!-- 资源展示区域 -->
    <ResBoard
      v-if="resBoardData.keyword != ''"
      :makeToast="makeToast"
      :resBoardData="resBoardData"
    ></ResBoard>
    <!-- 推荐的外部链接 -->
    <HotRec class="speace" :hots="hots"></HotRec>

    <SuspArea>
      <template v-slot>
        <MsgBM :msgs="msgs"></MsgBM>
        <SupBM :donors="donors"></SupBM>
        <HelpBM></HelpBM>
        <MoreBM></MoreBM>
      </template>
    </SuspArea>
  </div>
</template>

<script>
import Test from "./components/Test";
import SuspArea from "./components/SuspArea";
import StatusBar from "./components/StatusBar";
import DigBar from "./components/DigBar";
import MsgBM from "./components/MsgBM";
import SupBM from "./components/SupBM";
import HelpBM from "./components/HelpBM";
import MoreBM from "./components/MoreBM";
import HotRec from "./components/HotRec";
import ResBoard from "./components/ResBoard";
import cp from "./components/cp";

export default {
  name: "App",
  components: {
    Test,
    SuspArea,
    StatusBar,
    DigBar,
    MsgBM,
    SupBM,
    HelpBM,
    MoreBM,

    HotRec,
    ResBoard,
    cp
  },
  created: function() {
    this.appLoadingValue = 5;
    // csrf token
    let getCSRF = this.$cookies.get("csrftoken");
    this.axios.interceptors.request.use(
      function(config) {
        if (config.method == "post") {
          config.headers["X-CSRFToken"] = getCSRF;
        }
        return config;
      },
      function(error) {
        // Do something with request error
        return Promise.reject(error);
      }
    );
    this.appLoadingValue = 33;
    // location
    let location = document.location
      .toString()
      .split("//")[1]
      .split("/");
    // console.log(location);
    if (location[1] == "movie") {
      let kw = decodeURIComponent(location[2]);
      window.title = "Resdig" + "-" + kw;
      // console.log(window.title);

      this.axios
        .post('/api/', {
          reason: "getRess",
          keyword: kw
        })
        .then(response => {
          let data = response.data;
          // console.log(data);
          if (data.suc) {
            this.resBoardData.ress = data.ress;
            this.resBoardData.keyword = kw;
          } else {
            this.loadError = true;
          }
        })
        .catch(error => {
          this.loadError = true;
        });
    }
    this.appLoadingValue = 50;
    // staticData
    if (!this.loadError) {
      this.axios
        .post('/api/', {
          reason: "getStaticData"
        })
        .then(response => {
          this.casts = response.data.casts;
          this.hots = response.data.hots;
          this.donors = response.data.donors;
          this.resAmount = response.data.resAmount;
          this.keywordAmount = response.data.keywordAmount;
          // console.log(this.hots[0]);
        })
        .catch(error => (this.loadError = true));
      this.appLoadingValue = 66;
    }

    // dynamicData
    if (!this.loadError) {
      setInterval(() => {
        this.axios
          .post('/api/', {
            reason: "getDynamicData"
          })
          .then(response => {
            // console.log("DynamicData", JSON.stringify(response.data));
            this.tasks = response.data.tasks;
            this.engines = response.data.engines;
            this.msgs = response.data.msgs;
            // console.log('tasks:',this.tasks[0]);
          });
        this.appLoadingValue = 100;
      }, 2500);
    }
  },
  mounted() {
    document
      .querySelector("body")
      .setAttribute("class", "bg textColor");
  },
  methods: {
    makeToast(title, content, variant = null) {
      this.$bvToast.toast(content, {
        title: title,
        variant: variant,
        solid: true
      });
    }
  },
  data() {
    return {
      appLoadingValue: 0,
      appLoadMax: 100,
      loadError: false,

      // static data
      casts: [],
      hots: [],
      donors: [],
      resAmount: 0,
      keywordAmount: 0,
      // dynamic datd
      engines: [],
      msgs: [],
      tasks: [],
      //
      resBoardData: {
        keyword: "",

        ress: []
      }
    };
  }
};
</script>
<style>
.bg {
  background-color: darkslategray;
}
.textColor{
    color: indianred;
}
.bgT{
  background-color: cadetblue;
}
.speaceX {
  margin-left: 2%;
  margin-right: 2%;
}

.speaceY {
  margin-top: 2%;
  margin-bottom: 2%;
}

.speace {
  margin: 5%;
}
.round {
  border-radius: 20px;
  /* border: 2px solid darkgray; */
  /* padding: 5px; */
}

.textCenter {
  text-align: center;
}
.pageCenter {
  position: absolute;
  margin: auto;
  width: 100%;
  top: 25%;
  left: 0;
  right: 0;
}
.shadow {
  box-shadow: 20px 20px 10px red;
}
body {
  background-color: darkgray;
}
.blur {
  background: hsla(0, 0%, 100%, 0.3);
}
</style>
