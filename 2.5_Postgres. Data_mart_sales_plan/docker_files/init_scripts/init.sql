CREATE TABLE IF NOT EXISTS public.products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(15,2) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.shop (
    shop_id INTEGER PRIMARY KEY,
    shop_name VARCHAR (50) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.plan (
    product_id INTEGER NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    shop_id INTEGER NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES shop (shop_id) ON DELETE CASCADE,
    plan_cnt  DECIMAL(15,0) NOT NULL,
    plan_date DATE NOT NULL
);
CREATE TABLE IF NOT EXISTS public.shop_dns (
    shop_id INTEGER NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES shop (shop_id) ON DELETE CASCADE,
    date DATE NOT NULL,
    product_id INTEGER,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    sales_cnt DECIMAL(15,0) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.shop_mvideo (
    shop_id INTEGER NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES shop (shop_id) ON DELETE CASCADE,
    date DATE NOT NULL,
    product_id INTEGER,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    sales_cnt DECIMAL(15,0) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.shop_sitilink (
    shop_id INTEGER NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES shop (shop_id) ON DELETE CASCADE,
    date DATE NOT NULL,
    product_id INTEGER,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    sales_cnt DECIMAL(15,0) NOT NULL
);
INSERT INTO public.products (product_id, product_name, price)  VALUES 
(1, 'Испорченный телефон', 1000),
(2, 'Сарафанное радио', 500),
(3, 'Патефон', 2000);
INSERT INTO public.shop (shop_id, shop_name)  VALUES 
(1, 'shop_dns'),
(2, 'shop_mvideo'),
(3, 'shop_sitilink');
INSERT INTO public.plan (product_id, shop_id, plan_cnt, plan_date)  VALUES 
(1, 1, 1000.0, '2023-06-30'),
(1, 2, 100.0, '2023-06-30'),
(1, 3, 800.0, '2023-06-30'),
(2, 1, 900.0, '2023-06-30'),
(2, 2, 700.0, '2023-06-30'),
(2, 3, 600.0, '2023-06-30'),
(3, 1, 1000.0, '2023-06-30'),
(3, 2, 1005.0, '2023-06-30'),
(3, 3, 1030.0, '2023-06-30'),
(1, 1, 1000.0, '2023-05-31'),
(1, 2, 100.0, '2023-05-31'),
(1, 3, 800.0, '2023-05-31'),
(2, 1, 900.0, '2023-05-31'),
(2, 2, 700.0, '2023-05-31'),
(2, 3, 600.0, '2023-05-31'),
(3, 1, 1000.0, '2023-05-31'),
(3, 2, 1005.0, '2023-05-31'),
(3, 3, 1030.0, '2023-05-31');
