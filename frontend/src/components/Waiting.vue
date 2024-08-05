<template>
  <div>
    <div class="flex justify-between my-8 text-center text-lg font-bold text-black">
      <h3>Total Amount</h3>
      <h3>Rp.{{ totalAmount }}</h3>
    </div>
    <hr class="h-px my-8 bg-gray-200 border-0 dark:bg-gray-800" />
    <div class="my-8 item-center text-lg font-bold text-black">
      <div class="flex justify-between">
        <Label>Pay Before</Label>
        <div class="text-end">
          <h3 class="text-green-500">{{ countdown }}</h3>
          <p class="text-md font-normal">Due date {{ formattedExpiryTime }}</p>
        </div>
      </div>
    </div>
    <hr class="h-px my-8 bg-gray-200 border-2 dark:bg-gray-800" />
    <div class="my-8 text-lg font-bold text-black">
      <p>Bank {{ bank }}</p>
    </div>
    <div>
      <p>No. Rek/Virtual Account</p>
      <div class="flex gap-2 items-center">
        <h2 class="font-bold text-lg cursor-pointer">
          {{ vaNumber }}
        </h2>
        <button @click="copyToClipboard(vaNumber)">
          <span v-if="!copySuccess" id="default-icon">
            <IconCopy />
          </span>
          <span v-if="copySuccess" id="success-icon" class="inline-flex items-center">
            <IconSuccess />
          </span>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import IconCopy from "@/components/icons/IconCopy.vue";
import IconSuccess from "@/components/icons/IconSuccess.vue";
import apiService from "@/helpers/apiService";

export default {
  components: {
    IconCopy,
    IconSuccess,
  },
  data() {
    return {
      vaNumber: localStorage.getItem("va_number") || "N/A",
      totalAmount: localStorage.getItem("total_amount") || "N/A",
      orderId: localStorage.getItem("order_id") || "",
      bank: localStorage.getItem("bank") || "",
      expiryTime: localStorage.getItem("expiry_time") || "",
      countdown: "",
      copySuccess: false,
    };
  },
  created() {
    this.checkPaymentStatus();
    this.startCountdown();
  },
  methods: {
    async checkPaymentStatus() {
      try {
        console.log("Checking payment status for orderId:", this.orderId);
        const response = await apiService.checkPaymentStatus(this.orderId);
        console.log("Payment status response:", response);

        if (response.status === "PAID") {
          localStorage.removeItem("total_amount");
          localStorage.removeItem("va_number");
          localStorage.removeItem("cart");
          localStorage.removeItem("order_id");
          localStorage.removeItem("expiry_time");
          this.$router.push("/success");
        } else {
          setTimeout(this.checkPaymentStatus, 5000);
        }
      } catch (error) {
        console.error("Failed to check payment status", error);
      }
    },
    startCountdown() {
      const expiryDate = new Date(this.expiryTime);
      this.updateCountdown(expiryDate);

      this.countdownInterval = setInterval(() => {
        this.updateCountdown(expiryDate);
      }, 1000);
    },
    updateCountdown(expiryDate) {
      const now = new Date();
      const timeRemaining = expiryDate - now;

      if (timeRemaining <= 0) {
        clearInterval(this.countdownInterval);
        this.countdown = "Expired";
        return;
      }

      const hours = Math.floor(timeRemaining / (1000 * 60 * 60));
      const minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

      this.countdown = `${hours}h ${minutes}m ${seconds}s`;
    },
    copyToClipboard(text) {
      navigator.clipboard.writeText(text).then(() => {
        this.copySuccess = true;
        setTimeout(() => {
          this.copySuccess = false;
        }, 2000);
      }).catch(err => {
        console.error('Failed to copy text: ', err);
      });
    },
  },
  computed: {
    formattedExpiryTime() {
      return new Date(this.expiryTime).toLocaleString();
    },
  },
  beforeDestroy() {
    if (this.countdownInterval) {
      clearInterval(this.countdownInterval);
    }
  },
};
</script>
