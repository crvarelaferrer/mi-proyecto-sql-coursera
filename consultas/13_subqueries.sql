-- Curso: Dominio de consultas SQL avanzadas — Subqueries Lab
-- bookcycle.db, tablas books, transactions

-- Actividad 1: subquery en WHERE (libros sobre el precio promedio)
SELECT AVG(list_price) as avg_price
FROM books;

SELECT title, author, list_price
FROM books
WHERE list_price > (SELECT AVG(list_price) FROM books)
LIMIT 5;

-- Actividad 2: subquery en FROM (transacciones de alto valor)
SELECT AVG(sale_price) as avg_sale_price
FROM transactions;

SELECT t.transaction_id, t.book_id, t.sale_price, t.store_location
FROM transactions t
JOIN (SELECT AVG(sale_price) as avg_sale_price FROM transactions) avg
ON t.sale_price > avg.avg_sale_price
LIMIT 5;

-- Actividad 3: subquery correlacionada (libros que venden sobre el 
promedio de su género)
SELECT sales.genre, AVG(sales.count_per_book) AS avg_quantity
FROM (
    SELECT b.book_id, b.genre, COUNT(t.transaction_id) AS count_per_book
    FROM books b
    JOIN transactions t ON b.book_id = t.book_id
    GROUP BY b.book_id, b.genre
) sales
GROUP BY sales.genre
LIMIT 5;

SELECT book_sales.title, book_sales.genre, book_sales.total_sales
FROM (
    SELECT b.book_id, b.title, b.genre, COUNT(t.transaction_id) AS 
total_sales
    FROM books b
    JOIN transactions t ON b.book_id = t.book_id
    GROUP BY b.book_id, b.title, b.genre
) book_sales
JOIN (
    SELECT sales.genre, AVG(sales.count_per_book) AS avg_genre_sales
    FROM (
        SELECT b.book_id, b.genre, COUNT(t.transaction_id) AS 
count_per_book
        FROM books b
        JOIN transactions t ON b.book_id = t.book_id
        GROUP BY b.book_id, b.genre
    ) sales
    GROUP BY sales.genre
) genre_avg ON book_sales.genre = genre_avg.genre
WHERE book_sales.total_sales > genre_avg.avg_genre_sales
LIMIT 5;
