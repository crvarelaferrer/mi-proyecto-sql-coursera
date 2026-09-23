-- Curso: Dominio de consultas SQL avanzadas
-- Funciones de agregacion como funciones de ventana (running totals)
-- bookcycle.db, tabla transactions

-- Total acumulado de ventas, ordenado por fecha (sin colapsar filas, a 
diferencia de GROUP BY)
SELECT date_time, sale_price,
    SUM(sale_price) OVER (ORDER BY date_time) AS running_total
FROM transactions
ORDER BY date_time;
