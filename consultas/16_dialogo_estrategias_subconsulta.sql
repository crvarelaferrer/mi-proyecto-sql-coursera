-- Dialogo evaluativo: Estrategias de subconsulta
-- Ejemplos genericos (tabla_de_ventas / books)

-- Clientes/productos con valor sobre el promedio (subquery en WHERE)
SELECT customer_id, customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(order_value) > (
        SELECT AVG(order_value)
        FROM orders
    )
);

-- EXPLAIN: ver el plan de ejecucion de una subquery correlacionada
EXPLAIN
SELECT title FROM books b
WHERE list_price > (
    SELECT AVG(list_price) FROM books WHERE genre = b.genre
);
