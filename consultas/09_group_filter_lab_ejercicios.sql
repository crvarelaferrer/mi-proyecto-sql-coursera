-- Curso: SQL en la práctica — Group and Filter Lab (ejercicios propios 
resueltos)
-- bookcycle.db, tabla transactions

-- Actividad 1, Paso 3: total de ventas por método de pago
select payment_method, sum(sale_price) as total_sales
from transactions
group by payment_method;
-- resultado: cash 250.76 | credit 576.50 | debit 287.74

-- Actividad 2, Paso 2: min, max y promedio de precio de venta por método 
de pago
select payment_method,
min(sale_price) as min_sale_price,
max(sale_price) as max_sale_price,
avg(sale_price) as avg_sale_price
from transactions
group by payment_method;
-- resultado: cash (7.99, 12.99, 10.45) | credit (7.99, 13.99, 11.53) | 
debit (7.99, 13.99, 11.07)

-- Actividad 3, Paso 2: métodos de pago con precio promedio > 10
select payment_method, avg(sale_price) as avg_sale_price
from transactions
group by payment_method
having avg(sale_price) > 10;
-- resultado: cash 10.45 | credit 11.53 | debit 11.07
