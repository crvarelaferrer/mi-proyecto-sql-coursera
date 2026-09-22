-- Curso: Dominio de consultas SQL avanzadas — AI-Assisted Query 
Optimization
-- bookcycle.db, tablas customers, transactions

-- Consulta original (lenta): clientes con mas de 5 compras, por monto 
gastado
SELECT c.customer_id, COUNT(t.transaction_id) as purchase_count, 
SUM(t.sale_price) as total_spent
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
GROUP BY c.customer_id
HAVING COUNT(t.transaction_id) > 5
ORDER BY total_spent DESC
LIMIT 10;

-- Version optimizada sugerida por IA: pre-agregar con CTE antes del JOIN
WITH transaction_metrics AS (
    SELECT customer_id,
           COUNT(*) as purchase_count,
           SUM(sale_price) as total_spent
    FROM transactions
    GROUP BY customer_id
    HAVING COUNT(*) > 5
)
SELECT c.customer_id,
       tm.purchase_count,
       tm.total_spent
FROM customers c
INNER JOIN transaction_metrics tm ON c.customer_id = tm.customer_id
ORDER BY tm.total_spent DESC
LIMIT 10;
