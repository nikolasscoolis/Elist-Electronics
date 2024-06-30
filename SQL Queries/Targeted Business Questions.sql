

-- What is the average quarterly order count and total sales for Macbooks sold in North America? (i.e. “For North America Macbooks, average of X units sold per quarter and Y in dollar sales per quarter”)

WITH quarterly_metrics AS (
  SELECT
  DATE_TRUNC(orders.purchase_ts, quarter) AS quarter,
  COUNT(orders.id) AS order_count,
  ROUND(SUM(orders.usd_price),2) AS sales_volume,
  ROUND(AVG(orders.usd_price),2) AS AOV
FROM core.orders
LEFT JOIN core.customers
ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country
WHERE lower(orders.product_name) LIKE '%macbook%'
AND lower(geo_lookup.region) LIKE '%na%'
GROUP BY 1
ORDER BY 1
)

SELECT
  ROUND(AVG(order_count),2) AS average_quarterly_orders,
  ROUND(AVG(sales_volume),2) AS average_quarterly_sales
FROM quarterly_metrics
;

-- Which region has the average highest time to deliver for website purchases made in 2022 or Samsung purchases made in 2021, expressing time to deliver in weeks.

SELECT
  geo_lookup.region,
  ROUND(AVG(DATE_DIFF(order_status.delivery_ts, order_status.purchase_ts, week)),2) AS weeks_to_deliver,
FROM core.orders
LEFT JOIN core.order_status
ON orders.id = order_status.order_id
LEFT JOIN core.customers
ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup
ON customers.country_code = geo_lookup.country
WHERE (EXTRACT(year FROM orders.purchase_ts) = 2022 AND lower(orders.purchase_platform) = 'website') OR (EXTRACT(year FROM orders.purchase_ts) = 2021 AND lower(orders.product_name) LIKE '%samsung%') AND geo_lookup.region IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
;

-- What was the refund rate and refund count for each product per year?

SELECT
  EXTRACT(year FROM orders.purchase_ts) AS purchase_year,
  orders.product_name,
  SUM(CASE WHEN order_status.refund_ts IS NOT NULL THEN 1 ELSE 0 END) AS refund_count,
  ROUND(AVG(CASE WHEN order_status.refund_ts IS NOT NULL THEN 1 ELSE 0 END),2) AS refund_rate
FROM core.orders
LEFT JOIN core.order_status
ON orders.id = order_status.order_id
GROUP BY 1, 2
;

-- Within each region, what is the most popular product? 

WITH sales_by_product_by_region AS (
  SELECT
    geo_lookup.region,
    orders.product_name,
    COUNT(orders.id) AS order_count
  FROM core.orders
  LEFT JOIN core.order_status
    ON orders.id = order_status.order_id
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  LEFT JOIN core.geo_lookup
    ON customers.country_code = geo_lookup.country
  GROUP BY 1,2
)

SELECT 
  *
FROM sales_by_product_by_region
QUALIFY RANK() OVER(PARTITION BY region ORDER BY order_count DESC) = 1
ORDER BY order_count DESC
;

-- How does the time to make a purchase differ between loyalty customers vs. non-loyalty customers, per purchase plaftorm.

SELECT
  orders.purchase_platform,
  CASE WHEN customers.loyalty_program = 1 THEN 'Loyalty' ELSE 'Non-Loyalty' END AS loyalty_status,
  ROUND(AVG(DATE_DIFF(orders.purchase_ts, customers.created_on, day)),1) AS avg_days_to_order,
  COUNT(*) AS order_count
FROM core.customers
LEFT JOIN core.orders
ON orders.customer_id = customers.id
GROUP BY 1,2
;

-- What is the median order value for each currency?

WITH median AS (

   SELECT 
      usd_price,
      currency,
      ROW_NUMBER() OVER (PARTITION BY currency ORDER BY usd_price ASC, id ASC) AS RowAsc,
      ROW_NUMBER() OVER (PARTITION BY currency ORDER BY usd_price DESC, id DESC) AS RowDesc
   FROM core.orders
   WHERE usd_price IS NOT NULL

)

SELECT 
  currency,
  ROUND(AVG(usd_price),2) AS median_order_value,
FROM median
WHERE RowASC IN (RowDesc, RowDesc - 1, RowDesc + 1)
GROUP BY 1
ORDER BY 2 DESC;








