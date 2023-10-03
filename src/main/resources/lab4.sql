-- Несколько условий (см. lab3)
select * from author where name='' and surname='';

-- Вложенные конструкции
select name, surname from author
where name in (select name from author where id > 3);

-- Join-ы
select b.title from book b
join author a on b.author_id = a.id
where a.name = '' and a.surname = '';

SELECT q.id, q.contents, b.title
FROM Quote q JOIN Book b
ON q.book_id = b.id;

SELECT br.id, u.login, b.title, br.rating, br.contents
FROM BookReview br
JOIN "User" u ON br.user_id = u.id
JOIN Book b ON br.book_id = b.id;

SELECT bi.id, b.title, p.name, bi.year, bi.quantity, bi.price
FROM BookIssue bi
JOIN Book b ON bi.book_id = b.id
JOIN Publisher p ON bi.publisher_id = p.id;

-- Все виды join-ов
select title, series, name, is_fiction from book b join genre g on g.id = b.genre_id;
select title, series, name, is_fiction from book b left outer join genre g on g.id = b.genre_id;
select title, series, name, is_fiction from genre g right outer join book b on b.genre_id = g.id;
select title, series, name, is_fiction from book b full outer join genre g on b.genre_id = g.id;
select title, series, name, is_fiction from book cross join genre;
select t1.title, t1.id, t1.author_id, t2.id, t2.author_id from book t1 join book t2 on t1.id = t2.author_id;

-- GROUP BY, HAVING, UNION и агрегирующие функции
SELECT COUNT(genre_id) FROM book;
SELECT SUM(rating) FROM bookreview;
SELECT AVG(rating) FROM bookreview;
SELECT MIN(rating) FROM bookreview;
SELECT MAX(rating) FROM bookreview;

SELECT column, COUNT(*) FROM table GROUP BY column;

SELECT column, COUNT(*) FROM table GROUP BY column
HAVING COUNT(*) > 10;