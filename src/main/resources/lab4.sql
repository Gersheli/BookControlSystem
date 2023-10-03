select * from author where name='' and surname='';

select b.title from book b
join author a on b.author_id = a.id
where a.name = '' and a.surname = '';

select name, surname from author
where name in (select name from author where id > 3);

select title, series, name, is_fiction from book b join genre g on g.id = b.genre_id;
select title, series, name, is_fiction from book b left outer join genre g on g.id = b.genre_id;
select title, series, name, is_fiction from genre g right outer join book b on b.genre_id = g.id;
select title, series, name, is_fiction from book b full outer join genre g on b.genre_id = g.id;
select title, series, name, is_fiction from book cross join genre;
select t1.title, t1.id, t1.author_id, t2.id, t2.author_id from book t1 join book t2 on t1.id = t2.author_id;