-- Table: user
CREATE TABLE IF NOT EXISTS "user" (
    user_uuid UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255),
    gender VARCHAR(10) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    address TEXT NOT NULL,
    user_name VARCHAR(50) UNIQUE,
    user_details_json JSONB,
    insert_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_ts TIMESTAMP,
    is_deleted BOOLEAN,
    profile_picture BYTEA
);

-- Table: category_md
CREATE TABLE IF NOT EXISTS category_md (
    category_uuid UUID PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE,
    category_description TEXT
);

-- Table: sub_category_md
CREATE TABLE IF NOT EXISTS sub_category_md (
    sub_category_uuid UUID PRIMARY KEY,
    category_uuid UUID REFERENCES category_md(category_uuid),
    sub_category_name VARCHAR(255) UNIQUE,
    sub_category_description TEXT,
    sub_category_features VARCHAR[]
);

-- Table: product_details
CREATE TABLE IF NOT EXISTS product_details (
    product_uuid UUID PRIMARY KEY,
    sub_category_uuid UUID REFERENCES sub_category_md(sub_category_uuid),
    product_name VARCHAR(255),
    product_price DECIMAL(10, 2),
    product_brand VARCHAR(255),
    product_features JSONB,
    product_image BYTEA,
    product_location JSONB,
    insert_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_ts TIMESTAMP
);

-- Table: user_product_mapping
CREATE TABLE IF NOT EXISTS user_product_mapping (
    user_product_map_uuid UUID PRIMARY KEY,
    user_uuid UUID REFERENCES "user"(user_uuid),
    product_uuid UUID REFERENCES product_details(product_uuid),
    insert_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_ts TIMESTAMP,
    is_draft BOOLEAN,
    is_active BOOLEAN
);

-- Table: orders
CREATE TABLE IF NOT EXISTS orders (
    order_uuid UUID PRIMARY KEY,
    buyer_uuid UUID REFERENCES "user"(user_uuid),
    seller_uuid UUID REFERENCES "user"(user_uuid),
    product_uuid UUID REFERENCES product_details(product_uuid),
    order_additional_info JSONB,
    insert_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_ts TIMESTAMP,
    order_date TIMESTAMP,
    order_status VARCHAR(50)
);
