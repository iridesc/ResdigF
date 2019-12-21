<template>
  <ButtonAndModal :item="msg">
    <template v-slot:modalContent>
      <b-table striped hover :items="msg.data"></b-table>
    </template>
  </ButtonAndModal>
</template>

<script>
import ButtonAndModal from "./ButtonAndModal";
export default {
  name: "MsgBM",
  components: {
    ButtonAndModal
  },
  props: ["msgs"],
  methods: {
    stirModal() {
      console.log("Msg clicked!");
      this.ModalOn = !this.ModalOn;
    },
    sendMsg() {
      console.log("send message!");
      console.log(this.message);
    }
  },
  data() {
    return {
      msg: {
        info: "留言",
        act: this.stirModal,
        style: "info",
        modalOn: false,
        data: this.msgs
      }
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
