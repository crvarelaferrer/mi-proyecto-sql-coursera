-- Curso: Dominio de consultas SQL avanzadas — CTEs in Practice
-- bookcycle.db, tablas books, transactions

-- CTE básico: total de ventas por tienda
WITH store_sales AS (
    SELECT store_location, SUM(sale_price) AS total_sales
    FROM transactions
    GROUP BY store_location
)
SELECT *
FROM store_sales
ORDER BY total_sales DESC;

-- Funcion de ventana: ranking de libros por ventas dentro de cada genero
WITH book_sales AS (
    SELECT b.book_id, b.title, b.genre, COUNT(*) AS sales_count
    FROM books b
    JOIN transactions t ON b.book_id = t.book_id
    GROUP BY b.book_id
)
SELECT
    book_id,
    title,
    genre,
    sales_count,
    ROW_NUMBER() OVER (PARTITION BY genre ORDER BY sales_count DESC) AS 
rank_in_genre
FROM book_sales
ORDER BY genre, rank_in_genre;

-- Combinando CTEs encadenados + funcion de ventana: top 3 por genero y % 
de participacion
WITH book_sales AS (
    SELECT
        b.book_id,
        b.title,
        b.genre,
        COUNT(*) AS sales_count
    FROM books b
    JOIN transactions t ON b.book_id = t.book_id
    GROUP BY b.book_id
),
genre_totals AS (
    SELECT genre, SUM(sales_count) AS total_genre_sales
    FROM book_sales
    GROUP BY genre
),
ranked_books AS (
    SELECT
        bs.genre,
        bs.title,
        bs.sales_count,
        ROW_NUMBER() OVER (PARTITION BY bs.genre ORDER BY bs.sales_count 
DESC) AS rank_in_genre,
        ROUND(bs.sales_count * 100.0 / gt.total_genre_sales, 2) AS 
percent_of_genre_sales
    FROM book_sales bs
    JOIN genre_totals gt ON bs.genre = gt.genre
)
SELECT *
FROM ranked_books
WHERE rank_in_genre <= 3
ORDER BY genre, rank_in_genre;
