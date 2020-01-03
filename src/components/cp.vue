<template id="t">
  <div class="container">
    <button
      type="button"
      v-clipboard:copy="message"
      v-clipboard:success="onCopy"
      v-clipboard:error="onError"
    >Copy!</button>
  </div>
</template>
 
<script>
export default {
  name: "cp",
  methods: {
    onCopy: function(e) {
      alert("You just copied: " + e.text);
    },
    onError: function(e) {
      alert("Failed to copy texts");
    }
  },
  data() {
    return {
      message: "Copy These Text"
    };
  }
};
</script> 