
<template>
  <div>
    <h1>***********TEST*************</h1>
    <h1>{{hello}}</h1>
  </div>
</template>

<script>
export default {
  name: "Test",
  props: ["testData"],
  created: function() {
    setInterval(() => {
      console.log('TEST',this.testData);
    }, 2000);
  },
  methods: {},
  data() {
    return {
      hello: "hello world!"
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
