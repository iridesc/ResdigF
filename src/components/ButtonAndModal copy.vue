<template>
  <div>
    <div class="">
      <b-button
        v-b-modal="item.info"
        :variant="item.style"
        @click="item.act()"
        class="speaceX shadow"
        size="sm"
        pill
      >{{ item.info }}</b-button>
    </div>
    <b-modal :id="item.info" :title="item.info" scrollable centered button-size="sm">
      <template v-solt>
        <slot name="modalContent"></slot>
      </template>
      <template v-slot:modal-footer>
        <slot name="modalFooter"></slot>
      </template>
    </b-modal>
  </div>
</template>

<script>
export default {
  name: "ButtonAndModal",
  props: ["item"]
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
