<template>
    <button :class="buttonClass">
      <slot></slot>
    </button>
  </template>
  
  <script>
  export default {
    name: 'ButtonStatus',
    props: {
      type: {
        type: String,
        default: 'primary'
      }
    },
    computed: {
      buttonClass() {
        const baseClass = 'rounded-lg px-1 ring-offset-2 ring-1';
        const typeClass = this.type === 'primary'
          ? 'text-gray-700 hover:bg-sky-50 text-sm text-center inline-flex justify-center text-xs font-semibold ring-gray-500 ring-inset'
          : 'text-gray-600 hover:bg-sky-100 outline-sky-600 text-sm text-center inline-flex justify-center text-xs font-semibold ring-blue-500 ring-inset';
        return `${baseClass} ${typeClass}`;
      }
    },
  }
  </script>
  