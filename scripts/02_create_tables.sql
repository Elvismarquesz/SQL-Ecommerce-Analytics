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

-- =====================================================
-- Tabela: order_items 
-- Descrição: Armazena os itens de cada pedido,
-- incluindo produto, vendedor, prazo, preço e frete
-- =====================================================

CREATE TABLE order_items (

    order_id VARCHAR(32),

    order_item_id INTEGER,

    product_id VARCHAR(32),

    seller_id VARCHAR(32),

    shipping_limit_date TIMESTAMP,

    price NUMERIC(10,2),

    freight_value NUMERIC(10,2),

    PRIMARY KEY (order_id, order_item_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)

);

-- =====================================================
-- Tabela: payments
-- Descrição: Armazena os detalhes financeiros de cada pedido.
-- =====================================================

CREATE TABLE payments (

    order_id VARCHAR(32),

    payment_sequential INTEGER,

    payment_type VARCHAR(30),

    payment_installments INTEGER,

    payment_value NUMERIC(10,2),

    PRIMARY KEY (order_id, payment_sequential),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

);

-- =====================================================
-- Tabela: reviews
-- Descrição: armazenar opiniões, notas e comentários de usuários
-- =====================================================

CREATE TABLE reviews (

    review_id VARCHAR(32),

    order_id VARCHAR(32),

    review_score INTEGER,

    review_comment_title TEXT,

    review_comment_message TEXT,

    review_creation_date TIMESTAMP,

    review_answer_timestamp TIMESTAMP,

    PRIMARY KEY (review_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

);

-- =====================================================
-- Tabela: category_translation
-- Descrição: Mapeia os nomes das categorias de produtos
-- em português para o inglês
-- =====================================================

CREATE TABLE category_translation (

    product_category_name VARCHAR(100) PRIMARY KEY,

    product_category_name_english VARCHAR(100)

);