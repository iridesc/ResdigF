<template>
    <div class="susp" >
        <slot></slot>
    </div>
    
</template>

<script>
export default {
    name: 'SuspArea'
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.susp {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: fixed;
    right: 2%;
    bottom: 2%;
}
</style>
