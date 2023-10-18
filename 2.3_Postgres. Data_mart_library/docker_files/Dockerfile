FROM postgres:latest
ENV POSTGRES_PASSWORD=12345
ENV POSTGRES_USER=user
ENV POSTGRES_DB=database
COPY init_scripts/init.sql /docker-entrypoint-initdb.d/init.sql