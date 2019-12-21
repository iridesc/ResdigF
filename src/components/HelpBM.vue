<template>
  <ButtonAndModal :item="help">
    <template v-slot:modalContent>
      <b-spinner v-if="!help.loaded" variant="success" type="grow" label="Spinning"></b-spinner>
      <div v-else>{{ help.data }}</div>
    </template>
  </ButtonAndModal>
</template>

<script>
import ButtonAndModal from "./ButtonAndModal";
export default {
  name: "HelpBM",
  components: {
    ButtonAndModal
  },
  methods: {
    stirModal() {
      console.log("Help clicked!");
      this.ModalOn = !this.ModalOn;
    }
  },
  data() {
    return {
          help: {
          info: "幫助",
          act: this.stirModal,
          style: "info",
          modalOn: false,
          loaded: true,
          data: "mark down feld"
        },
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
