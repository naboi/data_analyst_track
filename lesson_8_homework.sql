--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
select Department, Employee, salary from (
    select 
        d.name as Department,
        e.name as Employee,
        salary,
        dense_rank() over(partition by d.name order by salary desc) as rnk
    from Employee e
    join Department d
    on d.id = e.departmentId)
where rnk in (1,2,3)
order by salary desc

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select member_name, status, sum(amount * unit_price) as costs
from Payments
join FamilyMembers
on FamilyMembers.member_id = Payments.family_member
where YEAR(DATE) = '2005'
group by family_member;

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
select name
from (
    select name, count(name) as cnt
    from Passenger
    group by name) t
where cnt > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count(first_name) as count
from Student
where first_name = 'Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
select count(distinct classroom) as count
from Schedule
where date = '2019-09-02'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
select floor(avg(floor((date(CURRENT_DATE()) - date(birthday))/10000))) as age
from FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
select good_type_name, sum(amount * unit_price) as costs
from GoodTypes
join Goods
on Goods.type = GoodTypes.good_type_id
join Payments
on Payments.good = Goods.good_id
where year(date) = 2005
group by good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
select floor(min(floor((date(CURRENT_DATE()) - date(birthday))/10000))) as year
from Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
select floor(max(floor((date(CURRENT_DATE()) - date(birthday))/10000))) as max_year
from Student
join Student_in_class
on Student_in_class.student = Student.id
join Class
on Class.id = Student_in_class.class
where Class.name like '10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
select status, member_name, sum(amount * unit_price) as costs
from FamilyMembers
join Payments
on Payments.family_member = FamilyMembers.member_id
join Goods
on Goods.good_id = Payments.good
join GoodTypes
on GoodTypes.good_type_id = Goods.type
where good_type_name = 'entertainment'
group by status,member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
delete from Company where id in (
    select id from (
        select id, rank() over(order by cnt) as rnk from (
            select Company.id as id, count(Trip.id) as cnt
            from Company
            join Trip
            on Trip.company = Company.id
            group by Company.id) t
        group by id) t2
    where rnk = 1)

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
select classroom
from (
    select classroom, count(*)
    from Schedule
    group by classroom
    having COUNT(*) = (
        select max(cnt)
        from (
            select classroom, count(id) as cnt
            from Schedule
            group by classroom
            order by count(id) desc) t
    )
) t2

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
select last_name
from Teacher
join Schedule
on Schedule.teacher = Teacher.id
join Subject
on Subject.id = Schedule.subject
where Subject.name = 'Physical Culture'
order by last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
select concat(last_name, '.', left(first_name, 1), '.', left(middle_name, 1), '.') as name
from Student
order by name