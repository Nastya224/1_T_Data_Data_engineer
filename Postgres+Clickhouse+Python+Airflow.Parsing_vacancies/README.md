### Содержание
Данный docker-compose предназначен для разворачивания сервисов:
- сервисы Airflow
- СУБД Postgres
- СУБД Elastic
- kibana 
- redis 
- pgsync (сервис для синхронизации данных между Postgres и Elastic)

### Инструкция по развертыванию
https://github.com/Nastya224/1_T_Data_Data_engineer/blob/076936aa4bf3a546a7a4504837aaca2ef8d41d24/Postgres%2BClickhouse%2BPython%2BAirflow.Parsing_vacancies/Deploy.md

После развертывания можно запустить два дага в Airflow: 
1) Загрузка данных по вакансиям с сайта Хабр. Карьера
2) Выгрузка всех данных из СУБД ClickHouse в консоль (синхронизация c Postgres произойдет автоматически через движки)

