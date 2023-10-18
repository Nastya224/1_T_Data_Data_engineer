## Цель проекта
Создать ETL-процесс формирования витрины данных для анализа публикаций новостей из источников:
* https://lenta.ru/rss/
* https://www.vedomosti.ru/rss/news
* https://tass.ru/rss/v2.xml

## Стек технологий:
* Для хранения и обработки данных по новостям выбрана СУБД Postgres, т.к. данные не большие и структурированные (не более 1000 новостей в день со всех источников)
* В качестве оркестратора ETL процесса выбран Apache Airflow
* Таски дагов написаны при помощи Python оператора
* Приложения были развернуты при помощи Docker-Compose

## Структура данных 
Cостоит из трех слоев:
* Сырой слой данных
* Промежуточный слой
* Слой витрин

Схема ER https: https://github.com/Nastya224/1_T_Data_Data_engineer/blob/main/Project/ER.pdf

## Реализация
Описание в презентации https://github.com/Nastya224/1_T_Data_Data_engineer/blob/main/Project/Presentation.pdf
Скрипты дагов https://github.com/Nastya224/1_T_Data_Data_engineer/tree/main/Project/dags

Параметры соединения с Postgres вынесены в Connection, созданное в интерфейсе Airflow.
![image](https://github.com/Nastya224/Project_1/assets/94219446/11ae1f4e-69cb-4751-86db-70f6db86e456)


## Результат
Витрина с данными:
* Суррогатный ключ категории - CategoryID

* Название категории - Category

* Общее количество новостей из всех источников по данной категории за все время - Count_news_all_sources

* Количество новостей данной категории для каждого из источников за все время - Count_news_tass, Count_news_lenta, Count_news_vedomosti

* Общее количество новостей из всех источников по данной категории за последние сутки - Count_news_all_sources_24_hours

* Количество новостей данной категории для каждого из источников за последние сутки - Count_news_tass_24_hours, Count_news_lenta_24_hours, Count_news_vedomosti_24_hours

* Среднее количество публикаций по данной категории в сутки - Avg_count_news_per_day

* День, в который было сделано максимальное количество публикаций по данной новости -  Date_with_max_count_news

* Количество публикаций новостей данной категории по дням недели - Count_news_mon, Count_news_tue, Count_news_wed, Count_news_thr, Count_news_fr, Count_news_sat, Count_news_sun

![image](https://github.com/Nastya224/Project_1/assets/94219446/c5137a1c-808d-485d-8322-58f20abb8401)


