<template>
    <button :class="buttonClass" @click="$emit('click')">
      <slot></slot>
    </button>
  </template>
  
  <script>
  export default {
    name: 'ButtonStatus',
    props: {
      isActive: {
        type: Boolean,
        default: false
      }
    },
    computed: {
      buttonClass() {
        const baseClass = 'px-2 py-1';
        const activeClass = this.isActive
          ? 'bg-sky-400 text-white'
          : 'bg-blue-200 text-black';
        return `${baseClass} ${activeClass}`;
      }
    },
  }
  </script>
  