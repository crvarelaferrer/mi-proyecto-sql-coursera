-- Curso: SQL en la práctica — Join Practice
-- INNER JOIN, LEFT JOIN y joins múltiples sobre bookcycle.db
-- (tablas customers, transactions, books)

-- INNER JOIN básico con alias de tabla
SELECT c.customer_id, c.join_date, t.transaction_id, t.date_time, t.sale_price
FROM customers c
INNER JOIN transactions t ON c.customer_id = t.customer_id
LIMIT 5;

-- INNER JOIN agregando una columna extra
SELECT c.customer_id, c.join_date, c.preferred_store, t.transaction_id, t.date_time, t.sale_price
FROM customers c
INNER JOIN transactions t ON c.customer_id = t.customer_id
LIMIT 5;

-- LEFT JOIN: todos los clientes, tengan o no transacciones
SELECT c.customer_id, c.join_date, t.transaction_id
FROM customers c
LEFT JOIN transactions t ON c.customer_id = t.customer_id
LIMIT 10;

-- Clientes SIN transacciones (aprovechando los NULL del LEFT JOIN)
SELECT c.customer_id, c.join_date
FROM customers c
LEFT JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_id IS NULL;

-- Join de 3 tablas: compras por tienda y título
SELECT t.store_location, b.title, COUNT(*) as purchase_count
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
JOIN books b ON t.book_id = b.book_id
GROUP BY t.store_location, b.title
LIMIT 5;

-- Avanzado (subquery, adelanto): libro más vendido por tienda
SELECT rb.store_location, rb.title, rb.purchase_count
FROM (
    SELECT
        t.store_location,
        b.title,
        COUNT(*) AS purchase_count
    FROM customers c
    JOIN transactions t ON c.customer_id = t.customer_id
    JOIN books b ON t.book_id = b.book_id
    GROUP BY t.store_location, b.title
) AS rb
WHERE rb.purchase_count = (
    SELECT MAX(sub.purchase_count)
    FROM (
        SELECT
            t2.store_location,
            b2.title,
            COUNT(*) AS purchase_count
        FROM customers c2
        JOIN transactions t2 ON c2.customer_id = t2.customer_id
        JOIN books b2 ON t2.book_id = b2.book_id
        GROUP BY t2.store_location, b2.title
    ) AS sub
    WHERE sub.store_location = rb.store_location
)
ORDER BY rb.store_location, rb.title;
