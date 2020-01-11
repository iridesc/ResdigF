<template>
  <b-card-group columns>
    <b-card
      v-for="hot in hots"
      :img-alt="hot.keyword"
      img-top
      tag="article"
      bg-variant="dark"
      class="shadow round textCenter"
    >
      <a :href="'/movie/' + hot.keyword + '/'">
        <b-card-title class="textHL">
          {{ hot.keyword }}
        </b-card-title>
      </a>
      <b-card-text>
        热度：{{ hot.digTimes }}
        <br />
        挖掘时间：{{ new Date(hot.lastDigTime * 1000).toLocaleString() }}
      </b-card-text>
      <!-- <b-button :href="'/movie/' + hot.keyword + '/'" variant="info">
        vist
      </b-button> -->
    </b-card>
  </b-card-group>
</template>

<script>
export default {
  name: "HotRec",
  props: ["hots"]
};
</script>
