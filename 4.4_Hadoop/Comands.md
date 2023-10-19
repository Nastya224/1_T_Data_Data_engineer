
## Команды

* Подключаемся к контейнеру «datanode-1»
```
docker exec -it hadoop-datanode-1 bash
```
Вывод: root@526a47789664:/#


* Cоздаем внутри папку
```
mkdir data
```
Вывод: root@526a47789664:/usr/data#

* Файлы предварительно «схлопываем» в один
```
type *.txt > vim1234.txt
```
Вывод:
voyna-i-mir-tom-1.txt
voyna-i-mir-tom-2.txt
voyna-i-mir-tom-3.txt
voyna-i-mir-tom-4.txt

* Переносим в папку объединенный файл Vim1234
```
docker cp C:/Users/User/Desktop/4.4/vim/vim1234.txt 526a47789664:/usr/data
```
Вывод: Successfully copied 3.05MB to 526a47789664:/usr/data

* Загружаем полученный файл на hdfs в вашу личную папку
```
docker exec -it 526a47789664 bash
cd usr/data
hdfs dfs -copyFromLocal vim1234.txt /user/nastya_golunova
```

* Выполняем команду, которая
выводит содержимое  личной папки
```
hadoop fs -ls /user/nastya_golunova
```
Вывод: 
Found 1 items
-rw-r--r--   3 root nastya_golunova    3048008 2023-09-08 07:57 /user/nastya_golunova/vim1234.txt

* Устанавливаем режим доступа, который дает полный доступ для владельца файла, а для сторонних пользователей возможность читать и выполнять.
Код доступа: 755

```
hadoop fs -chmod 755 /user/nastya_golunova/vim1234.txt
```
* Используем команду для вывода содержимого папки и обратим
внимание, как изменились права доступа к файлу
```
hadoop fs -ls /user/nastya_golunova
```
Вывод: Found 1 items
-rwxr-xr-x   3 root nastya_golunova    3048008 2023-09-08 07:57 /user/nastya_golunova/vim1234.txt

* Используем команду для вывода содержимого папки и обратим
внимание, как изменились права доступа к файлу
```
hadoop fs -ls /user/nastya_golunova
```
Вывод: Found 1 items
-rwxr-xr-x   3 root nastya_golunova    3048008 2023-09-08 07:57 /user/nastya_golunova/vim1234.txt

* Теперь попробуем вывести на экран информацию о том, сколько места на диске занимает файл. 
```
hadoop fs -du -s -h /user/nastya_golunova/vim1234.txt
```
Вывод: 2.9 M  /user/nastya_golunova/vim1234.txt

* Теперь попробуем вывести на экран информацию о том, сколько места на диске занимает файл
```
hadoop fs -du -h /user/nastya_golunova/vim1234.txt
```
Вывод: 2.9 M  /user/nastya_golunova/vim1234.txt

* Установим фактор репликации=2
```
hadoop fs -setrep 2 /user/nastya_golunova/vim1234.txt
```

* Снова выведем на экран информацию о том, сколько места на диске занимает файл
```
hadoop fs -du -h /user/nastya_golunova/vim1234.txt
```
Вывод: 2.9 M  /user/nastya_golunova/vim1234.txt


* Напишем команду, которая подсчитывает количество строк в произведении «Война и мир» 
```
hadoop fs -cat /user/nastya_golunova/vim1234.txt | wc -l
```
Вывод: 10272


