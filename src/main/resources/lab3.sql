select name, surname from author where country='';
update author set country='' where name='' and surname='';
delete from author where name='' and surname='';

select name from genre where is_fiction=false;
delete from genre where name='';

select title, series from book where author_id=1;
update book set genre_id='' where series='';
delete from book where id=1;

select from recommendation where author_id=1;
delete from recommendation where book_id=1 and author_id=1;

select from "User";
update "User" set is_admin=true where id=1;
delete from "User" where id=1;

