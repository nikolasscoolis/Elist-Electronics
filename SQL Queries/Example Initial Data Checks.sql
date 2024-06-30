-- Utilizing dataset for the first time, performing checks for inconsistencies, errors, and general data ranges

-- 1) Duplicate Orders Check

SELECT
    orders.id,
    COUNT(*) AS order_id_count
FROM core.orders
GROUP BY 1
HAVING order_id_count > 1;


-- 2) Null Check

SELECT
    SUM(CASE WHEN orders.customer_id IS NULL THEN 1 ELSE 0 END) AS nullcount_cust_id,
    SUM(CASE WHEN orders.id IS NULL THEN 1 ELSE 0 END) AS nullcount_order_id,
    SUM(CASE WHEN orders.purchase_ts IS NULL THEN 1 ELSE 0 END) AS nullcount_purchase_ts,
    SUM(CASE WHEN orders.product_id IS NULL THEN 1 ELSE 0 END) AS nullcount_product_id,
    SUM(CASE WHEN orders.product_name IS NULL THEN 1 ELSE 0 END) AS nullcount_product_name,
    SUM(CASE WHEN orders.currency IS NULL THEN 1 ELSE 0 END) AS nullcount_currency,
    SUM(CASE WHEN orders.local_price IS NULL THEN 1 ELSE 0 END) AS nullcount_local_price,
    SUM(CASE WHEN orders.usd_price IS NULL THEN 1 ELSE 0 END) AS nullcount_usd_price,
    SUM(CASE WHEN orders.purchase_platform IS NULL THEN 1 ELSE 0 END) AS nullcount_purchase_platform
FROM core.orders
;

-- 3) Checking Distinct Product Names, Purchase Platforms, Countries & Regions, Marketing Platforms, and Loyalty Designation For Familiarity And Finding Irregularities 

SELECT
    DISTINCT product_name
FROM core.orders
ORDER BY 1
;

SELECT
    DISTINCT purchase_platform
FROM core.orders
ORDER BY 1
;

SELECT
    DISTINCT customers.country_code,
    geo_lookup.region
FROM core.customers
LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country
ORDER BY 1
;

SELECT
    DISTINCT customers.country_code,
    COUNT(customers.country_code) AS countnull
FROM core.customers
LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country 
WHERE geo_lookup.region IS NULL
GROUP BY 1
;

SELECT
    DISTINCT marketing_channel,
    COUNT(marketing_channel) AS count_of_marketing
FROM core.customers
GROUP BY 1
ORDER BY 1
;

SELECT
    DISTINCT loyalty_program
FROM core.customers
ORDER BY 1
;

-- 4) Purchase, Shipping, Delivery, Refund, and Account Created Date Ranges To Understand Time Frames

SELECT
    MIN(purchase_ts) AS earliest_order_date,
    MAX(purchase_ts) AS latest_order_date,
    MIN(ship_ts) AS earliest_ship_date,
    MAX(ship_ts) AS latest_ship_date,
    MIN(delivery_ts) AS earliest_delivery_date,
    MAX(delivery_ts) AS latest_delivery_date,
    MIN(refund_ts) AS earliest_return_date,
    MAX(refund_ts) AS latest_return_date
FROM core.order_status
;

SELECT
    MIN(created_on) AS earliest_created_on,
    MAX(created_on) AS latest_created_on
FROM core.customers
;

-- 5) Price Ranges

SELECT
    MIN(usd_price) AS smallest_price,
    MAX(usd_price) AS largest_price
FROM core.orders
;

SELECT
    usd_price,
    COUNT(*) AS count_of_orders
FROM core.orders
WHERE usd_price = 0
GROUP BY 1
;
