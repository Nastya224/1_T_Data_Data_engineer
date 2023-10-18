-- Создаем таблицы
-- в таблице public.products используем обычный движок
CREATE TABLE IF NOT EXISTS public.products
(
    product_id UInt8,
    product_name String,
    price Float(15,2)
)
ENGINE = MergeTree() ORDER BY (product_id);
-- в таблице public.shop используем обычный движок
CREATE TABLE IF NOT EXISTS public.shop
(
    shop_id UInt8,
    shop_name String
)
ENGINE = MergeTree() ORDER BY (shop_id);
-- в таблице public.plan используем обычный движок
CREATE TABLE IF NOT EXISTS public.plan 
(
    product_id UInt8,
    shop_id UInt8,
    plan_cnt  Float(15,2),
    plan_date DATE
)
ENGINE = MergeTree() ORDER BY (product_id, shop_id, plan_date);
-- в таблице public.shop_dns используем движок для хранения агрегированных данных
CREATE TABLE IF NOT EXISTS public.shop_dns 
(
    shop_id UInt8,
    date DATE,
    product_id UInt8,
    sales_cnt Float(15,2)
)
ENGINE = SummingMergeTree() ORDER BY (shop_id, date, product_id);
-- в таблице public.shop_mvideo  используем движок для хранения агрегированных данных
CREATE TABLE IF NOT EXISTS public.shop_mvideo 
(
    shop_id UInt8,
    date DATE,
    product_id UInt8,
    sales_cnt Float(15,2)
)
ENGINE = SummingMergeTree() ORDER BY (shop_id, date, product_id);
-- в таблице public.shop_sitilink используем движок для хранения агрегированных данных
CREATE TABLE IF NOT EXISTS public.shop_sitilink
(
    shop_id UInt8,
    date DATE,
    product_id UInt8,
    sales_cnt Float(15,2)
)
ENGINE = SummingMergeTree() ORDER BY (shop_id, date, product_id);
-- Заполняем таблицы
INSERT INTO public.products (product_id, product_name, price)  VALUES  (1, 'Испорченный телефон', 1000), (2, 'Сарафанное радио', 500), (3, 'Патефон', 2000);
INSERT INTO public.shop (shop_id, shop_name)  VALUES (1, 'shop_dns'), (2, 'shop_mvideo'), (3, 'shop_sitilink');
INSERT INTO public.plan (product_id, shop_id, plan_cnt, plan_date)  VALUES  (1, 1, 1000.0, '2023-06-30'), (1, 2, 100.0, '2023-06-30'), (1, 3, 800.0, '2023-06-30'), (2, 1, 900.0, '2023-06-30'), (2, 2, 700.0, '2023-06-30'), (2, 3, 600.0, '2023-06-30'), (3, 1, 1000.0, '2023-06-30'), (3, 2, 1005.0, '2023-06-30'), (3, 3, 1030.0, '2023-06-30'), (1, 1, 1000.0, '2023-05-31'), (1, 2, 100.0, '2023-05-31'), (1, 3, 800.0, '2023-05-31'), (2, 1, 900.0, '2023-05-31'), (2, 2, 700.0, '2023-05-31'), (2, 3, 600.0, '2023-05-31'), (3, 1, 1000.0, '2023-05-31'), (3, 2, 1005.0, '2023-05-31'), (3, 3, 1030.0, '2023-05-31');
