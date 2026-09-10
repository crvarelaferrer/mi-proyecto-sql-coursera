-- WHERE básico
SELECT title, list_price FROM books WHERE list_price < 10;
SELECT title, list_price FROM books WHERE list_price > 11;

-- AND / OR
SELECT * FROM books WHERE list_price < 15 AND genre = 'Fantasy';
SELECT title, list_price FROM books WHERE genre = 'Fantasy' OR genre = 'Sci-Fi';

-- BETWEEN
SELECT title, list_price FROM books WHERE list_price BETWEEN 11 AND 13;

-- Precedencia con paréntesis
SELECT title, author, list_price FROM books
WHERE (genre = 'Classic' OR genre = 'Fantasy') AND list_price > 13;

-- IN
SELECT title FROM books WHERE genre IN ('Non-Fiction', 'Classic', 'Fantasy');
