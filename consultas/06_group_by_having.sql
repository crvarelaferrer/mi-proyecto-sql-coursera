-- Curso: SQL en la práctica — Group and Filter
-- GROUP BY y HAVING sobre bookcycle.db (tabla transactions)

-- GROUP BY básico
SELECT store_location, COUNT(*) as transaction_count
FROM transactions
GROUP BY store_location;

-- Total de ventas por método de pago
SELECT payment_method, SUM(sale_price) as total_sales
FROM transactions
GROUP BY payment_method;

-- Varias funciones de agregación a la vez
SELECT
    store_location,
    SUM(sale_price) as total_sales,
    AVG(sale_price) as avg_sale_price,
    COUNT(*) as transaction_count
FROM transactions
GROUP BY store_location;

-- Min, max, promedio por método de pago
SELECT payment_method,
MIN(sale_price) AS min_sale_price,
MAX(sale_price) AS max_sale_price,
AVG(sale_price) AS avg_sale_price
FROM transactions
GROUP BY payment_method;

-- HAVING: filtrar grupos (no filas)
SELECT
    store_location,
    COUNT(*) as transaction_count
FROM transactions
GROUP BY store_location
HAVING transaction_count
