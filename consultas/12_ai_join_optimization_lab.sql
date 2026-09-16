-- Curso: SQL en la práctica — Optimized SQL Join Generation Lab
-- bookcycle.db, tablas customers, transactions

-- Actividad 1: estructura de las tablas
PRAGMA table_info(customers);
PRAGMA table_info(transactions);

-- Actividad 2, Paso 1: join básico
SELECT c.customer_id, c.join_date, t.transaction_id, t.sale_price
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
LIMIT 10;

-- Actividad 2, Paso 2: join con más columnas + WHERE
SELECT c.customer_id, c.join_date, c.preferred_store, t.transaction_id, 
t.sale_price, t.store_location
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.is_member = 1
LIMIT 10;

-- Actividad 3: consulta optimizada generada con IA (miembros de 2022, 
compras presenciales)
-- Versión propia (desglosada por ubicación)
SELECT
    c.customer_id,
    c.preferred_store,
    t.store_location AS actual_purchase_location,
    SUM(t.sale_price) AS total_order_amount
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.is_member = 1
  AND strftime('%Y', c.join_date) = '2022'
  AND t.is_online = 0
GROUP BY c.customer_id, c.preferred_store, t.store_location
ORDER BY total_order_amount DESC;

-- Versión del laboratorio (resumida por cliente, con GROUP_CONCAT)
SELECT
    c.customer_id,
    c.preferred_store,
    SUM(t.sale_price) AS total_order_amount,
    COUNT(DISTINCT t.transaction_id) AS transaction_count,
    GROUP_CONCAT(DISTINCT t.store_location) AS purchase_locations
FROM
    customers c
JOIN
    transactions t ON c.customer_id = t.customer_id
WHERE
    c.is_member = 1
    AND strftime('%Y', c.join_date) = '2022'
    AND t.is_online = 0
GROUP BY
    c.customer_id, c.preferred_store
ORDER BY
    total_order_amount DESC
LIMIT 20;

-- Extra: agrupar clientes por combo de tiendas donde compraron (orden 
normalizado)
SELECT combo_tiendas, COUNT(*) as cantidad_clientes
FROM (
    SELECT customer_id, GROUP_CONCAT(store_location) AS combo_tiendas
    FROM (
        SELECT DISTINCT c.customer_id, t.store_location
        FROM customers c
        JOIN transactions t ON c.customer_id = t.customer_id
        ORDER BY c.customer_id, t.store_location
    )
    GROUP BY customer_id
) AS resumen
GROUP BY combo_tiendas;
-- resultado: Downtown,Suburban,University -> 8 clientes (todos los 
clientes con transacciones compraron en las 3 tiendas)
