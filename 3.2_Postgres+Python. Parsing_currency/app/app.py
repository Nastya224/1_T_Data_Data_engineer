import psycopg2
import requests

#Подключаемся к СУБД
#Определяем параметры подключения
conn=psycopg2.connect(dbname='testdb',
                      user='postgres',
                      password='postgres',
                      host='db',
                      port='5432')

cur = conn.cursor()

#Парсим данные
#В переменную кладем необязательные параметры запроса
params_dict = {'base':'RUB', 'symbols':'BTC', 'source':'crypto', 'places':'20'}
response = requests.get('https://api.exchangerate.host/timeseries?start_date=2020-07-01&end_date=2020-07-30', params=params_dict)
#Запрашиваем json из ответа
data = response.json()
#Выводим результат
print(data)

#Определяем переменные из json для СУБД
currency1=data['base']
rates=data['rates']
res = [ (key,currency1, *item) for key,value in rates.items() for item in value.items()]



#Выполняем несколько запросов в СУБД: 1) по созданию таблицы для данных о курсе биткоина 2) вставке спарсенных данных
cursor=conn.cursor()
with conn.cursor() as cur:
    cur.execute("CREATE TABLE IF NOT EXISTS public.rates (Id serial PRIMARY KEY, Date_Rate DATE, Currency1 VARCHAR (3), Currency2 VARCHAR (3), Rate FLOAT);")
    cur.executemany("INSERT INTO public.rates (Date_Rate, Currency1, Currency2, Rate) VALUES(%s, %s, %s, %s);", res)
    conn.commit()
    cur.close()

#Выполняем серию запросов в СУБД
cursor=conn.cursor()
with conn.cursor() as cur:
#Запрашиваем валюты, месяц и дату с максимальным курсом
 cur.execute("select Date_Rate from rates where Rate IN (select max(Rate) from rates)")
 date_max = cur.fetchone()
#Запрашиваем дату с минимальным курсом
 cur.execute("select Date_Rate from rates where Rate IN (select min(Rate) from rates)")
 date_min = cur.fetchone()
#Запрашиваем максимальный курс
 cur.execute("select max(Rate) from rates")
 rate_max = cur.fetchone()    
#Запрашиваем минимальный курс      
 cur.execute("select min(Rate) from rates")
 rate_min = cur.fetchone()  
#Запрашиваем усредненный курс за месяц
 cur.execute("select AVG(Rate) from rates")
 rate_avg = cur.fetchone()    
#Запрашиваем курс на последний день месяца
 cur.execute("select Rate from rates where Date_Rate IN (SELECT max(Date_Rate)from rates)")
 rate_last_date = cur.fetchone()   
      
#Соединяем полученные значения в кортеж
info = (date_max+ rate_max + date_min  + rate_min + rate_avg + rate_last_date)

#Выполняем несколько запросов в СУБД: 1) по созданию таблицы для расчетов 2) вставке рассчитанных значений
cursor=conn.cursor()
with conn.cursor() as cur:
    cur.execute("CREATE TABLE IF NOT EXISTS public.rate_key_values (date_max_rate DATE, max_val_rate FLOAT, date_min_rate DATE,  min_val_rate FLOAT, avg_rate FLOAT, last_day_rate FLOAT);")
    cur.executemany("INSERT INTO public.rate_key_values (date_max_rate, max_val_rate, date_min_rate,  min_val_rate, avg_rate, last_day_rate) VALUES(%s, %s, %s, %s, %s, %s);", [info])
    conn.commit()
    cur.close()
