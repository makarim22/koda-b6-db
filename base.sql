-- ===========================
-- 1. USERS
-- ===========================
CREATE TABLE users (
    id            SERIAL PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password      VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    profile_image VARCHAR(255),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================
-- 2. PRODUCT_CATEGORY
-- ===========================
CREATE TABLE product_category (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description TEXT
);

-- ===========================
-- 3. PRODUCT_VARIANT
-- ===========================
CREATE TABLE product_variant (
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    additional_price DECIMAL(10,2) DEFAULT 0.00
);

-- ===========================
-- 4. PRODUCT_SIZE
-- ===========================
CREATE TABLE product_size (
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(50) NOT NULL,
    additional_price DECIMAL(10,2) DEFAULT 0.00
);

-- ===========================
-- 5. PRODUCT
-- ===========================
CREATE TABLE product (
    id                 SERIAL PRIMARY KEY,
    product_name       VARCHAR(150) NOT NULL,
    description        TEXT,
    stock              INT NOT NULL DEFAULT 0,
    base_price         DECIMAL(10,2) NOT NULL,
    product_variant_id INT,
    product_size_id    INT,
    FOREIGN KEY (product_variant_id) REFERENCES product_variant(id) ON DELETE SET NULL,
    FOREIGN KEY (product_size_id)    REFERENCES product_size(id)    ON DELETE SET NULL
);

-- ===========================
-- 6. PRODUCT_CATEGORY_MAP
-- ===========================
CREATE TABLE product_category_map (
    id          SERIAL PRIMARY KEY,
    product_id  INT NOT NULL,
    category_id INT NOT NULL,
    UNIQUE (product_id, category_id),
    FOREIGN KEY (product_id)  REFERENCES product(id)          ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES product_category(id) ON DELETE CASCADE
);

-- ===========================
-- 7. PRODUCT_IMAGE
-- ===========================
CREATE TABLE product_image (
    id         SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    path       VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);

-- ===========================
-- 8. SIZE
-- ===========================
CREATE TABLE size (
    id    SERIAL PRIMARY KEY,
    label VARCHAR(50) NOT NULL
);

-- ===========================
-- 9. TEMPERATURE
-- ===========================
CREATE TABLE temperature (
    id    SERIAL PRIMARY KEY,
    label VARCHAR(50) NOT NULL
);

-- ===========================
-- 10. ORDERS
-- renamed from "order" to avoid reserved word conflict
-- ===========================
CREATE TABLE orders (
    id           SERIAL PRIMARY KEY,
    customer_id  INT NOT NULL,
    order_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    subtotal     DECIMAL(10,2) NOT NULL,
    tax          DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    delivery_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status       VARCHAR(50)   NOT NULL DEFAULT 'pending',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE RESTRICT
);

-- ===========================
-- 11. ORDER_DETAIL
-- ===========================
CREATE TABLE order_detail (
    id             SERIAL PRIMARY KEY,
    order_id       INT NOT NULL,
    product_id     INT NOT NULL,
    size_id        INT,
    temperature_id INT,
    quantity       INT NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id)       REFERENCES orders(id)       ON DELETE CASCADE,
    FOREIGN KEY (product_id)     REFERENCES product(id)      ON DELETE RESTRICT,
    FOREIGN KEY (size_id)        REFERENCES size(id)         ON DELETE SET NULL,
    FOREIGN KEY (temperature_id) REFERENCES temperature(id)  ON DELETE SET NULL
);

-- ===========================
-- 12. CART
-- ===========================
CREATE TABLE cart (
    id             SERIAL PRIMARY KEY,
    customer_id    INT NOT NULL,
    product_id     INT NOT NULL,
    size_id        INT,
    temperature_id INT,
    quantity       INT NOT NULL DEFAULT 1,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id)    REFERENCES users(id)        ON DELETE CASCADE,
    FOREIGN KEY (product_id)     REFERENCES product(id)      ON DELETE CASCADE,
    FOREIGN KEY (size_id)        REFERENCES size(id)         ON DELETE SET NULL,
    FOREIGN KEY (temperature_id) REFERENCES temperature(id)  ON DELETE SET NULL
);

-- ===========================
-- 13. PAYMENT
-- ===========================
CREATE TABLE payment (
    id             SERIAL PRIMARY KEY,
    order_id       INT NOT NULL,
    method         VARCHAR(50)   NOT NULL,
    amount         DECIMAL(10,2) NOT NULL,
    status         VARCHAR(50)   NOT NULL DEFAULT 'pending',
    transaction_id VARCHAR(150)  UNIQUE,
    payment_date   TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE RESTRICT
);

-- ===========================
-- 14. USER_REVIEW
-- ===========================
CREATE TABLE user_review (
    id         SERIAL PRIMARY KEY,
    user_id    INT NOT NULL,
    product_id INT NOT NULL,
    order_id   INT NOT NULL,
    message    TEXT,
    rating     INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id)  ON DELETE CASCADE,
    FOREIGN KEY (order_id)   REFERENCES orders(id)   ON DELETE CASCADE
);


-- ===========================
-- 1. USERS
-- ===========================
INSERT INTO users (full_name, email, password, phone, profile_image) VALUES
('Budi Santoso',    'budi.santoso@gmail.com',    'hashed_pw_budi',    '081234567890', 'profiles/budi.jpg'),
('Siti Rahayu',     'siti.rahayu@gmail.com',     'hashed_pw_siti',    '082345678901', 'profiles/siti.jpg'),
('Andi Wijaya',     'andi.wijaya@gmail.com',      'hashed_pw_andi',    '083456789012', 'profiles/andi.jpg'),
('Dewi Kusuma',     'dewi.kusuma@gmail.com',      'hashed_pw_dewi',    '084567890123', 'profiles/dewi.jpg'),
('Raka Pratama',    'raka.pratama@gmail.com',     'hashed_pw_raka',    '085678901234', 'profiles/raka.jpg'),
('Fajar Nugroho',   'fajar.nugroho@gmail.com',    'hashed_pw_fajar',   '086789012345', 'profiles/fajar.jpg'),
('Laila Anggraini', 'laila.anggraini@gmail.com',  'hashed_pw_laila',   '087890123456', 'profiles/laila.jpg'),
('Hendra Gunawan',  'hendra.gunawan@gmail.com',   'hashed_pw_hendra',  '088901234567', 'profiles/hendra.jpg'),
('Maya Putri',      'maya.putri@gmail.com',       'hashed_pw_maya',    '089012345678', 'profiles/maya.jpg'),
('Rizky Ramadhan',  'rizky.ramadhan@gmail.com',   'hashed_pw_rizky',   '081122334455', 'profiles/rizky.jpg');

-- ===========================
-- 2. PRODUCT_CATEGORY
-- ===========================
INSERT INTO product_category (name, description) VALUES
('Kopi',          'Minuman berbasis espresso dan kopi'),
('Non-Kopi',      'Minuman tanpa kandungan kopi'),
('Teh',           'Minuman berbasis teh lokal dan impor'),
('Minuman Dingin', 'Minuman segar disajikan dingin atau iced'),
('Minuman Panas',  'Minuman hangat dan panas'),
('Signature',      'Menu andalan eksklusif kedai kami'),
('Seasonal',       'Menu spesial terbatas sesuai musim'),
('Makanan Ringan', 'Camilan dan snack pendamping minuman'),
('Pastri',         'Kue dan roti segar dipanggang setiap hari'),
('Sehat',          'Minuman rendah kalori dan bergizi tinggi');

-- ===========================
-- 3. PRODUCT_VARIANT
-- ===========================
INSERT INTO product_variant (name, additional_price) VALUES
('Ice',         2000.00),
('Hot',         0.00),
('Signature',   10000.00);


-- ===========================
-- 4. PRODUCT_SIZE
-- ===========================
INSERT INTO product_size (name, additional_price) VALUES
('Small',        0.00),
('Medium',    5000.00),
('Large',    10000.00),
('Extra Large', 15000.00),
('Regular',         0.00),
('Mini',     -2000.00),
('Tall',      7000.00),
('Grande',    9000.00),
('Venti',    12000.00),
('Traveler', 50000.00);

-- ===========================
-- 5. PRODUCT
-- ===========================
INSERT INTO product (product_name, description, stock, base_price, product_variant_id, product_size_id) VALUES
('Espresso',           'Kopi hitam pekat single shot berkualitas tinggi',        50, 20000.00, 1, 1),
('Cappuccino',         'Espresso dengan steamed milk dan foam lembut',           40, 28000.00, 2, 2),
('Matcha Latte',       'Teh matcha premium Jepang dengan susu segar',            35, 32000.00, 3, 2),
('Americano',          'Espresso diencerkan air panas, rasa kopi kuat',          45, 22000.00, 1, 1),
('Coklat Panas',       'Coklat Belgia asli dengan susu full cream',             30, 30000.00, 2, 2),
('Thai Tea',           'Teh Thai otentik dengan susu kental manis',             40, 25000.00, 1, 2),
('Caramel Macchiato',  'Vanilla latte dengan drizzle karamel manis',            25, 35000.00, 3, 3),
('Taro Latte',         'Minuman taro ungu creamy dengan susu segar',            20, 33000.00, 2, 2),
('Croissant Butter',   'Croissant mentega panggang renyah dan berlapis',         60, 25000.00, 1, 1),
('Lemon Tea Madu',     'Teh lemon segar dipadu madu asli hutan',                50, 20000.00, 1, 2),
('Smoothie Alpukat',   'Smoothie alpukat creamy dengan susu dan madu',          15, 38000.00, 2, 2),
('Tiramisu Latte',     'Latte dengan cita rasa tiramisu khas Italia',            20, 40000.00, 3, 3),
('Banana Bread',       'Roti pisang lembut harum dengan topping butter',         30, 22000.00, 1, 1),
('Strawberry Frappe',  'Frappe stroberi segar dengan whipped cream tebal',       18, 36000.00, 2, 3),
('Oat Latte',          'Espresso dengan oat milk sehat rendah lemak',            25, 34000.00, 5, 2);

-- ===========================
-- 6. PRODUCT_CATEGORY_MAP
-- ===========================
INSERT INTO product_category_map (product_id, category_id) VALUES
(1,  1),  -- Espresso         → Kopi
(1,  5),  -- Espresso         → Minuman Panas
(2,  1),  -- Cappuccino       → Kopi
(2,  5),  -- Cappuccino       → Minuman Panas
(3,  3),  -- Matcha Latte     → Teh
(3,  4),  -- Matcha Latte     → Minuman Dingin
(3,  2),  -- Matcha Latte     → Non-Kopi
(4,  1),  -- Americano        → Kopi
(4,  5),  -- Americano        → Minuman Panas
(5,  2),  -- Coklat Panas     → Non-Kopi
(5,  5),  -- Coklat Panas     → Minuman Panas
(6,  3),  -- Thai Tea         → Teh
(6,  4),  -- Thai Tea         → Minuman Dingin
(7,  1),  -- Caramel Macchiato→ Kopi
(7,  6),  -- Caramel Macchiato→ Signature
(8,  2),  -- Taro Latte       → Non-Kopi
(8,  4),  -- Taro Latte       → Minuman Dingin
(9,  8),  -- Croissant Butter → Makanan Ringan
(9,  9),  -- Croissant Butter → Pastri
(10, 3),  -- Lemon Tea Madu   → Teh
(10, 4),  -- Lemon Tea Madu   → Minuman Dingin
(10,10),  -- Lemon Tea Madu   → Sehat
(11, 2),  -- Smoothie Alpukat → Non-Kopi
(11,10),  -- Smoothie Alpukat → Sehat
(12, 1),  -- Tiramisu Latte   → Kopi
(12, 6),  -- Tiramisu Latte   → Signature
(13, 8),  -- Banana Bread     → Makanan Ringan
(13, 9),  -- Banana Bread     → Pastri
(14, 4),  -- Strawberry Frappe→ Minuman Dingin
(14, 7),  -- Strawberry Frappe→ Seasonal
(15, 1),  -- Oat Latte        → Kopi
(15,10);  -- Oat Latte        → Sehat

-- ===========================
-- 7. PRODUCT_IMAGE
-- ===========================
INSERT INTO product_image (product_id, path, is_primary) VALUES
(1,  'images/products/espresso_1.jpg',          TRUE),
(2,  'images/products/cappuccino_1.jpg',        TRUE),
(2,  'images/products/cappuccino_2.jpg',        FALSE),
(3,  'images/products/matcha_latte_1.jpg',      TRUE),
(3,  'images/products/matcha_latte_2.jpg',      FALSE),
(4,  'images/products/americano_1.jpg',         TRUE),
(5,  'images/products/coklat_panas_1.jpg',      TRUE),
(6,  'images/products/thai_tea_1.jpg',          TRUE),
(6,  'images/products/thai_tea_2.jpg',          FALSE),
(7,  'images/products/caramel_mac_1.jpg',       TRUE),
(7,  'images/products/caramel_mac_2.jpg',       FALSE),
(8,  'images/products/taro_latte_1.jpg',        TRUE),
(9,  'images/products/croissant_1.jpg',         TRUE),
(10, 'images/products/lemon_tea_madu_1.jpg',    TRUE),
(11, 'images/products/smoothie_alpukat_1.jpg',  TRUE),
(12, 'images/products/tiramisu_latte_1.jpg',    TRUE),
(13, 'images/products/banana_bread_1.jpg',      TRUE),
(14, 'images/products/strawberry_frappe_1.jpg', TRUE),
(15, 'images/products/oat_latte_1.jpg',         TRUE);

-- ===========================
-- 8. SIZE
-- ===========================
INSERT INTO size (label) VALUES
('Small'),
('Medium'),
('Large'),
('Extra Large'),
('Shot'),
('Mini'),
('Tall'),
('Grande'),
('Venti'),
('Traveler');

-- ===========================
-- 9. TEMPERATURE
-- ===========================
INSERT INTO temperature (label) VALUES
('Panas'),
('Dingin'),
('Blend'),
('Hangat'),
('Extra Panas'),
('Kurang Es'),
('Tanpa Es'),
('Suhu Ruangan'),
('Frozen'),
('Steam');

-- ===========================
-- 10. ORDERS
-- ===========================
INSERT INTO orders (customer_id, subtotal, tax, delivery_fee, status) VALUES
(1,  56000.00,   5600.00, 10000.00, 'completed'),
(2,  90000.00,   9000.00, 15000.00, 'completed'),
(3,  32000.00,   3200.00, 10000.00, 'processing'),
(4,  83000.00,   8300.00, 12000.00, 'completed'),
(5,  33000.00,   3300.00, 10000.00, 'pending'),
(1,  57000.00,   5700.00, 10000.00, 'completed'),
(6,  75000.00,   7500.00, 12000.00, 'completed'),
(7,  65000.00,   6500.00, 10000.00, 'completed'),
(8,  88000.00,   8800.00, 15000.00, 'processing'),
(9,  40000.00,   4000.00, 10000.00, 'completed'),
(10, 120000.00, 12000.00, 20000.00, 'completed'),
(2,  28000.00,   2800.00, 10000.00, 'cancelled');

-- ===========================
-- 11. ORDER_DETAIL
-- ===========================
INSERT INTO order_detail (order_id, product_id, size_id, temperature_id, quantity) VALUES
(1,  1,  1, 1, 2),   -- Order 1  : 2x Espresso Small Panas
(1,  2,  2, 1, 1),   -- Order 1  : 1x Cappuccino Medium Panas
(2,  3,  2, 2, 2),   -- Order 2  : 2x Matcha Latte Medium Dingin
(2,  7,  3, 2, 1),   -- Order 2  : 1x Caramel Macchiato Large Dingin
(3,  3,  2, 2, 1),   -- Order 3  : 1x Matcha Latte Medium Dingin
(4,  5,  2, 1, 1),   -- Order 4  : 1x Coklat Panas Medium Panas
(4,  6,  2, 2, 1),   -- Order 4  : 1x Thai Tea Medium Dingin
(4,  4,  1, 1, 1),   -- Order 4  : 1x Americano Small Panas
(5,  8,  2, 3, 1),   -- Order 5  : 1x Taro Latte Medium Blend
(6,  1,  1, 1, 1),   -- Order 6  : 1x Espresso Small Panas
(6,  6,  2, 2, 1),   -- Order 6  : 1x Thai Tea Medium Dingin
(7,  12, 3, 1, 1),   -- Order 7  : 1x Tiramisu Latte Large Panas
(7,  9,  1, 8, 2),   -- Order 7  : 2x Croissant Small Suhu Ruangan
(8,  11, 2, 3, 1),   -- Order 8  : 1x Smoothie Alpukat Medium Blend
(8,  14, 3, 3, 1),   -- Order 8  : 1x Strawberry Frappe Large Blend
(9,  10, 2, 2, 2),   -- Order 9  : 2x Lemon Tea Madu Medium Dingin
(10, 7,  3, 2, 2),   -- Order 10 : 2x Caramel Macchiato Large Dingin
(10, 13, 1, 8, 3),   -- Order 10 : 3x Banana Bread Small Suhu Ruangan
(11, 15, 2, 1, 2),   -- Order 11 : 2x Oat Latte Medium Panas
(12, 2,  2, 1, 1);   -- Order 12 : 1x Cappuccino Medium Panas

-- ===========================
-- 12. CART
-- ===========================
INSERT INTO cart (customer_id, product_id, size_id, temperature_id, quantity) VALUES
(3,  7,  3, 2, 1),   -- Andi  : Caramel Macchiato Large Dingin
(4,  8,  2, 3, 2),   -- Dewi  : Taro Latte Medium Blend x2
(5,  2,  2, 1, 1),   -- Raka  : Cappuccino Medium Panas
(6,  12, 3, 1, 1),   -- Fajar : Tiramisu Latte Large Panas
(7,  11, 2, 3, 1),   -- Laila : Smoothie Alpukat Medium Blend
(8,  14, 3, 3, 2),   -- Hendra: Strawberry Frappe Large Blend x2
(9,  15, 2, 1, 1),   -- Maya  : Oat Latte Medium Panas
(10, 9,  1, 8, 3),   -- Rizky : Croissant Small Suhu Ruangan x3
(1,  6,  2, 2, 2),   -- Budi  : Thai Tea Medium Dingin x2
(2,  3,  2, 2, 1);   -- Siti  : Matcha Latte Medium Dingin

-- ===========================
-- 13. PAYMENT
-- ===========================
INSERT INTO payment (order_id, method, amount, status, transaction_id, payment_date) VALUES
(1,  'GoPay',           71600.00,  'success', 'TXN-GP-20250101', '2025-01-10 10:30:00'),
(2,  'Virtual Account', 114000.00, 'success', 'TXN-VA-20250102', '2025-01-11 13:45:00'),
(3,  'DANA',            45200.00,  'pending',  NULL,              NULL),
(4,  'Kartu Kredit',   103300.00,  'success', 'TXN-KC-20250104', '2025-01-13 09:15:00'),
(5,  'GoPay',           46300.00,  'pending',  NULL,              NULL),
(6,  'OVO',             72700.00,  'success', 'TXN-OV-20250106', '2025-01-15 11:00:00'),
(7,  'ShopeePay',       94500.00,  'success', 'TXN-SP-20250107', '2025-01-16 14:00:00'),
(8,  'Virtual Account', 111800.00, 'success', 'TXN-VA-20250108', '2025-01-17 13:00:00'),
(9,  'GoPay',           54000.00,  'failed',  'TXN-GP-20250109', '2025-01-18 09:00:00'),
(9,  'DANA',            54000.00,  'success', 'TXN-DN-20250109', '2025-01-18 09:30:00'),
(10, 'Kartu Kredit',   152000.00,  'success', 'TXN-KC-20250110', '2025-01-19 15:00:00'),
(11, 'OVO',             89500.00,  'success', 'TXN-OV-20250111', '2025-01-20 10:00:00'),
(12, 'GoPay',           40800.00,  'failed',  'TXN-GP-20250112', '2025-01-21 08:00:00');

-- ===========================
-- 14. USER_REVIEW
-- ===========================
INSERT INTO user_review (user_id, product_id, order_id, message, rating) VALUES
(1,  1,  1,  'Espresso-nya mantap banget, pekat dan wanginya khas!',           5),
(1,  2,  1,  'Cappuccino enak, foam-nya lembut dan pas di lidah.',             4),
(2,  3,  2,  'Matcha Latte-nya segar banget, rasa matcha-nya kuat dan asli.',  5),
(2,  7,  2,  'Caramel Macchiato juara! Manisnya pas, tidak enek.',             5),
(4,  5,  4,  'Coklat Panas-nya creamy dan hangat, cocok di malam hari.',       4),
(4,  6,  4,  'Thai Tea-nya autentik seperti di Thailand, recommended!',        5),
(1,  1,  6,  'Espresso selalu jadi pilihan utama saya setiap pagi.',           5),
(7,  12, 7,  'Tiramisu Latte-nya unik dan berbeda, wajib dicoba!',             5),
(7,  9,  7,  'Croissant-nya renyah di luar, lembut di dalam. Butternya kerasa!',4),
(9,  10, 9,  'Lemon Tea Madu-nya segar, kombinasi lemon dan madunya pas.',     4),
(10, 7,  10, 'Caramel Macchiato-nya worth it banget, harga sebanding kualitas.',4),
(10, 13, 10, 'Banana Bread-nya lembut dan harum, enak dimakan hangat-hangat.', 5);