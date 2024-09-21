-- Dimension Tables

CREATE TABLE customer_dim (
    customer_id VARCHAR(30) PRIMARY KEY,
    customer_name VARCHAR(40),
    segment VARCHAR(15),
    country VARCHAR(15),
    city VARCHAR(30),
    state VARCHAR(40),
    region VARCHAR(15)
);

CREATE TABLE product_dim (
    product_id INT PRIMARY KEY,
    category VARCHAR(20),
    subcategory VARCHAR(20),
    product_name VARCHAR(150)
);

CREATE TABLE ship_date_dim (
    ship_date DATE PRIMARY KEY,
    year SMALLINT,
    quarter SMALLINT,
    month SMALLINT,
    month_name VARCHAR(9),
    day SMALLINT,
    day_name VARCHAR(9)
);

CREATE TABLE order_date_dim (
    order_date DATE PRIMARY KEY,
    year SMALLINT,
    quarter SMALLINT,
    month SMALLINT,
    month_name VARCHAR(9),
    day SMALLINT,
    day_name VARCHAR(9)
);

-- Fact Table
CREATE TABLE sales_fact (
    transaction_id VARCHAR(10) PRIMARY KEY,
    order_id INT,
    customer_id VARCHAR(30),
    product_id INT,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(20),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(10,2),
    profit DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id),
    FOREIGN KEY (product_id) REFERENCES product_dim(product_id),
    FOREIGN KEY (order_date) REFERENCES order_date_dim(order_date),
    FOREIGN KEY (ship_date) REFERENCES ship_date_dim(ship_date)
);

-- Indexes for performance
CREATE INDEX idx_transaction_id ON sales_fact (transaction_id);
CREATE INDEX idx_customer_id ON customer_dim (customer_id);
CREATE INDEX idx_product_id ON product_dim (product_id);
CREATE INDEX idx_order_date ON order_date_dim (order_date);
CREATE INDEX idx_ship_date ON ship_date_dim (ship_date);
