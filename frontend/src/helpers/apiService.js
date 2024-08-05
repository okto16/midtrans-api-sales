import axios from "@/plugins/axios";

const apiService = {
  async buyProduct(payload) {
    try {
      const response = await axios.post("/product/buy", payload);
      return response.data;
    } catch (error) {
      throw error;
    }
  },
  async getProducts() {
    try {
      const response = await axios.get("/products");
      return response.data;
    } catch (error) {
      throw error;
    }
  },
  async checkPaymentStatus(orderId) {
    try {
      const response = await axios.get(`/transaction-status/${orderId}`);
      return response.data;
    } catch (error) {
      throw error;
    }
  },
};

export default apiService;
