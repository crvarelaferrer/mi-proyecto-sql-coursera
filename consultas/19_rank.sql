-- Curso: Dominio de consultas SQL avanzadas
-- RANK() -- funcion de ranking que SI refleja empates (a diferencia de 
ROW_NUMBER)
-- Ejemplo generico: rankear empleados por ventas dentro de cada 
departamento

SELECT employee_id, department_id, sales_amount,
       RANK() OVER (PARTITION BY department_id ORDER BY sales_amount DESC) 
AS sales_rank
FROM employee_sales;

-- Aplicado a bookcycle.db: ranking de libros por ventas dentro de cada 
genero,
-- reflejando empates (a diferencia del ROW_NUMBER usado en 
14_ctes_window_functions.sql)
SELECT b.title, b.genre, COUNT(*) AS sales_count,
       RANK() OVER (PARTITION BY b.genre ORDER BY COUNT(*) DESC) AS 
genre_rank
FROM books b
JOIN transactions t ON b.book_id = t.book_id
GROUP BY b.book_id, b.title, b.genre
ORDER BY b.genre, genre_rank;
