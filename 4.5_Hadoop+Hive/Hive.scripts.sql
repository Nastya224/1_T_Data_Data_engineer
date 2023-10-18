-----------------
--Загрузка данных по покупателям
-----------------
--Создаем временную таблицу, чтобы в нее залить данные из файла
CREATE TABLE IF NOT EXISTS customers_temp (Index INT, Customer_Id STRING, First_Name STRING,
                                           Last_Name STRING, Company STRING, City STRING,
                                           Country STRING, Phone_1 STRING, Phone_2 STRING,
                                           Email STRING, Subscription_Date DATE, Website STRING,
                                           Group_number STRING, Subscription_Year STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

--Заливаем данные из файла
LOAD DATA INPATH '/user/nastya_golunova/customers_with_group.csv' OVERWRITE INTO TABLE customers_temp;

--Создаем таблицу по покупателям с партицированием и бэкетированием
CREATE TABLE IF NOT EXISTS customers (Index INT, Customer_Id STRING, First_Name STRING,
                                      Last_Name STRING, Company STRING, City STRING,
                                      Country STRING, Phone_1 STRING, Phone_2 STRING,
                                      Email STRING, Subscription_Date DATE, Website STRING, Group_number STRING )
PARTITIONED BY (Subscription_Year STRING)
CLUSTERED BY (Group_number) INTO 10 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS PARQUET;

--Заливаем данные из временной таблицы в таблицу по покупателям с учетом партиций
--Партиция по 2020 году
INSERT INTO TABLE customers PARTITION (subscription_year=2020)
SELECT index, customer_id, first_name, 
       last_name, company, city, 
       country, phone_1, phone_2, 
       email, subscription_date, website, group_number
FROM customers_temp WHERE subscription_year=2020;
--Партиция по 2021 году
INSERT INTO TABLE customers PARTITION (subscription_year=2021)
SELECT index, customer_id, first_name, 
       last_name, company, city, 
       country, phone_1, phone_2, 
       email, subscription_date, website, group_number
FROM customers_temp WHERE subscription_year=2021;
--Партиция по 2022 году
INSERT INTO TABLE customers PARTITION (subscription_year=2022)
SELECT index, customer_id, first_name, 
       last_name, company, city, 
       country, phone_1, phone_2, 
       email, subscription_date, website, group_number
FROM customers_temp WHERE subscription_year=2022;

--Удаляем временную таблицу, так как все данные перенесены в постоянную табличку
DROP TABLE customers_temp

-----------------
--Загрузка данных по компаниям
-----------------
--Создаем временную таблицу для переливки данных из файла
CREATE TEMPORARY TABLE IF NOT EXISTS organisations_temp (Index INT, Organization_Id STRING, Name STRING,
                                                         Website STRING, Country STRING, Description STRING,
                                                         Founded STRING, Industry STRING, Number_of_employees STRING, Group_number STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

--Заливаем данные
LOAD DATA INPATH '/user/nastya_golunova/organizations_with_group.csv' OVERWRITE INTO TABLE organisations_temp;

--Создаем табличку по компаниям с бэкетированием
CREATE TABLE IF NOT EXISTS organisations (Index INT, Organization_Id STRING, Name STRING,
                                          Website STRING, Country STRING, Description STRING,
                                          Founded STRING, Industry STRING, Number_of_employees STRING, Group_number STRING)
CLUSTERED BY (Group_number) INTO 10 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS PARQUET;

--Вставляем данные из временной таблицы
INSERT INTO TABLE organisations
SELECT Index, Organization_Id, Name,
       Website, Country, Description,
       Founded, Industry, Number_of_employees, Group_number
FROM organisations_temp;

--Удаляем временную таблицу, так как все данные перенесены в постоянную табличку
DROP TABLE organisations_temp

-----------------
--Загрузка данных по подписчикам
-----------------
--Создаем временную таблицу для переливки данных из файла

CREATE TEMPORARY TABLE IF NOT EXISTS people_temp (Index INT, User_Id STRING, First_Name STRING,
                                                  Last_Name STRING, Sex STRING, Email STRING,
                                                  Phone STRING, Date_of_birth DATE, Job_Title STRING, Group_number STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

--Заливаем данные
LOAD DATA INPATH '/user/nastya_golunova/people_with_group.csv' OVERWRITE INTO TABLE people_temp;

--Создаем табличку по компаниям с бэкетированием
CREATE TABLE IF NOT EXISTS people (Index INT, User_Id STRING, First_Name STRING,
                                   Last_Name STRING, Sex STRING, Email STRING,
                                   Phone STRING, Date_of_birth DATE, Job_Title STRING, Group_number STRING)
CLUSTERED BY (Group_number) INTO 10 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS PARQUET;

--Вставляем данные из временной таблицы
INSERT INTO TABLE people
SELECT Index, User_Id, First_Name,
       Last_Name, Sex, Email,
       Phone, Date_of_birth, Job_Title, Group_number
FROM people_temp;

--Удаляем временную таблицу, так как все данные перенесены в постоянную табличку
DROP TABLE people_temp

-----------------
--Формируем витрину данных
-----------------
--Объединяем партицицированные таблички с покупателями
WITH customers_union AS (
					     SELECT first_name, last_name, email, 
                                company, subscription_year
					     FROM customers WHERE subscription_year = 2020
					     UNION ALL
					     SELECT first_name, last_name, email, 
                                company, subscription_year
					     FROM customers WHERE subscription_year = 2021
					     UNION ALL
					     SELECT first_name, last_name, email, 
                                company, subscription_year
					     FROM customers WHERE subscription_year = 2022
					),
--Разделяем возраста покупателям по группам
     age_groups as (
                         SELECT user_id, first_name, last_name, email,
                            CASE 
                               WHEN YEAR(current_date()) - YEAR(Date_of_birth) < 19 THEN '0 - 18 лет'
                               WHEN YEAR(current_date()) - YEAR(Date_of_birth) < 26 THEN '19 - 25 лет'
                               WHEN YEAR(current_date()) - YEAR(Date_of_birth) < 36 THEN '26 - 35 лет'
                               WHEN YEAR(current_date()) - YEAR(Date_of_birth) < 46 THEN '36 - 45 лет'
                               WHEN YEAR(current_date()) - YEAR(Date_of_birth) < 56 THEN '46 - 55 лет'
                               WHEN YEAR(current_date()) - YEAR(Date_of_birth) < 66 THEN '56 - 65 лет'
                               ELSE '66 лет и больше'
                            END as age_group
                         FROM people),
--Подсчитываем колич-во подписчиков каждой группы для каждой компании для каждого года
     counts as (
                         SELECT company, subscription_year, age_group, COUNT(*) as m2
                         FROM customers_union cu
                         JOIN age_groups a  ON cu.first_name=a.first_name AND cu.last_name=a.last_name AND cu.email=a.email
                         JOIN organisations o ON o.name=cu.company
                         GROUP BY company, subscription_year, age_group),
--Находим макс. колич-во подписчиков для каждой компании для каждого года
     max_count as (
                         SELECT company, subscription_year, max(m2) as max_c
                         FROM counts c 
                         GROUP BY  subscription_year, company)
--Выводим витрину с возрастными группами, где максим. количество подписчиков в разрезе компаний и годов
 SELECT c.company as Company, c.subscription_year as Year, c.age_group as Age_group
 FROM max_count m 
 INNER JOIN counts c ON c.company=m.company AND c.subscription_year=m.subscription_year AND  c.m2=m.max_c
 ORDER BY Company, Year;
