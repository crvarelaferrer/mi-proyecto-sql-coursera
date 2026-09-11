-- Curso: SQL en la práctica — Data Exploration Lab
-- ORDER BY y funciones de agregación (COUNT, SUM, AVG) sobre bookcycle.db (tabla books)

-- Ordenar por precio, descendente
SELECT title, author, list_price
FROM books
ORDER BY list_price DESC
LIMIT 10;

-- Ordenar alfabéticamente (ascendente por defecto, sin DESC)
SELECT title, author
FROM books
ORDER BY title
LIMIT 15;

-- Contar filas
SELECT COUNT(*) as total_books
FROM books;

-- Promedios
SELECT
    AVG(purchase_price) as avg_purchase_price,
    AVG(list_price) as avg_list_price
FROM books;

-- Suma y conteo de valores únicos
SELECT
    SUM(list_price) as total_inventory_value,
    COUNT(DISTINCT author) as unique_authors
FROM books;

-- Agregación + filtro
SELECT AVG(list_price) as avg_price_classic_fiction
FROM books
WHERE genre = 'Classic Fiction';

-- WHERE + GROUP BY + ORDER BY
SELECT genre, COUNT(*) as count_very_good
FROM books
WHERE condition = 'Very Good'
GROUP BY genre
ORDER BY count_very_good DESC;

-- Reto final: filtro + agrupación + agregación + orden
SELECT
    current_location,
    SUM(list_price) as total_value_like_new
FROM books
WHERE condition = 'Like New'
GROUP BY current_location
ORDER BY total_value_like_new DESC;
