<template>
  <div id="app">
    <Alert :alertList="alertList"></Alert>
    <StatusBar
      :tasks="tasks"
      :engines="engines"
      :keywordAmount="keywordAmount"
      :resAmount="resAmount"
    ></StatusBar>
    <DigBar :resBoardData="resBoardData" :pushAlert="pushAlert"></DigBar>
    <SuspArea>
      <template v-slot>
        <MsgBM :msgs="msgs"></MsgBM>
        <SupBM :donors="donors"></SupBM>
        <HelpBM></HelpBM>
        <MoreBM></MoreBM>
      </template>
    </SuspArea>
    <ResBoard v-if="resBoardData.open" :resBoardData="resBoardData"></ResBoard>

    <!-- <Test :testData='alertList'></Test> -->
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
import Alert from "./components/Alert";
import ResBoard from "./components/ResBoard";

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
    ResBoard,
    Alert
  },
  created: function() {
    this.axios
      .post("api/", {
        reason: "getStaticData"
      })
      .then(response => {
        this.casts = response.data.casts;
        this.hots = response.data.hots;
        this.donors = response.data.donors;
        this.resAmount = response.data.resAmount;
        this.keywordAmount = response.data.keywordAmount;
      })
      .catch(error =>
        this.pushAlert(
          "StaticData get error!!! Please  refresh this page",
          (style = "warning")
        )
      );

    setInterval(() => {
      this.axios
        .post("api/", {
          reason: "getDynamicData"
        })
        .then(response => {
          // console.log("DynamicData", response.data);
          this.tasks = response.data.tasks;
          this.engines = response.data.engines;
          this.msgs = response.data.msgs;
        });
    }, 2500);
  },
  methods: {
    pushAlert(info, style = "info", duration = 10) {
      this.alertList.push({
        duration: duration,
        lastTime: duration,
        info: info,
        style: style
      });
    }
  },
  data() {
    return {
      homeLink: "https://resdig.cn",
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
        open: false,
        resTableOpen: true,
        ress: []
      },
      //
      alertList: []
    };
  }
};
</script>
<style>
.speaceX {
  margin-top: 5%;
  margin-bottom: 5%;
}

.speaceY {
  margin-top: 5%;
  margin-bottom: 5%;
}

.speace {
  margin: 5%;
}
.textCenter {
  text-align: center;
}
</style>
