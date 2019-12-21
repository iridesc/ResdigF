<template>
  <ButtonAndModal :item="more">
    <template v-slot:modalContent>
      <b-spinner v-if="!more.loaded" variant="success" type="grow" label="Spinning"></b-spinner>
      <div v-else>{{ more.data }}</div>
    </template>
  </ButtonAndModal>
</template>

<script>
import ButtonAndModal from "./ButtonAndModal";
export default {
  name: "MoreBM",
  components: {
    ButtonAndModal
  },
  methods: {
    stirModal() {
      console.log("More clicked!");
      this.ModalOn = !this.ModalOn;
    }
  },
  data() {
    return {
          more: {
          info: "更多",
          act: this.stirModal,
          style: "info",
          modalOn: false,
          loaded: true,
          data: "MORE mark down feld"
        }
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
