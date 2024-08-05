import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import ProductsList from '../components/ProductsList.vue';
import Cart from '../components/Cart.vue';
import Waiting from '../components/Waiting.vue';
import Success from '../components/Success.vue';


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/products',
      name: 'ProductsList',
      component: ProductsList
    },
    {
      path: '/cart',
      name: 'Cart',
      component: Cart
    },
    {
      path: '/waiting',
      name: 'Waiting',
      component: Waiting
    },
    {
      path: '/success',
      name: 'Success',
      component: Success
    },
    {
      path: '/',
      name: 'home',
      component: ProductsList
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    }
  ]
})

export default router
