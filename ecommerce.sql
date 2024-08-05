-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Agu 2024 pada 12.38
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_07_31_134738_create_products_table', 1),
(2, '2024_08_03_053046_create_transactions_table', 1),
(3, '2024_08_05_013456_create_transaction_details_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `product_name`, `price`, `image`, `stock`, `created_at`, `updated_at`) VALUES
(1, 'Vel ipsam voluptas autem enim ut non et.', 5175.00, 'https://via.placeholder.com/300x300.png/001144?text=ea', 1, '2024-08-04 19:31:39', '2024-08-04 21:11:32'),
(2, 'Quos omnis culpa omnis maiores.', 4442.00, 'https://via.placeholder.com/300x300.png/0044ff?text=sed', 17, '2024-08-04 19:31:39', '2024-08-05 03:31:11'),
(3, 'Quisquam ut natus vero labore.', 8789.00, 'https://via.placeholder.com/300x300.png/000099?text=eum', 30, '2024-08-04 19:31:39', '2024-08-04 21:12:24'),
(4, 'Rerum est omnis eaque vel dolorum.', 5893.00, 'https://via.placeholder.com/300x300.png/0066cc?text=ut', 90, '2024-08-04 19:31:39', '2024-08-04 19:31:39'),
(5, 'Ut omnis sint eos.', 4310.00, 'https://via.placeholder.com/300x300.png/002255?text=quia', 3, '2024-08-04 19:31:39', '2024-08-04 19:31:39');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'BELUM DIBAYAR',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `name`, `email`, `status`, `created_at`, `updated_at`) VALUES
('03417010-ea00-4a6f-8329-75560a72af09', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 20:17:11', '2024-08-04 20:17:11'),
('0bfbcda4-3dab-41a0-bd68-558304c29907', 'okto', 'oktorino2000@gmail.com', 'PAID', '2024-08-04 21:12:24', '2024-08-04 21:12:45'),
('1238f90d-9ca0-43c1-820c-e3ab46f50300', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 20:38:52', '2024-08-04 20:38:52'),
('439e680d-e554-4420-b34a-2ab8a5b2a366', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 19:39:01', '2024-08-04 19:39:01'),
('6a0a9f27-e775-40c0-a689-1dab0901f43c', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 21:11:32', '2024-08-04 21:11:32'),
('7a6e4750-84b8-4fa7-b5ba-6b338648ac82', 'okto', 'oktorino2000@gmail.com', 'PAID', '2024-08-04 20:43:08', '2024-08-04 20:56:38'),
('99d6fca8-781f-40eb-a57b-b8a574817017', 'okto', 'oktorino2000@gmail.com', 'PAID', '2024-08-04 19:51:51', '2024-08-04 19:52:06'),
('afc03147-4b4c-48e6-976c-395103fc0d64', 'okto', 'oktorino2000@gmail.com', 'PAID', '2024-08-04 20:57:55', '2024-08-04 20:58:06'),
('b37bd769-c18f-4b68-9aa0-5b1e32b16d2d', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 20:19:09', '2024-08-04 20:19:09'),
('b8c29606-ea4a-4ce6-84a4-076161f6d3c2', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 21:09:02', '2024-08-04 21:09:02'),
('bbacb335-8e05-46d5-b1b5-12dde2954a71', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 21:08:31', '2024-08-04 21:08:31'),
('d2dfa772-9928-4919-8d6c-e1b240426076', 'okto', 'oktorino2000@gmail.com', 'PAID', '2024-08-04 19:41:38', '2024-08-04 19:45:05'),
('d454e74a-44bd-4c9a-95ac-47b3513b1f5a', 'AS', 'AS@gmail.com', 'BELUM DIBAYAR', '2024-08-04 20:28:35', '2024-08-04 20:28:35'),
('f3c9eedb-f8fb-43dd-babe-2c9388559cca', 'okto', 'oktorino2000@gmail.com', 'PAID', '2024-08-05 03:31:11', '2024-08-05 03:32:00'),
('f64d9da3-89d0-4b4c-9f4f-384cda6dd8aa', 'okto', 'oktorino2000@gmail.com', 'PAID', '2024-08-04 20:19:26', '2024-08-04 20:19:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` char(36) NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `transaction_id`, `product_id`, `quantity`, `price`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, '439e680d-e554-4420-b34a-2ab8a5b2a366', 1, 3, 5175.00, 15525.00, '2024-08-04 19:39:01', '2024-08-04 19:39:01'),
(2, 'd2dfa772-9928-4919-8d6c-e1b240426076', 1, 2, 5175.00, 10350.00, '2024-08-04 19:41:38', '2024-08-04 19:41:38'),
(3, '99d6fca8-781f-40eb-a57b-b8a574817017', 1, 3, 5175.00, 15525.00, '2024-08-04 19:51:51', '2024-08-04 19:51:51'),
(8, '03417010-ea00-4a6f-8329-75560a72af09', 1, 3, 5175.00, 15525.00, '2024-08-04 20:17:11', '2024-08-04 20:17:11'),
(9, 'b37bd769-c18f-4b68-9aa0-5b1e32b16d2d', 1, 3, 5175.00, 15525.00, '2024-08-04 20:19:09', '2024-08-04 20:19:09'),
(10, 'f64d9da3-89d0-4b4c-9f4f-384cda6dd8aa', 2, 1, 4442.00, 4442.00, '2024-08-04 20:19:26', '2024-08-04 20:19:26'),
(11, 'd454e74a-44bd-4c9a-95ac-47b3513b1f5a', 1, 3, 5175.00, 15525.00, '2024-08-04 20:28:35', '2024-08-04 20:28:35'),
(12, '1238f90d-9ca0-43c1-820c-e3ab46f50300', 1, 3, 5175.00, 15525.00, '2024-08-04 20:38:52', '2024-08-04 20:38:52'),
(13, '7a6e4750-84b8-4fa7-b5ba-6b338648ac82', 2, 1, 4442.00, 4442.00, '2024-08-04 20:43:08', '2024-08-04 20:43:08'),
(14, 'afc03147-4b4c-48e6-976c-395103fc0d64', 2, 1, 4442.00, 4442.00, '2024-08-04 20:57:55', '2024-08-04 20:57:55'),
(16, 'bbacb335-8e05-46d5-b1b5-12dde2954a71', 1, 3, 5175.00, 15525.00, '2024-08-04 21:08:31', '2024-08-04 21:08:31'),
(17, 'b8c29606-ea4a-4ce6-84a4-076161f6d3c2', 1, 3, 5175.00, 15525.00, '2024-08-04 21:09:02', '2024-08-04 21:09:02'),
(18, '6a0a9f27-e775-40c0-a689-1dab0901f43c', 1, 3, 5175.00, 15525.00, '2024-08-04 21:11:32', '2024-08-04 21:11:32'),
(19, '0bfbcda4-3dab-41a0-bd68-558304c29907', 3, 1, 8789.00, 8789.00, '2024-08-04 21:12:24', '2024-08-04 21:12:24'),
(20, 'f3c9eedb-f8fb-43dd-babe-2c9388559cca', 2, 3, 4442.00, 13326.00, '2024-08-05 03:31:11', '2024-08-05 03:31:11');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_details_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_details_product_id_foreign` (`product_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD CONSTRAINT `transaction_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_details_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
