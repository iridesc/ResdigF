<template>
  <b-alert
    :show="alertData.lastTime"
    :variant="alertData.style"
    @dismissed="alertData.lastTime=0"
    @dismiss-count-down="countDown"
    dismissible
  >
    <p>{{ alertData.info }}</p>
    <b-progress
      :variant="alertData.style"
      :max="alertData.duration"
      :value="alertData.lastTime"
      height="4px"
    ></b-progress>
  </b-alert>
</template>

<script>
export default {
  name: "Alert",
  props: ["alertList"],
  created: function() {
    setInterval(() => {
      if (this.alertList.length != 0 && this.alertData.lastTime == 0) {
        this.alertData = this.alertList.pop();
      }
    }, 1000);
  },
  methods: {
    countDown(lastTime) {
      this.alertData.lastTime = lastTime;
    }
  },
  data() {
    return {
      alertData: {
        duration: 0,
        lastTime: 0,
        info: "",
        style: ""
      }
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
