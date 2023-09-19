drop table if exists Publisher;
drop table if exists BookIssue;
drop table if exists BookReview;
drop table if exists Quote;
drop table if exists UserBook;
drop table if exists "User";
drop table if exists Recommendation;
drop table if exists Book;
drop table if exists Genre;
drop table if exists Author;

create table Author
(
    id      int generated by default as identity primary key,
    name    varchar NOT NULL,
    surname varchar,
    country varchar
);

insert into Author(name, surname, country) values ('Фёдор', 'Достоевский', 'Россия');
insert into Author(name, surname, country) values ('Лев', 'Толстой', 'Россия');
insert into Author(name, surname, country) values ('Михаил', 'Булгаков', 'СССР');
insert into Author(name, surname, country) values ('Михаил', 'Шолохов', 'СССР');
insert into Author(name, surname, country) values ('Стивен', 'Кинг', 'США');
insert into Author(name, surname, country) values ('Айзек', 'Азимов', 'США');
insert into Author(name, surname, country) values ('Агата', 'Кристи', 'Великобритания');
insert into Author(name, surname, country) values ('Артур Конан', 'Дойл', 'Великобритания');
insert into Author(name, surname, country) values ('Станислав', 'Лем', 'Польша');
insert into Author(name, surname, country) values ('Генрик', 'Сенкевич', 'Польша');
insert into Author(name, surname, country) values ('Болеслав', 'Прус', 'Польша');
insert into Author(name, surname, country) values ('Александр', 'Дюма', 'Франция');
insert into Author(name, surname, country) values ('Марсель', 'Пруст', 'Франция');

create table Genre
(
    id         int generated by default as identity primary key,
    is_fiction bool DEFAULT true,
    name       varchar
);

create table Book
(
    id        int generated by default as identity primary key,
    author_id int references Author (id) ON DELETE CASCADE,
    genre_id  int     references Genre (id) ON DELETE SET NULL,
    title     varchar not null,
    series    varchar
);

create table Recommendation
(
    book_id   int references Book (id) ON DELETE CASCADE,
    author_id int references Author (id) ON DELETE CASCADE,
    primary key (book_id, author_id)
);

create table "User"
(
    id       int generated by default as identity primary key,
    login    varchar(10) not null,
    password varchar(10) not null,
    is_admin boolean     not null default false
);

create table UserBook
(
    book_id     int references Book (id) ON DELETE CASCADE,
    user_id     int references "User" (id) ON DELETE CASCADE,
    primary key (book_id, user_id),

    is_read     bool default false,
    is_demanded bool default false
);

create table Quote
(
    id       int generated by default as identity primary key,
    book_id  int references Book (id),
    page     int     not null,
    contents varchar not null
);

create table BookReview
(
    id       int primary key references Book (id),
    user_id  int references "User" (id),
    book_id  int references Book (id),
    rating   int          not null,
    contents varchar(100) not null
);

create table Publisher
(
    id      int generated by default as identity primary key,
    name    varchar(30) not null,
    address varchar     not null,
    phone   varchar
);

create table BookIssue
(
    id           int generated by default as identity primary key,
    book_id      int references Book (id),
    publisher_id int references Publisher (id),

    year         int not null,
    quantity     int not null,
    price        double precision
);