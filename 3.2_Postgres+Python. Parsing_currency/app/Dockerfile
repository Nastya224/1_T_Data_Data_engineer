FROM python:3.9
RUN pip install psycopg2 
RUN pip install requests
COPY app.py /opt/app/
WORKDIR /opt/app/
CMD ["python", "app.py"]