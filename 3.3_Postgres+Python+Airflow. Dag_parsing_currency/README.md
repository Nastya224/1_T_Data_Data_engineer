 ## Содержание
Данный docker-compose предназначен для разворачивания сервисов:
- СУБД Postgres
- Airflow
- Redis

## Инструкция по развертыванию
https://github.com/Nastya224/1_T_Data_Data_engineer/blob/main/3.3_Postgres%2BPython%2BAirflow.%20Dag_parsing_currency/Deploy.md


## Результат запуска Docker-compose
Даг "BTC_currency" каждые 10 минут: 1) выводит приветствие 2) по API выгружает инфо о текущем курсе биткоина 3) загружает полученные данные в табличку в Postgres

![image](https://github.com/Nastya224/1_T_Data_Data_engineer/assets/94219446/c19bc9b4-7872-48ca-a7e0-1d0e6867a57e)

