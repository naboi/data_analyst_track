--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц
create view pages_all_products as
select *, (row_num+1) % 2 + 1 as r1, floor((row_num + 1)/2) as r2
from (
select *, row_number() over() row_num
from laptop) t

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель, тип, процент (%)
create view distribution_by_type as
select type, maker, count(*) * 100.0 / sum(count(*)) over() as percentage
from product
group by type, maker

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/
в ipynb в github

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов
create view ships_two_words as
select * 
from ships
where name like '% %'

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"
select name
from ships
where class is null and name like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' 
-- и три самых дорогих (через оконные функции). Вывести model
select printer.model
from printer
join product
on product.model = printer.model
where maker = 'A' and price > (
	select avg(price) 
	from printer
	join product
	on product.model = printer.model
	where maker = 'C')

union all

select model from (
	select printer.model, rank() over(order by price) rank_number
	from printer
	join product
	on product.model = printer.model
	where maker = 'A'
	group by printer.model, price) t
where t.rank_number <=3
