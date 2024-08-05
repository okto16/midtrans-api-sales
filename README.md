# E-commerce Sales System with Midtrans Core API

This project is an e-commerce sales system that integrates Midtrans Core API for payment processing. It is built using Laravel for the backend, Vue.js for the frontend, and Tailwind CSS for styling.

## Features

- Shopping cart functionality
- Dynamic bank options for payment
- Integration with Midtrans Core API for payment processing

## Tech Stack

- **Backend:** Laravel 11
- **Frontend:** Vue.js 3
- **Styling:** Tailwind CSS
- **Payment Gateway:** Midtrans Core API

## Requirements

- PHP >= 8.1
- Composer
- Node.js & npm
- MySQL or any other supported database

## Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/okto16/midtrans-api-sales.git
    cd midtrans-api-sales
    ```

2. **Backend Setup:**

    - Navigate to the `backend` directory:
      ```bash
      cd backend
      ```

    - Install dependencies:
      ```bash
      composer install
      ```

    - Run migrations and seed the database:
      ```bash
      php artisan migrate
      ```

    - Start the development server:
      ```bash
      php artisan serve
      ```

3. **Frontend Setup:**

    - Navigate to the `frontend` directory:
      ```bash
      cd ../frontend
      ```

    - Install dependencies:
      ```bash
      npm install
      ```

    - Run the development server:
      ```bash
      npm run dev
      ```

## Usage

- **Shopping Cart:**
  - Users can add products to the cart.
  - Users can update the quantity of products in the cart.
  - Users can proceed to checkout and select a bank option for payment.

- **Payment Processing:**
  - The system integrates with Midtrans Core API for secure payment processing.
  - After successful payment, users are redirected to a waiting page displaying the virtual account number.

## Project Structure

- **Backend:**
  - Located in the `backend` directory.
  - Uses Laravel for handling API requests and database interactions.

- **Frontend:**
  - Located in the `frontend` directory.
  - Uses Vue.js for building interactive user interfaces.
  - Tailwind CSS is used for styling components.

## Acknowledgments

- [Laravel](https://laravel.com/)
- [Vue.js](https://vuejs.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Midtrans](https://midtrans.com/)

