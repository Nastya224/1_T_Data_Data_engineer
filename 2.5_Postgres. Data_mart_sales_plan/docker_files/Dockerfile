FROM postgres:latest
ENV POSTGRES_PASSWORD=12345
ENV POSTGRES_USER=golunova
ENV POSTGRES_DB=shops_data
COPY init_scripts/init.sql /docker-entrypoint-initdb.d/init.sql