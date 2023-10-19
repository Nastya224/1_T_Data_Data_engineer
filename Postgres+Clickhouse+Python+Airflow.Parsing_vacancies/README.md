### Содержание
Данный docker-compose предназначен для разворачивания сервисов:
- сервисы Airflow
- СУБД Postgres
- СУБД ClickHouse
- redis 

### Инструкция по развертыванию
https://github.com/Nastya224/1_T_Data_Data_engineer/blob/076936aa4bf3a546a7a4504837aaca2ef8d41d24/Postgres%2BClickhouse%2BPython%2BAirflow.Parsing_vacancies/Deploy.md

### Результат
После развертывания можно запустить два дага в Airflow: 
1) Загрузка данных по вакансиям с сайта Хабр. Карьера
![image](https://github.com/Nastya224/1_T_Data_engineer/assets/94219446/2d3fe743-04d7-48f3-aa40-f0835ce989f7)

2) Выгрузка всех данных из СУБД ClickHouse в консоль (синхронизация c Postgres произойдет автоматически через движки)

