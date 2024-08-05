<template>
  <div>
    <Navbar />
    <div class="container mx-auto">
        <RouterView />
    </div>
  </div>
</template>

<script setup>
import Navbar from "@/components/Navbar/Navbar.vue";
</script>
