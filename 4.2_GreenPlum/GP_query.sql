--2.Создайте таблицу-фактов о продажах произвольных товаров.
--При создании таблицы фактов распределяем по узлам по id, чтобы равномерно было. 
CREATE TABLE public.sales (id INT, year INT, month INT, day INT, product_id INT, sale_amount INT)
DISTRIBUTED BY (id)
PARTITION BY RANGE (year)
SUBPARTITION BY RANGE (month)
SUBPARTITION TEMPLATE (
        START (1) END (13) EVERY (1), 
        DEFAULT SUBPARTITION other_months )
( START (2020) END (2023) EVERY (1), 
  DEFAULT PARTITION outlying_years);

--3. Создайте таблицу-измерение, в которой отражены стоимость и название товара, а также связь с таблицей-фактов из предыдущего шага.
--Таблица является справочником, поэтому должна быть записана на каждом узле
CREATE TABLE public.products (product_id INT PRIMARY KEY, product_name VARCHAR(150), price NUMERIC(15,2))
DISTRIBUTED REPLICATED;

--Задаем связь справочника с таблицей фактов
ALTER TABLE public.sales
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id)
REFERENCES products (product_id);

--Заполните таблицы минимальными данными. Включите оптимизатор GP. 
INSERT INTO public.products
(product_id, product_name, price)
VALUES(1, 'Горошек Бондюэль', 20),
(2, 'Шампиньоны', 150),
(3, 'Морковь весовая', 50.99),
(4, 'Лимон', 150),
(5, 'Арбуз', 25),
(6, 'Финики', 100.99);
INSERT INTO public.sales ("year", "month", "day", product_id, sale_amount)
values
(2020, 1, 1, 1, 100),
(2020, 2, 2, 1, 100),
(2020, 3, 3, 1, 100),
(2020, 4, 4, 1, 100),
(2020, 5, 5, 1, 100),
(2020, 6, 6, 1, 100),
(2020, 7, 1, 1, 100),
(2020, 8, 2, 1, 100),
(2020, 9, 6, 1, 100),
(2020, 10, 1, 1, 100),
(2020, 11, 2, 1, 100),
(2021, 1, 1, 1, 100),
(2021, 2, 2, 1, 100),
(2021, 3, 3, 1, 100),
(2021, 4, 4, 1, 100),
(2021, 5, 5, 1, 100),
(2021, 6, 6, 1, 100),
(2021, 7, 1, 1, 100),
(2021, 8, 2, 1, 100),
(2021, 9, 6, 1, 100),
(2021, 10, 1, 1, 100),
(2021, 11, 2, 1, 100),
(2022, 1, 1, 1, 100),
(2022, 2, 2, 1, 100),
(2022, 3, 3, 1, 100),
(2022, 4, 4, 1, 100),
(2022, 5, 5, 1, 100),
(2022, 6, 6, 1, 100),
(2022, 7, 1, 1, 100),
(2022, 8, 2, 1, 100),
(2022, 9, 6, 1, 100),
(2022, 10, 1, 1, 100),
(2022, 11, 2, 1, 100);

--Включаем оптимизатор
SET optimizer = ON;

--4.Напишите запрос, который рассчитывает сумму продаж определенного товара за определенную единицу времени. 
SELECT product_id,SUM(sale_amount) FROM public.sales s 
WHERE year = 2020 AND month =12 AND product_id=1
GROUP BY 1;