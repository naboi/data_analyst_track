--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
-- select count(*), class 
-- from ships 
-- join outcomes
-- on outcomes.ship = ships.name
-- where result = 'sunk'
-- group by class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
-- select class, min(launched) as "first launch"
-- from ships
-- group by class

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
-- select class, count(*) 
-- from ships 
-- join outcomes
-- on outcomes.ship = ships.name
-- where class in (
-- 	select class 
-- 	from ships 
-- 	join outcomes
-- 	on outcomes.ship = ships.name
-- 	where result = 'sunk'
-- )
-- group by class

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
-- with ships_class as (
-- 	select name, class from ships	
-- 	union
-- 	select ship, ship from outcomes
-- )

-- select name
-- from ships_class 
-- join classes c1 
-- on ships_class.class=c1.class
-- where numguns >= all(
-- 	select c2.numguns from classes c2
-- 	where c1.displacement=c2.displacement
-- 	and c1.class in (select class from ships_class)
--     )

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
-- select distinct  maker
-- from product
-- join pc
-- on pc.model = product.model
-- where maker in (select maker from product where type = 'Printer')
-- and ram = (select min(ram) from pc)
-- and speed = (select max(speed) from pc where ram = (select min(ram) from pc))
