<template>
  <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table
      class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400"
    >
      <thead
        class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"
      >
        <tr>
          <th scope="col" class="px-6 py-3">Product name</th>
          <th scope="col" class="px-6 py-3">Qty</th>
          <th scope="col" class="px-6 py-3">Price</th>
        </tr>
      </thead>
      <tbody>
        <tr
          class="odd:bg-white odd:dark:bg-gray-900 even:bg-gray-50 even:dark:bg-gray-800 border-b dark:border-gray-700"
          v-for="item in cart"
          :key="item.product_id"
        >
          <th
            scope="row"
            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"
          >
            {{ item.product_name }}
          </th>
          <td class="px-6 py-4">
            <MyButton @click="decreaseQuantity(item.product_id)">-</MyButton>
            {{ item.quantity }}
            <MyButton @click="increaseQuantity(item.product_id)">+</MyButton>
          </td>
          <td class="px-6 py-4">Rp. {{ item.price * item.quantity }}</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="4" class="text-right px-6 py-4">Total Amount: Rp. {{ totalAmount }}</td>
        </tr>
      </tfoot>
    </table>
  </div>

  <form class="max-w-sm mx-auto my-8">
    <div class="mb-3">
      <label
        for="name-input"
        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
        >Name</label
      >
      <input
        type="text"
        id="name-input"
        v-model="name" required
        class="block w-full p-2 text-gray-900 border border-gray-300 rounded-lg bg-gray-50 text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      />
    </div>
    <div class="mb-3">
      <label
        for="email-input"
        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
        >Email</label
      >
      <input
        type="email"
        id="email-input"
        v-model="email" required
        class="block w-full p-2 text-gray-900 border border-gray-300 rounded-lg bg-gray-50 text-xs focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      />
    </div>
    <div class="mb-3">
      <label
        for="banks"
        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
        >Select Payment</label
      >
      <select
        id="banks"
        v-model="selectedBank" required
        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      >
        <option v-for="bank in banks" :key="bank.value" :value="bank.value">
          {{ bank.label }}
        </option>
      </select>
    </div>
    <button type="button" class="text-blue-700 hover:text-white border border-blue-700 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2 dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-500 dark:focus:ring-blue-800" @click="checkout">Checkout</button>
  </form>
</template>

<script>
import apiService from "@/helpers/apiService";
import MyButton from "@/components/Button/PlusMinus.vue";

export default {
  components: {
    MyButton
  },
  data() {
    return {
      name: '',
      email: '',
      cart: JSON.parse(localStorage.getItem("cart")) || [],
      selectedBank: "",
      banks: [
        { value: "bca", label: "BCA" },
        { value: "permata", label: "Permata" },
        { value: "bni", label: "BNI" },
      ],
    };
  },
  computed: {
    totalAmount() {
      return this.cart.reduce((acc, item) => acc + item.price * item.quantity, 0);
    },
  },
  methods: {
    removeFromCart(productId) {
      this.cart = this.cart.filter((item) => item.product_id !== productId);
      localStorage.setItem("cart", JSON.stringify(this.cart));
    },
    increaseQuantity(productId) {
      const product = this.cart.find((item) => item.product_id === productId);
      if (product) {
        product.quantity += 1;
        localStorage.setItem("cart", JSON.stringify(this.cart));
      }
    },
    decreaseQuantity(productId) {
      const product = this.cart.find((item) => item.product_id === productId);
      if (product) {
        if (product.quantity > 1) {
          product.quantity -= 1;
        } else {
          this.removeFromCart(productId);
        }
        localStorage.setItem("cart", JSON.stringify(this.cart));
      }
    },
    async checkout() {
      try {
        console.log("Cart Data: ", this.cart);  // Tambahkan log ini

        const totalAmount = this.totalAmount;

        if (!this.banks.find(bank => bank.value === this.selectedBank)) {
          alert('The selected bank is invalid.');
          return;
        }

        const payload = {
          name: this.name,
          email: this.email,
          quantity: this.cart.reduce((acc, item) => acc + item.quantity, 0),
          total_amount: totalAmount,
          product_id: this.cart.map((item) => item.product_id),
          bank: this.selectedBank,
        };

        const data = await apiService.buyProduct(payload);

        localStorage.setItem("expiry_time", data.data.expiry_time);
        localStorage.setItem("total_amount", data.data.total_amount);
        localStorage.setItem("va_number", data.data.va);
        localStorage.setItem("order_id", data.data.order_id);
        localStorage.setItem("bank", data.data.bank);
        this.$router.push("/waiting");
      } catch (error) {
        console.error("Checkout failed", error);
      }
    },
  },
};
</script>
