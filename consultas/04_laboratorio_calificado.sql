-- Laboratorio: Environment Setup Challenge (product_catalog.db)

-- Task 1: categorías distintas
SELECT DISTINCT tags FROM products;

-- Task 2: tags únicos por ciudad
SELECT COUNT(DISTINCT tags) AS products_Miami FROM products WHERE city = 'Miami';

-- Task 3: productos sin imagen
SELECT * FROM products WHERE product_picture IS NULL;
SELECT * FROM products WHERE product_picture IS NOT NULL;

-- Task 4: URLs que no contienen un dominio específico
SELECT * FROM products WHERE product_url NOT LIKE '%data_shop_inc.com%';
