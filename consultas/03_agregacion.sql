-- COUNT básico
SELECT COUNT(*) FROM books;
SELECT COUNT(*) AS total_libros FROM books;

-- COUNT(DISTINCT columna) -- cuenta valores únicos
SELECT COUNT(DISTINCT genre) FROM books;

-- GROUP BY
SELECT genre, COUNT(*) AS cantidad FROM books GROUP BY genre;
