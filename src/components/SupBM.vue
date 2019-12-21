<template>
  <ButtonAndModal :item="sup">
    <template v-slot:modalContent>
      <b-table  striped hover :items="sup.data"></b-table>
    </template>
  </ButtonAndModal>
</template>

<script>
import ButtonAndModal from "./ButtonAndModal";
export default {
  name: "SupBM",
  components: {
    ButtonAndModal
  },
  props:['donors'],
  methods: {
    stirModal() {
      console.log("Sup clicked!");
      this.ModalOn = !this.ModalOn;
    }
  },
  data() {
    return {
        sup: {
          info: "支持",
          act: this.stirModal,
          style: "info",
          modalOn: true,
          data: this.donors
        },
  
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
