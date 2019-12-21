<template>
  <div class="speace textCenter">
    <!-- info and control -->
    <b-row>
      <b-col>
        <h3>{{resBoardData.keyword}}</h3>
      </b-col>
      <b-col>
        <b-button>redig</b-button>
        <b-button
          v-on:click="resBoardData.resTableOpen = !resBoardData.resTableOpen"
        >{{ resBoardData.resTableOpen? 'close':'open' }}</b-button>
      </b-col>
    </b-row>
    <!-- Res Table -->
    <div v-if="resBoardData.resTableOpen">
      <b-table striped hover :items="resBoardData.ress"></b-table>
    </div>
  </div>
</template>

<script>
export default {
  name: "ResBoard",
  props: ["resBoardData"],
  methods: {},
  data() {
    return {};
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
