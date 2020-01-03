
<template>
  
    <b-container>
      <b-row>
        <b-col v-for="hot in hots" sm='6' md='4' lg='3' xl='3' >
          <b-card
            :title="hot.keyword"
            img-src="https://picsum.photos/600/300/?image=25"
            :img-alt="hot.keyword"
            img-top
            tag="article"
            style="max-width: 20rem;"
            class="mb-2"
          >
            <b-card-text>Some quick example text to build on the card title and make up the bulk of the card's content.</b-card-text>
            <b-button :href="baseUrl+'/movie/'+hot.keyword+'/'" variant="primary">vist</b-button>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
</template>

<script>
export default {
  name: "HotRec",
  props: ["hots",'baseUrl'],
  methods: {},
  data() {
    return {};
  }
};
</script>
