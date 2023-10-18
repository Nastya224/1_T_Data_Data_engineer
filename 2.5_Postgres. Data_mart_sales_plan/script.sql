-- Объединяем данные по продажам из трех магазинов
WITH sales AS (SELECT shop_id, product_id, EXTRACT(YEAR FROM date) AS year, 
                      eEXTRACT(MONTH FROM date) AS month, SUM(sales_cnt) AS sales
               FROM  shop_dns sd
               GROUP BY 1,2,3,4
               UNION ALL
               SELECT shop_id, product_id, EXTRACT(YEAR FROM date) AS year, 
                      EXTRACT(MONTH FROM date) AS month, sum(sales_cnt) AS sales
               FROM shop_mvideo sd
               GROUP BY 1,2,3,4
               UNION ALL
               SELECT shop_id, product_id, EXTRACT(YEAR FROM date) AS year, 
                      EXTRACT(MONTH FROM date) AS month, sum(sales_cnt) AS sales
               FROM shop_sitilink ss
               GROUP BY 1,2,3,4)
-- На основе объединенной таблицы и других таблиц строим витрину данных по продажам
SELECT  sh.shop_name, 
        pr.product_name, 
        sales AS sales_fact, 
        plan_cnt AS sales_plan,
-- Используем ROUND для округления результата деления до 2 знаков после запятой
        ROUND(sales/plan_cnt, 2) AS sales_fact_sales_plan,
        sales*price AS income_fact, 
(plan_cnt*price) AS income_plan,
-- Используем ROUND для округления результата деления до 2 знаков после запятой
        ROUND((sales*price)/(plan_cnt*price), 2) AS income_fact_income_plan
FROM public.plan pl
JOIN public.shop sh USING (shop_id)
JOIN public.products pr USING (product_id)
JOIN sales sl ON pl.product_id=sl.product_id AND pl.shop_id=sl.shop_id
-- Выбираем конкретный месяц и год для построения отчета 
-- Так как месяц и год не значились в атрибутах таблицы, то предположительно месяц/год задаются в условиях для построения (нужно уточнить)
WHERE sl.month = EXTRACT(MONTH FROM plan_date) AND sl.year = EXTRACT(YEAR FROM plan_date) AND MONTH =6 AND YEAR =2023
GROUP BY sh.shop_name, 
         pr.product_name, 
         sales_fact, 
         sales_plan,
         sales_fact_sales_plan,
         income_fact, 
         income_plan,
         income_fact_income_plan
ORDER BY 1;