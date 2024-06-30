-- Cleaning, combining, and organzing data for use

-- During intial checks we discovered inconsistency in product names

WITH cleaned_product AS (
  SELECT
    orders.customer_id,
    orders.id AS order_id,
    orders.purchase_ts AS purchase_date,
    orders.product_id,
    CASE WHEN LOWER(orders.product_name) LIKE '%gaming monitor%' THEN '27 inch Gaming Monitor' 
    WHEN LOWER(orders.product_name) LIKE '%macbook%' THEN 'Apple Macbook Air Laptop'
    WHEN LOWER(orders.product_name) LIKE '%thinkpad%' THEN 'Lenovo ThinkPad Laptop'
    WHEN LOWER(orders.product_name) LIKE '%bose%' THEN 'Bose Soundsport Headphones' 
    ELSE orders.product_name END AS product_name,
    UPPER(orders.currency) AS currency,
    orders.local_price,
    orders.usd_price,
    orders.purchase_platform
  FROM core.orders
),

-- After cleaning product_name, adding columns for product category and brand name

cleaned_orders AS (
  SELECT 
    *,
    CASE WHEN LOWER(cleaned_product.product_name) LIKE '%apple%' THEN 'Apple'
    WHEN LOWER(cleaned_product.product_name) LIKE '%samsung%' THEN 'Samsung'
    WHEN LOWER(cleaned_product.product_name) LIKE '%lenovo%' THEN 'Lenovo'
    WHEN LOWER(cleaned_product.product_name) LIKE '%bose%' THEN 'Bose'
    ELSE 'Unknown' END AS brand_name,
    CASE WHEN LOWER(cleaned_product.product_name) LIKE '%headphones%' THEN 'Headphones'
    WHEN LOWER(cleaned_product.product_name) LIKE '%laptop%' THEN 'Laptop'
    WHEN LOWER(cleaned_product.product_name) LIKE '%iphone%' THEN 'Cell Phone'
    WHEN LOWER(cleaned_product.product_name) LIKE '%monitor%' THEN 'Monitor'
    ELSE 'Accessories' END AS product_category,
    ROW_NUMBER() OVER (PARTITION BY cleaned_product.customer_id ORDER BY cleaned_product.purchase_date) AS customer_order_number,
    EXTRACT(YEAR FROM cleaned_product.purchase_date) AS year,
    CASE WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 1 THEN 'January'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 2 THEN 'February'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 3 THEN 'March'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 4 THEN 'April'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 5 THEN 'May'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 6 THEN 'June'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 7 THEN 'July'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 8 THEN 'August'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 9 THEN 'September'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 10 THEN 'October'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 11 THEN 'November'
    WHEN EXTRACT(MONTH FROM cleaned_product.purchase_date) = 12 THEN 'December'
    ELSE NULL END AS month
    FROM cleaned_product
),

cleaned_customers AS (
  SELECT
    customers.id AS customer_id,
    customers.marketing_channel,
    customers.account_creation_method,
    UPPER(customers.country_code) AS country_code,
    customers.loyalty_program,
    customers.created_on
  FROM
    core.customers
),

-- Checks showed inconsistencies in two regions

cleaned_geo_lookup AS (
  SELECT
    geo_lookup.country,
    CASE WHEN UPPER(geo_lookup.country) = 'EU' THEN 'EMEA'
    WHEN UPPER(geo_lookup.country) = 'A1' THEN 'Unknown'
    ELSE geo_lookup.region END AS region
  FROM
    core.geo_lookup
),

-- Adding metric for refunds and operation efficiency times, found negative duration so cleaned

cleaned_order_status AS (
  SELECT
    order_status.order_id AS order_id,
    order_status.purchase_ts AS purchase_date,
    order_status.ship_ts AS shipping_date,
    order_status.delivery_ts AS delivery_date,
    order_status.refund_ts AS refund_date,
    CASE WHEN order_status.refund_ts IS NOT NULL THEN 1 ELSE 0 END AS refunded,
    CASE WHEN DATE_DIFF(order_status.ship_ts, order_status.purchase_ts, day) < 0 THEN NULL ELSE DATE_DIFF(order_status.ship_ts, order_status.purchase_ts, day) END AS days_to_ship,
    CASE WHEN DATE_DIFF(order_status.delivery_ts, order_status.ship_ts, day) < 0 THEN NULL ELSE DATE_DIFF(order_status.delivery_ts, order_status.ship_ts, day) END AS shipping_time,
    CASE WHEN DATE_DIFF(order_status.refund_ts, order_status.delivery_ts, day) < 0 THEN NULL ELSE DATE_DIFF(order_status.refund_ts, order_status.delivery_ts, day) END AS days_to_return,
    CASE WHEN DATE_DIFF(order_status.purchase_ts, customers.created_on, day) < 0 THEN NULL ELSE DATE_DIFF(order_status.purchase_ts, customers.created_on, day) END AS days_to_order
  FROM core.order_status
  LEFT JOIN core.orders
   ON order_status.order_id = orders.id
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
)

SELECT 
  cleaned_orders.order_id,
  cleaned_orders.customer_id,
  cleaned_orders.purchase_date,
  cleaned_orders.product_id,
  cleaned_orders.product_name, 
  cleaned_orders.brand_name,
  cleaned_orders.product_category,        
  cleaned_orders.currency,
  cleaned_orders.local_price,
  cleaned_orders.usd_price,
  cleaned_orders.purchase_platform,
  cleaned_orders.customer_order_number,
  cleaned_orders.year,
  cleaned_orders.month,
  cleaned_customers.marketing_channel,
  cleaned_customers.account_creation_method,
  cleaned_customers.loyalty_program,
  cleaned_customers.created_on,
  cleaned_order_status.shipping_date,
  cleaned_order_status.delivery_date,
  cleaned_order_status.refund_date,
  cleaned_order_status.refunded,
  cleaned_order_status.days_to_ship,
  cleaned_order_status.shipping_time,
  cleaned_order_status.days_to_return,
  cleaned_order_status.days_to_order,
  cleaned_geo_lookup.country,
  cleaned_geo_lookup.region
FROM cleaned_orders
LEFT JOIN cleaned_customers
  ON cleaned_orders.customer_id = cleaned_customers.customer_id
LEFT JOIN cleaned_geo_lookup
  ON cleaned_geo_lookup.country = cleaned_customers.country_code
LEFT JOIN cleaned_order_status
  ON cleaned_order_status.order_id = cleaned_orders.order_id
;
