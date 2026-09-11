-- Curso: SQL en la práctica — Data Exploration Lab (ejercicios propios resueltos)
-- bookcycle.db, tabla books

-- Actividad 1, Paso 3: ordenar alfabéticamente por título, primeros 15
SELECT title, author
FROM books
ORDER BY title
LIMIT 15;

-- Actividad 2, Paso 3: valor total del inventario + autores únicos
select sum(list_price) as total_inventory_value, count(distinct author) as unique_authors
from books;

-- Actividad 3, Paso 3: valor total de libros 'Like New' por ubicación, orden descendente
select sum(list_price) as total_value, current_location
from books
where condition = 'Like New'
group by current_location
order by total_value desc;
-- Resultado obtenido: University 161.88 | Suburban 37.97 | Downtown 25.98
