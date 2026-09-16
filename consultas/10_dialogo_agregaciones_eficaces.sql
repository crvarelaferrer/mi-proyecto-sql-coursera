-- Diálogo evaluativo: Diseñar agregaciones eficaces
-- Ejemplo genérico (tabla_de_ventas), combinando WHERE + GROUP BY + 
HAVING

-- Total de ventas por producto, solo productos con total > 1000, 
filtrando además por año 2023
SELECT producto, SUM(ventas) as total_ventas
FROM tabla_de_ventas
WHERE fecha >= '2023-01-01' AND fecha < '2024-01-01'
GROUP BY producto
HAVING SUM(ventas) > 1000;
