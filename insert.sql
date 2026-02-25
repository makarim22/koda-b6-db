-- ===========================
-- 1. INSERT USERS (Pelanggan & Admin)
-- ===========================
INSERT INTO users (full_name, email, password, phone, profile_image) VALUES
('Budi Santoso', 'budi.santoso@email.com', '$2b$10$hashed_password_1', '081234567890', '/images/profile/budi.jpg'),
('Siti Nurhaliza', 'siti.nurhaliza@email.com', '$2b$10$hashed_password_2', '082345678901', '/images/profile/siti.jpg'),
('Ahmad Wijaya', 'ahmad.wijaya@email.com', '$2b$10$hashed_password_3', '083456789012', '/images/profile/ahmad.jpg'),
('Rina Kusuma', 'rina.kusuma@email.com', '$2b$10$hashed_password_4', '084567890123', '/images/profile/rina.jpg'),
('Dedi Gunawan', 'dedi.gunawan@email.com', '$2b$10$hashed_password_5', '085678901234', '/images/profile/dedi.jpg'),
('Maya Puspita', 'maya.puspita@email.com', '$2b$10$hashed_password_6', '086789012345', '/images/profile/maya.jpg'),
('Rudi Hermawan', 'rudi.hermawan@email.com', '$2b$10$hashed_password_7', '087890123456', '/images/profile/rudi.jpg'),
('Tini Suryani', 'tini.suryani@email.com', '$2b$10$hashed_password_8', '088901234567', '/images/profile/tini.jpg'),
('Bambang Irawan', 'bambang.irawan@email.com', '$2b$10$hashed_password_9', '089012345678', '/images/profile/bambang.jpg'),
('Citra Dewi', 'citra.dewi@email.com', '$2b$10$hashed_password_10', '081122334455', '/images/profile/citra.jpg'),
('Eko Supriyanto', 'eko.supriyanto@email.com', '$2b$10$hashed_password_11', '082233445566', '/images/profile/eko.jpg'),
('Fitri Handayani', 'fitri.handayani@email.com', '$2b$10$hashed_password_12', '083344556677', '/images/profile/fitri.jpg');

-- ===========================
-- 2. INSERT PRODUCT_CATEGORY
-- ===========================
INSERT INTO product_category (name, description) VALUES
('Kopi Arabika', 'Kopi berkualitas tinggi dari berbagai daerah di Indonesia'),
('Kopi Robusta', 'Kopi dengan rasa yang kuat dan body yang full'),
('Specialty Coffee', 'Kopi premium pilihan dengan proses khusus'),
('Minuman Alternatif', 'Minuman non-kopi seperti teh dan herbal'),
('Kopi Instan', 'Kopi instan praktis untuk kemudahan'),
('Merchandise', 'Perlengkapan kopi dan aksesori'),
('Biji Kopi', 'Biji kopi mentah untuk disangrai sendiri'),
('Peralatan Kopi', 'Mesin dan alat untuk menyeduh kopi'),
('Bundle Paket', 'Paket hemat kombinasi produk'),
('Limited Edition', 'Edisi terbatas dengan cita rasa unik');

-- ===========================
-- 3. INSERT VARIANTS
-- ===========================
INSERT INTO variants (name, additional_price) VALUES
('Original', 0.00),
('Dengan Susu', 5000.00),
('Dengan Caramel', 7000.00),
('Dengan Cokelat', 6000.00),
('Dengan Vanilla', 5500.00),
('Double Shot', 8000.00),
('Triple Shot', 12000.00),
('Dengan Madu', 4500.00),
('Dengan Oat Milk', 10000.00),
('Dengan Almond Milk', 9500.00),
('Dengan Coconut Milk', 8500.00),
('Sugar Free', 2000.00);

-- ===========================
-- 4. INSERT SIZES
-- ===========================
INSERT INTO sizes (name, additional_price) VALUES
('Regular (250ml)', 0.00),
('Medium (350ml)', 3000.00),
('Large (500ml)', 6000.00),
('Extra Large (750ml)', 10000.00);

-- ===========================
-- 5. INSERT PRODUCTS
-- ===========================
INSERT INTO products (product_name, description, stock, base_price) VALUES
('Espresso Nusantara', 'Espresso dengan biji kopi pilihan dari Sumatera Utara', 50, 25000.00),
('Americano Sumatra', 'Americano dari biji kopi Arabika Sumatra', 45, 22000.00),
('Flat White Jakarta', 'Espresso dengan microfoam susu segar', 40, 28000.00),
('Cappuccino Premium', 'Cappuccino dengan perbandingan sempurna', 35, 30000.00),
('Latte Kopi Gayo', 'Latte dengan kopi dari Gayo Aceh', 50, 29000.00),
('Macchiato Signature', 'Macchiato dengan espresso double shot', 30, 26000.00),
('Cold Brew Indonesia', 'Cold brew 24 jam dari kopi lokal', 60, 32000.00),
('Affogato Premium', 'Affogato dengan es krim vanilla premium', 25, 35000.00),
('Cortado Perfect', 'Cortado dengan rasio 1:1 espresso dan susu', 35, 24000.00),
('Mocha Cokelat Belgia', 'Mocha dengan cokelat premium', 40, 33000.00),
('Lungo Ritual', 'Lungo dengan ekstraksi panjang', 45, 23000.00),
('Ristretto Kuat', 'Ristretto dengan 2 shot espresso', 30, 27000.00);

-- ===========================
-- 6. INSERT PRODUCT_CATEGORY_MAP (Junction Table)
-- ===========================
INSERT INTO product_category_map (product_id, category_id) VALUES
-- Produk 1-4: Kopi Arabika
(1, 1), (2, 1), (3, 1), (4, 1),
-- Produk 5-8: Specialty Coffee
(5, 3), (6, 3), (7, 3), (8, 3),
-- Produk 9-12: Kopi Robusta & Mixed
(9, 2), (10, 2), (11, 1), (12, 1),
-- Tambahan untuk lebih dari 10 rows
(1, 3), (2, 3), (3, 5), (4, 9), (5, 9), (6, 9), (7, 9), (8, 9);

-- ===========================
-- 7. INSERT PRODUCT_VARIANT (Junction Table)
-- ===========================
INSERT INTO product_variant (product_id, variant_id) VALUES
-- Produk 1 (Espresso Nusantara)
(1, 1), (1, 6), (1, 7),
-- Produk 2 (Americano Sumatra)
(2, 1), (2, 2), (2, 3),
-- Produk 3 (Flat White Jakarta)
(3, 1), (3, 2), (3, 9),
-- Produk 4 (Cappuccino Premium)
(4, 1), (4, 2), (4, 5),
-- Produk 5 (Latte Kopi Gayo)
(5, 1), (5, 2), (5, 8),
-- Produk 6 (Macchiato Signature)
(6, 1), (6, 6), (6, 9),
-- Produk 7 (Cold Brew Indonesia)
(7, 1), (7, 2), (7, 10),
-- Produk 8 (Affogato Premium)
(8, 1), (8, 2), (8, 11),
-- Produk 9 (Cortado Perfect)
(9, 1), (9, 2), (9, 12),
-- Produk 10 (Mocha Cokelat Belgia)
(10, 1), (10, 2), (10, 4),
-- Produk 11 (Lungo Ritual)
(11, 1), (11, 2), (11, 3),
-- Produk 12 (Ristretto Kuat)
(12, 1), (12, 6), (12, 7);

-- ===========================
-- 8. INSERT PRODUCT_SIZES (Junction Table)
-- ===========================
INSERT INTO product_sizes (product_id, size_id) VALUES
-- Produk 1-12: Semua ukuran tersedia
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 1), (2, 2), (2, 3), (2, 4),
(3, 1), (3, 2), (3, 3), (3, 4),
(4, 1), (4, 2), (4, 3), (4, 4),
(5, 1), (5, 2), (5, 3), (5, 4),
(6, 1), (6, 2), (6, 3), (6, 4),
(7, 1), (7, 2), (7, 3), (7, 4),
(8, 1), (8, 2), (8, 3), (8, 4),
(9, 1), (9, 2), (9, 3), (9, 4),
(10, 1), (10, 2), (10, 3), (10, 4),
(11, 1), (11, 2), (11, 3), (11, 4),
(12, 1), (12, 2), (12, 3), (12, 4);

-- ===========================
-- 9. INSERT PRODUCT_IMAGE
-- ===========================
INSERT INTO product_image (product_id, path, is_primary) VALUES
(1, '/images/products/espresso_nusantara_1.jpg', true),
(1, '/images/products/espresso_nusantara_2.jpg', false),
(2, '/images/products/americano_sumatra_1.jpg', true),
(2, '/images/products/americano_sumatra_2.jpg', false),
(3, '/images/products/flat_white_jakarta_1.jpg', true),
(3, '/images/products/flat_white_jakarta_2.jpg', false),
(4, '/images/products/cappuccino_premium_1.jpg', true),
(4, '/images/products/cappuccino_premium_2.jpg', false),
(5, '/images/products/latte_kopi_gayo_1.jpg', true),
(5, '/images/products/latte_kopi_gayo_2.jpg', false),
(6, '/images/products/macchiato_signature_1.jpg', true),
(6, '/images/products/macchiato_signature_2.jpg', false),
(7, '/images/products/cold_brew_1.jpg', true),
(7, '/images/products/cold_brew_2.jpg', false),
(8, '/images/products/affogato_1.jpg', true),
(8, '/images/products/affogato_2.jpg', false),
(9, '/images/products/cortado_1.jpg', true),
(9, '/images/products/cortado_2.jpg', false),
(10, '/images/products/mocha_1.jpg', true),
(10, '/images/products/mocha_2.jpg', false),
(11, '/images/products/lungo_1.jpg', true),
(11, '/images/products/lungo_2.jpg', false),
(12, '/images/products/ristretto_1.jpg', true),
(12, '/images/products/ristretto_2.jpg', false);

-- ===========================
-- 10. INSERT SIZE (Ukuran Minuman)
-- ===========================
INSERT INTO size (label) VALUES
('Small - 250ml'),
('Medium - 350ml'),
('Large - 500ml'),
('Extra Large - 750ml'),
('Jumbo - 1000ml');

-- ===========================
-- 11. INSERT TEMPERATURE
-- ===========================
INSERT INTO temperature (label) VALUES
('Panas (70°C)'),
('Normal (60°C)'),
('Hangat (50°C)'),
('Dingin (Iced)'),
('Sangat Dingin (Extra Ice)');

-- ===========================
-- 12. INSERT ORDERS
-- ===========================
INSERT INTO orders (customer_id, subtotal, tax, delivery_fee, status) VALUES
(1, 75000.00, 7500.00, 10000.00, 'completed'),
(2, 85000.00, 8500.00, 10000.00, 'completed'),
(3, 120000.00, 12000.00, 15000.00, 'completed'),
(4, 65000.00, 6500.00, 10000.00, 'pending'),
(5, 95000.00, 9500.00, 10000.00, 'completed'),
(6, 110000.00, 11000.00, 15000.00, 'shipped'),
(7, 55000.00, 5500.00, 10000.00, 'completed'),
(8, 145000.00, 14500.00, 20000.00, 'processing'),
(9, 75000.00, 7500.00, 10000.00, 'completed'),
(10, 130000.00, 13000.00, 15000.00, 'completed'),
(11, 88000.00, 8800.00, 10000.00, 'shipped'),
(12, 102000.00, 10200.00, 15000.00, 'pending');

-- ===========================
-- 13. INSERT ORDER_DETAIL
-- ===========================
INSERT INTO order_detail (order_id, product_id, size_id, temperature_id, quantity) VALUES
-- Order 1
(1, 1, 1, 4, 2), (1, 5, 2, 1, 1),
-- Order 2
(2, 3, 2, 1, 1), (2, 10, 3, 4, 2),
-- Order 3
(3, 1, 3, 1, 1), (3, 4, 2, 1, 2), (3, 7, 1, 4, 1),
-- Order 4
(4, 6, 1, 1, 2), (4, 9, 2, 1, 1),
-- Order 5
(5, 2, 2, 1, 1), (5, 8, 3, 4, 1), (5, 12, 1, 1, 1),
-- Order 6
(6, 4, 3, 1, 2), (6, 5, 2, 1, 1), (6, 11, 1, 4, 1),
-- Order 7
(7, 3, 1, 1, 2), (7, 6, 2, 1, 1),
-- Order 8
(8, 1, 3, 1, 1), (8, 10, 2, 4, 2), (8, 12, 2, 1, 1),
-- Order 9
(9, 7, 2, 4, 1), (9, 2, 1, 1, 2),
-- Order 10
(10, 4, 3, 1, 1), (10, 8, 2, 4, 1), (10, 11, 3, 1, 2),
-- Order 11
(11, 5, 2, 1, 1), (11, 9, 1, 4, 2),
-- Order 12
(12, 6, 2, 1, 1), (12, 3, 3, 1, 1), (12, 10, 1, 4, 1);

-- ===========================
-- 14. INSERT CART
-- ===========================
INSERT INTO cart (customer_id, product_id, size_id, temperature_id, quantity) VALUES
(1, 4, 2, 1, 1),
(2, 7, 1, 4, 2),
(3, 2, 3, 1, 1),
(4, 10, 2, 4, 1),
(5, 6, 1, 1, 2),
(6, 9, 2, 1, 1),
(7, 12, 3, 4, 1),
(8, 1, 1, 1, 1),
(9, 5, 2, 1, 2),
(10, 8, 3, 4, 1),
(11, 3, 2, 1, 1),
(12, 11, 1, 4, 2);

-- ===========================
-- 15. INSERT PAYMENT
-- ===========================
INSERT INTO payment (order_id, method, amount, status, transaction_id, payment_date) VALUES
(1, 'Credit Card', 92500.00, 'completed', 'TXN-001-20260101', '2026-01-15 10:30:00'),
(2, 'Transfer Bank', 103500.00, 'completed', 'TXN-002-20260102', '2026-01-16 14:20:00'),
(3, 'E-Wallet', 147000.00, 'completed', 'TXN-003-20260103', '2026-01-17 09:45:00'),
(4, 'Credit Card', 81500.00, 'pending', NULL, NULL),
(5, 'Transfer Bank', 114500.00, 'completed', 'TXN-005-20260105', '2026-01-19 16:15:00'),
(6, 'E-Wallet', 136000.00, 'completed', 'TXN-006-20260106', '2026-01-20 11:00:00'),
(7, 'Credit Card', 70500.00, 'completed', 'TXN-007-20260107', '2026-01-21 13:30:00'),
(8, 'Transfer Bank', 179500.00, 'completed', 'TXN-008-20260108', '2026-01-22 08:20:00'),
(9, 'E-Wallet', 92500.00, 'completed', 'TXN-009-20260109', '2026-01-23 15:45:00'),
(10, 'Credit Card', 158000.00, 'completed', 'TXN-010-20260110', '2026-01-24 12:10:00'),
(11, 'Transfer Bank', 106800.00, 'completed', 'TXN-011-20260111', '2026-01-25 10:30:00'),
(12, 'E-Wallet', 127200.00, 'pending', NULL, NULL);

-- ===========================
-- 16. INSERT USER_REVIEW
-- ===========================
INSERT INTO user_review (user_id, product_id, order_id, message, rating) VALUES
(1, 1, 1, 'Espresso yang luar biasa nikmat, biji kopinya terasa berkualitas tinggi!', 5),
(1, 5, 1, 'Latte kopi Gayo sangat enak, microfoam-nya sempurna', 5),
(2, 3, 2, 'Flat white Jakarta terbaik yang pernah saya coba', 5),
(2, 10, 2, 'Mocha dengan cokelat Belgia yang sangat lezat', 4),
(3, 1, 3, 'Espresso original dengan kualitas konsisten', 5),
(3, 4, 3, 'Cappuccino premium, ukuran besar sangat memuaskan', 4),
(3, 7, 3, 'Cold brew yang menyegarkan di cuaca panas', 4),
(4, 6, 4, 'Macchiato signature cukup baik', 3),
(5, 2, 5, 'Americano Sumatra dengan rasa yang balanced', 4),
(5, 8, 5, 'Affogato premium, kombinasi kopi dan es krim sempurna!', 5),
(5, 12, 5, 'Ristretto kuat, perfect untuk kopi lovers', 5),
(6, 4, 6, 'Cappuccino size large, mantap banget', 5);