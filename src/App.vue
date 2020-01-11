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
    <div class="pageCenter textCenter ">
      <b-img
        id="mainIcon"
        class="shadow"
        rounded="circle"
        center
        src="https://raw.githubusercontent.com/iridesc/ocolabstatic/master/resdig/img/favicon.ico"
        alt=""
      >
      </b-img>
      <h1 class="textHL">Loading...</h1>
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

    <!-- 图标 -->
    <MainIcon class="speace" :donors="donors"></MainIcon>
    <!-- 搜索框 -->
    <DigBar
      class="speaceY"
      :makeToast="makeToast"
      :resBoardData="resBoardData"
      :PASSWORD="PASSWORD"
    ></DigBar>
    <!-- 资源展示区域 -->
    <ResBoard
      v-if="resBoardData.keyword != ''"
      :makeToast="makeToast"
      :resBoardData="resBoardData"
      :PASSWORD="PASSWORD"
    ></ResBoard>
    <!-- 推荐的外部链接 -->
    <HotRec class="speace" :hots="hots"></HotRec>
  </div>
</template>

<script>
import Test from "./components/Test";
import StatusBar from "./components/StatusBar";
import DigBar from "./components/DigBar";
import HotRec from "./components/HotRec";
import ResBoard from "./components/ResBoard";
import MainIcon from "./components/MainIcon";
import cp from "./components/cp";
import crypto from "./js/crypto";

export default {
  name: "App",
  components: {
    Test,
    StatusBar,
    MainIcon,
    DigBar,
    HotRec,
    ResBoard,
    cp
  },
  created: function() {
  
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
    this.appLoadingValue = 5;
    // console.log(this.appLoadingValue);


    // background
    document.querySelector("body").setAttribute("class", "bg textColor");
    this.appLoadingValue = 10;
    // console.log(this.appLoadingValue);

    // location
    let location = document.location
      .toString()
      .split("//")[1]
      .split("/");

    if (location[1] == "movie") {
      let kw = decodeURIComponent(location[2]);
      window.title = "Resdig" + "-" + kw;
      this.axios
        .post(
          "/api/",
          crypto.encrypt(
            {
              reason: "getRess",
              keyword: kw
            },
            this.PASSWORD
          )
        )
        .then(response => {
          let data = crypto.decrypt(response.data, this.PASSWORD);
          // console.log(data);
          if (data.suc) {
            this.resBoardData.ress = data.ress;
            this.resBoardData.keyword = kw;
          } else {
            // console.log("load error");
            // console.log(kw);
            // console.log(data);
            this.loadError = true;
          }
        })
        .catch(error => {
          // console.log("load error");
          // console.log(error);

          this.loadError = true;
        });
    }
    this.appLoadingValue = 30;

    // staticData
    if (!this.loadError) {
      this.axios
        .post(
          "/api/",
          crypto.encrypt(
            {
              reason: "getStaticData"
            },
            this.PASSWORD
          )
        )
        .then(response => {
          let data = crypto.decrypt(response.data, this.PASSWORD);
          this.casts = data.casts;
          this.hots = data.hots;
          this.donors = data.donors;
          this.resAmount = data.resAmount;
          this.keywordAmount = data.keywordAmount;
          this.appLoadingValue = 60;
        

          

        })
        .catch(error => {
          // console.log(error);
          // console.log("load error");
          this.loadError = true;
        });
    }

    // dynamicData
    if (!this.loadError) {
      setInterval(() => {
        this.axios
          .post(
            "/api/",
            crypto.encrypt(
              {
                reason: "getDynamicData"
              },
              this.PASSWORD
            )
          )
          .then(response => {
            let data = crypto.decrypt(response.data, this.PASSWORD);
            this.tasks = data.tasks;
            this.engines = data.engines;
            this.msgs = data.msgs;
          });
        this.appLoadingValue = 100;
      }, 2500);
    }
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
      PASSWORD: "q863cqfiwyug72jc",

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
.textColor {
  color: indianred;
}
.textHL {
  color: blueviolet;
}
.bgT {
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
