-- create table
create table weather (
    city varchar(80),
    temp_lo int,
    temp_hi int,
    prcp real,
    date date
);

create table cities (name varchar(80), location point);

-- drop table
drop table tablename;

-- insert row to table
insert into
    weather
values
    ('cityname', 46, 50, 0.25, '1994-11-27');

--city,temp_lo,temp_hi,prcp,date
-- here we can omit some columns and also we can do in any order
insert into
    weather (city, temp_lo, temp_hi, prcp, date)
values
    ('san francisco', 43, 57, 0.0, '1994-11-29');

-- copy the row from plain text file 
copy weather
from
    '/home/user/weather.txt';

-- select the all row from table
-- we can also specify the row explicitly 
select
    *
from
    weather;

-- we can also give the name to the columns with 'AS' keyword
select
    city,
    (temp_lo + temp_hi) / 2 as temp_avg,
    date
from
    weather;

-- here we can give condition to where
select
    *
from
    weather
where
    city = 'san francisco'
    and prcp > 0.0;

-- we can sort the result with order by 
-- we can also spacify multipal column in order by 
select
    *
from
    weather
order by
    city;

-- we can  remove duplicate entry with distinct
select
    distinct city
from
    weather;

-- joins 
select
    *
from
    weather
    join cities on city = name;

select
    city,
    temp_lo,
    temp_hi,
    prcp,
    date,
    location
from
    weather
    join cities on city = name;

-- left join
select
    * weather
    left outer join cities on weather.city = cities.name;

-- aggregate functions
-- WE CAN'T USE AGGREGATE FUNCTIONS IN WHERE CLUSE,
--  BECAUSE WHERE IS EVALUATED FIRST AND THEN AGGREGATE FUNCTION PERFORM ON THAT DATA
-- max
select
    max(temp_lo)
from
    weather;

-- WE CAN USE AGGREGATE IN SUBQUERY
-- here sub query execute first,
-- then result of that sub query assign to the temp_to and
--  then this will become the condition for the where cluse
select
    city
from
    weather
where
    temp_lo = (
        select
            max(temp_lo)
        from
            weather
    );

-- group by - it is used to group the same data like number of male and female in organigation
--here we are doing group by city so we get max temp_lo for all city 
select
    city,
    max(temp_lo)
from
    weather
group by
    city;

-- having
-- it execute on result of group by 
select
    city,
    max(temp_lo)
from
    weather
group by
    city
having
    max(temp_lo) < 40;

-- updates
update
    weather
set
    temp_hi = temp_hi -2,
    temp_lo = temp_lo - 2
where
    date > '1994-11-28';

-- deletions
delete from
    weather
where
    city = 'hayward';

--without where it delete all the row from the table 
--it also don't ask for confirmation.
delete from
    tablename;

-- views
create view viewname as
select
    name,
    temp_lo,
    temp_hi,
    prcp,
    data,
    location
from
    weather,
    cities
where
    city = name;

select
    *
from
    viewname;

--Foreign keys
create table cities (
    name varchar(80) primary key,
    location point
);

create table weather (
    city varchar(80) references cities(name),
    temp_lo int,
    temp_hi int,
    prcp real,
    date date
);

-- this give error as berkeley is not present in cities table 
insert into
    weather
values
    ('berkeley', 45, 53, 0.0, '1994-11-28');

-- summary below IN LINE 161
-- LIKE
select
    last_name,
    height
from
    players
where
    last_name Like 'jam%';

-- IN 
select
    *
from
    games
where
    month IN ('may', 'june');

-- NOT IN 
select
    *
from
    games
where
    month NOT IN ('may', 'june');

-- AND
select
    last_name
from
    games
where
    last_name is 'james'
    AND 'davis';

-- OR
select
    *
from
    players
where
    team LIKE '%lakers'
    AND (
        last_name = 'davis'
        OR last_name = "james"
    );

-- BETWEEN
select
    *
from
    games
from
    games
where
    date BETWEEN '2020-01-01'
    AND '2020-04-01';

-- IS NULL
select
    *
from
    players
where
    last_name IS NULL;

-- summary --
-- SELECT
-- FROM
-- LIMIT 
-- ORDER BY
-- WHERE
-- logical operaors --
-- like 
-- IN
-- NOT
-- AND
-- OR
-- BETWEEN
-- IS NULL
-- join in sql
select
    *
from
    avocados
    left join avo_type on avocados.type = avo_type.typeid;

-- exists
-- it return the true if the query return the one or more data
select
    name
from
    customers
where
    exists (
        select
            item
        from
            orders
        where
            customers.id = orders.id
            AND price < 50
    );

-- copying selections from table to table
-- this will copy the record into to tablename table
insert into
    tablename
select
    *
from
    orders
where
    date <= 1 / 1 / 2018;

-- catching NULL results
select
    Item,
    Price * (QtyInStock + IFNULL(QtYOnOrder, 0)) form orders;

-- to work on aggregate functions we use HAVING
select
    count(id),
    region
from
    customers
group by
    region
HAVING
    count(id) > 0;