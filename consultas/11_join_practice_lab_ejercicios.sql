-- Curso: SQL en la práctica — Join Practice Lab (ejercicios propios 
resueltos)
-- bookcycle.db, tablas customers, transactions, books

-- Actividad 1, Paso 3: tienda preferida del cliente + detalles de su 
transacción
SELECT c.customer_id, c.join_date, c.preferred_store, t.transaction_id, 
t.date_time, t.sale_price
FROM customers c
INNER JOIN transactions t ON c.customer_id = t.customer_id
LIMIT 5;

-- Actividad 2, Paso 2: clientes que no han hecho ninguna compra
SELECT c.customer_id, c.join_date
FROM customers c
LEFT JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_id IS NULL;
-- resultado: 92 clientes sin ninguna transacción

-- Actividad 3, Paso 2 (avanzado): libro más vendido por tienda (subquery 
correlacionada)
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
