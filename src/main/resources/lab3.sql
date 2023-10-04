-- РАБОТА С ТАБЛИЦЕЙ Author
select name, surname from author where country='';
update author set country='' where name='' and surname='';
delete from author where name='' and surname='';

-- РАБОТА С ТАБЛИЦЕЙ Genre
select name from genre where is_fiction=false;
delete from genre where name='';

-- РАБОТА С ТАБЛИЦЕЙ Book
select title, series from book where author_id=1;
update book set genre_id='' where series='';
delete from book where id=1;

-- РАБОТА С ТАБЛИЦЕЙ Recommendation
select from recommendation where author_id=1;
delete from recommendation where book_id=1 and author_id=1;

-- РАБОТА С ТАБЛИЦЕЙ User
select from "User";
update "User" set is_admin=true where id=1;
delete from "User" where id=1;

-- РАБОТА С ТАБЛИЦЕЙ UserBook
select from UserBook where user_id=1 and book_id=1;
update UserBook set is_read=true and is_demanded=true where user_id=1 and book_id=1;
delete from UserBook where user_id=1 and book_id=1;

-- РАБОТА С ТАБЛИЦЕЙ Quote
SELECT id, contents FROM Quote;
UPDATE Quote SET contents = 'Updated quote' WHERE id = 1;
DELETE FROM Quote WHERE id = 1;

-- РАБОТА С ТАБЛИЦЕЙ BookReview
SELECT id, rating, contents FROM BookReview;
UPDATE BookReview SET rating = 80 WHERE id = 1;
DELETE FROM BookReview WHERE id = 1;

-- РАБОТА С ТАБЛИЦЕЙ Publisher
SELECT id, name, address FROM Publisher;
UPDATE Publisher SET phone = '987-654-3210' WHERE id = 1;
DELETE FROM Publisher WHERE id = 1;

-- РАБОТА С ТАБЛИЦЕЙ BookIssue
SELECT id, year, quantity, price FROM BookIssue;
UPDATE BookIssue SET price = 24.99 WHERE id = 1;
DELETE FROM BookIssue WHERE id = 1;

-- ИНДЕКСЫ
CREATE INDEX RatingIndex ON BookReview(rating);
CREATE INDEX NameSurnameIndex ON author(surname, name);