<template>

    <b-container class="textCenter">
      <b-row>
        <b-col v-if="tasks.length != 0">
          <span v-for="task in tasks">
            <b-progress v-if="task.status == 'Digging'">
              <b-progress-bar :max="100" :value="task.progress" animated>{{
                task.keyword
              }}</b-progress-bar>
            </b-progress>
            <b-badge
              :variant="task.status == 'Waiting' ? 'info' : 'success'"
              pill  
              v-else
            >
              {{ task.keyword + " " + task.status }}
            </b-badge>
          </span>
        </b-col>
        <b-col>
          <b-badge
            v-for="engine in engines"
            :variant="engine.isActive ? 'success' : 'secondary'"
            class="shadow"
            pill

            >{{ engine.name }}</b-badge
          >
        </b-col>
      </b-row>
    </b-container>

</template>

<script>
export default {
  name: "StatusBar",
  props: ["tasks", "engines"],
  data() {
    return {};
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
