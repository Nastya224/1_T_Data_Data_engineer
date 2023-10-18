## Содержание

Dockerfile развертывает Postgres и наполняет БД данными.

## Инструкция по развертыванию
1. Скачать файлы в папку
2. В командной строке перейти в папку
3. Запустить команду по созданию образа (при запущенном Docker engine)
```
docker build.
```
4. Запустить команду для запуска контейнера (при запущенном Docker engine)
```
docker run --rm --name test -e POSTGRES_PASSWORD=test –p 5432:5432 -v
$(pwd)/data:/var/lib/postgresql/data -d postgres
```
