--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, дополнительно)
-- SQL: Создайте таблицу с синтетическими данными (10000 строк, 3 колонки, все типы int) и заполните ее случайными данными от 0 до 1 000 000. Проведите EXPLAIN операции и сравните базовые операции.
explain
create table example_table as
select
    floor(random()*(1000000-0)+0) as int_1,
	floor(random()*(1000000-0)+0) as int_2,
	floor(random()*(1000000-0)+0) as int_3
from generate_series(1, 10000) s(i)

--task2 (lesson6, дополнительно)
-- GCP (Google Cloud Platform): Через GCP загрузите данные csv в базу PSQL по личным реквизитам (используя только bash и интерфейс bash) 
create table avocado
("Index" serial,
"Date" date,
"AveragePrice" decimal,
"Total Volume" decimal,
"4046" decimal,
"4225" decimal,
"4770" decimal,
"Total Bags" decimal,
"Small Bags" decimal,
"Large Bags" decimal,
"XLarge Bags" decimal,
"type" varchar(100),
"year" integer,
"region" varchar(100)
);

-c \COPY avocado("Index","Date","AveragePrice","Total Volume","4046","4225","4770","Total Bags","Small Bags","Large Bags","XLarge Bags","type","year","region")
FROM '/home/naboishikov/avocado.csv'
DELIMITER ','
CSV HEADER;
