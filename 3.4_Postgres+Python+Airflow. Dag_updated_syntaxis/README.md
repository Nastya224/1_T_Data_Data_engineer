 ## Содержание
Данный docker-compose предназначен для разворачивания сервисов:
- СУБД Postgres
- Airflow
- Redis

## Инструкция по развертыванию
(https://github.com/Nastya224/1_T_Data_Data_engineer/blob/main/3.4_Postgres%2BPython%2BAirflow.%20Dag_updated_syntaxis/Deploy.md)

## Параметры соединения

![Скриншот 03-09-2023 122050](https://github.com/Nastya224/3.4/assets/94219446/ee1955da-416c-4bdb-8cfb-42718b2c499e)

## Результат запуска Docker-compose
Даг "BTC_currency" каждые 10 минут: 1) выводит приветствие 2) по API выгружает инфо о текущем курсе биткоина 3) загружает полученные данные в табличку в Postgres





