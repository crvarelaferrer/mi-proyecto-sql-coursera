-- Curso: Dominio de consultas SQL avanzadas — CTE Refactoring Challenge
-- bookcycle.db, tablas books, transactions
-- Objetivo: libro mas vendido de cada genero en la tienda University

-- Consulta original (compleja, subquery anidada)
SELECT genre, title, total_sales, rank
FROM (
    SELECT b.genre, b.title, SUM(t.sale_price) as total_sales,
           ROW_NUMBER() OVER (PARTITION BY b.genre ORDER BY 
SUM(t.sale_price) DESC) as rank
    FROM books b
    JOIN transactions t ON b.book_id = t.book_id
    WHERE t.store_location = 'University'
    GROUP BY b.genre, b.title
) ranked
ORDER BY total_sales DESC;

-- Refactor propio con CTEs encadenados
WITH sales_by_book AS (
    SELECT genre, title, SUM(t.sale_price) as total_sales
    FROM books b JOIN transactions t ON b.book_id = t.book_id
    WHERE t.store_location = 'University'
    GROUP BY b.genre, b.title
),
ranked_books AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY genre ORDER BY total_sales DESC) 
as rank
    FROM sales_by_book
)
SELECT * FROM ranked_books
WHERE rank = 1
ORDER BY genre;

-- Version estilo IA (nombres mas explicitos, sin SELECT *)
WITH university_sales AS (
    SELECT
        b.genre,
        b.title,
        SUM(t.sale_price) AS total_sales
    FROM books b
    JOIN
