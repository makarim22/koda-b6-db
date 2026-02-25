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
CREATE TABLE variants (
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    additional_price DECIMAL(10,2) DEFAULT 0.00
);

CREATE TABLE product_variant (
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    variant_id INT REFERENCES variants(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, variant_id)
);

-- ===========================
-- 4. PRODUCT_SIZE
-- ===========================
CREATE TABLE sizes (
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(50) NOT NULL,
    additional_price DECIMAL(10,2) DEFAULT 0.00
);

CREATE TABLE product_sizes (
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    size_id INT REFERENCES sizes(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, size_id)
);

-- ===========================
-- 5. PRODUCT
-- ===========================
CREATE TABLE products (
    id                 SERIAL PRIMARY KEY,
    product_name       VARCHAR(150) NOT NULL,
    description        TEXT,
    stock              INT NOT NULL DEFAULT 0,
    base_price         DECIMAL(10,2) NOT NULL,
    -- product_variant_id INT,
    -- product_size_id    INT,
    -- FOREIGN KEY (product_variant_id) REFERENCES product_variant(id) ON DELETE SET NULL,
    -- FOREIGN KEY (product_size_id)    REFERENCES product_size(id)    ON DELETE SET NULL
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
