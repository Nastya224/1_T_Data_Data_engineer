 ## Содержание
Данный docker-compose предназначен для разворачивания сервисов:
- СУБД Postgres
- Airflow

## Инструкция по развертыванию
https://github.com/Nastya224/1_T_Data_Data_engineer/blob/main/3.3_Postgres%2BPython%2BAirflow.%20Dag_parsing_currency/Deploy.md


## Результат запуска Docker-compose
Даг "BTC_currency" каждые 10 минут: 1) выводит приветствие 2) по API выгружает инфо о текущем курсе биткоина 3) загружает полученные данные в табличку в Postgres

 ![Скриншот 03-09-2023 134244](https://github.com/Nastya224/3.3/assets/94219446/bac9d478-ec56-4e19-b611-72fba5747853)
