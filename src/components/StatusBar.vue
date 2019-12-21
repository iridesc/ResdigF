<template>
  <b-nav class="text-center">
    <b-container>
      <b-row>
        <b-col sm="0"  >
          <b-badge>{{ this.keywordAmount }}</b-badge>
        </b-col >
        <b-col sm="0">
          <b-badge>{{ this.resAmount }}</b-badge>
        </b-col>
        <b-col>
          Tasks:
          <div v-if="tasks.length> 0">
            <b-badge
              v-for="task in tasks"
              :variant="task.style"
            >{{ task.keyword }} {{ task.progress }}</b-badge>
          </div>
          <b-badge v-else>当前无任务</b-badge>
        </b-col>
        <b-col>
          Engines:
          <b-badge
            v-for="engine in engines"
            :variant="engine.isActive ? 'success' : 'secondary'"
          >{{ engine.name }}</b-badge>
        </b-col>
      </b-row>
    </b-container>
  </b-nav>
</template>

<script>
export default {
  name: "StatusBar",
  props: ["tasks", "engines", "keywordAmount", "resAmount"],
  data() {
    return {};
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
