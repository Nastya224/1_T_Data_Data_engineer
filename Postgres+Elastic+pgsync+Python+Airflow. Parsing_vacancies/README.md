### Содержание

Данный docker-compose предназначен для разворачивания сервисов:
- сервисы Airflow
- СУБД Postgres
- СУБД Elastic
- kibana 
- redis 
- pgsync (сервис для синхронизации данных между Postgres и Elastic)

### Инструкция по развертыванию
https://github.com/Nastya224/Elastic1/blob/7d1f1a3ddc02158b1ac7d92b22a3ad659283170d/Deploy.md

### Результат
После развертывания можно запустить два дага в Airflow: 
1) Загрузка данных по вакансиям с сайта Хабр. Карьера
![image](https://github.com/Nastya224/1_T_Data_engineer/assets/94219446/65c99c12-fd40-4c3c-be9a-a154ef65e958)

2) Выгрузка всех данных из СУБД Elastic в консоль (синхронизация c Postgres произойдет автоматически через сервис pgsync)
![image](https://github.com/Nastya224/1_T_Data_engineer/assets/94219446/d27727d3-cc0e-4bfd-bdbc-19d23ef10083)
