-- =====================================================
-- Tabela: customers
-- Descrição: Armazena informações dos clientes
-- =====================================================

CREATE TABLE customers (

    customer_id VARCHAR(32) PRIMARY KEY,

    customer_unique_id VARCHAR(32) NOT NULL,

    customer_zip_code_prefix INTEGER NOT NULL,

    customer_city VARCHAR(100) NOT NULL,

    customer_state CHAR(2) NOT NULL

);

-- =====================================================
-- Tabela: orders
-- Descrição: Armazena os pedidos realizados pelos clientes
-- =====================================================

CREATE TABLE orders (

    order_id VARCHAR(32) PRIMARY KEY,

    customer_id VARCHAR(32) NOT NULL,

    order_status VARCHAR(20) NOT NULL,

    order_purchase_timestamp TIMESTAMP NOT NULL,

    order_approved_at TIMESTAMP,

    order_delivered_carrier_date TIMESTAMP,

    order_delivered_customer_date TIMESTAMP,

    order_estimated_delivery_date TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)

);

-- =====================================================
-- Tabela: products
-- Descrição: Armazena informações dos produtos
-- =====================================================

CREATE TABLE products (

    product_id VARCHAR(32) PRIMARY KEY,

    product_category_name VARCHAR(100),

    product_name_length INTEGER,

    product_description_length INTEGER,

    product_photos_qty INTEGER,

    product_weight_g NUMERIC,

    product_length_cm NUMERIC,

    product_height_cm NUMERIC,

    product_width_cm NUMERIC

);

-- =====================================================
-- Tabela: sellers 
-- Descrição: Armazena informações dos vendedores
-- =====================================================

CREATE TABLE sellers (

    seller_id VARCHAR(32) PRIMARY KEY,

    seller_zip_code_prefix INTEGER NOT NULL,

    seller_city VARCHAR(100) NOT NULL,

    seller_state CHAR(2) NOT NULL

);

