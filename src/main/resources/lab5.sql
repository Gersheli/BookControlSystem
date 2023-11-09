-- Триггер для проверки, что поле author_id в таблице Book ссылается на существующего автора в таблице Author
CREATE OR REPLACE FUNCTION check_author_exists_book() RETURNS TRIGGER AS
$$ BEGIN
    IF NOT EXISTS(
            SELECT 1 FROM author WHERE id = NEW.author_id
        )
    THEN RAISE EXCEPTION 'Ошибка в таблице Book: Автор с id % не существует', NEW.author_id;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER book_author_trigger
    BEFORE INSERT OR UPDATE ON book
    FOR EACH ROW
EXECUTE FUNCTION check_author_exists_book();



-- Триггер для проверки, что поле genre_id в таблице Book ссылается на существующий жанр в таблице Genre:
CREATE OR REPLACE FUNCTION check_genre_exists_book() RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.genre_id IS NOT NULL AND NOT EXISTS (
            SELECT 1 FROM genre WHERE id = NEW.genre_id
        )
    THEN RAISE EXCEPTION 'Ошибка в таблице Book: Жанр с id % не существует', NEW.genre_id;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER book_genre_trigger
    BEFORE INSERT OR UPDATE ON book
    FOR EACH ROW
EXECUTE FUNCTION check_genre_exists_book();



-- Триггер для проверки наличия книги в таблице "Book" перед добавлением записи в таблицу "Recommendation"
CREATE OR REPLACE FUNCTION check_book_exists_recommendation() RETURNS TRIGGER AS
$$ BEGIN
    IF NOT EXISTS (
            SELECT 1 FROM Book WHERE id = NEW.book_id
        )
    THEN RAISE EXCEPTION 'Ошибка в таблице Recommendation: Книга с id % не существует', NEW.book_id;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER recommendation_book_trigger
    BEFORE INSERT ON Recommendation
    FOR EACH ROW
EXECUTE FUNCTION check_book_exists_recommendation();



-- Триггер для проверки наличия книги в таблице "Author" перед добавлением записи в таблицу "Recommendation"
CREATE OR REPLACE FUNCTION check_author_exists_recommendation() RETURNS TRIGGER AS
$$ BEGIN
    IF NOT EXISTS (
            SELECT 1 FROM author WHERE id = NEW.author_id
        )
    THEN RAISE EXCEPTION 'Ошибка в таблице Recommendation: Автор с id % не существует', NEW.author_id;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER recommendation_author_trigger
    BEFORE INSERT ON Recommendation
    FOR EACH ROW
EXECUTE FUNCTION check_author_exists_recommendation();



-- Триггер для проверки наличия пользователя в таблице "User" перед добавлением записи в таблицу "UserBook"
CREATE OR REPLACE FUNCTION check_user_exists_userbook() RETURNS TRIGGER AS
$$ BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM "User"
            WHERE id = NEW.user_id
        ) THEN
    RAISE EXCEPTION 'Ошибка в таблице UserBook: Пользователь с id % не существует', NEW.user_id;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER userbook_user_trigger
    BEFORE INSERT ON UserBook
    FOR EACH ROW
EXECUTE FUNCTION check_user_exists_userbook();



-- Триггер для проверки наличия книги в таблице "Book" перед добавлением записи в таблицу "UserBook"
CREATE OR REPLACE FUNCTION check_book_exists_userbook()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM Book
            WHERE id = NEW.book_id
        ) THEN
        RAISE EXCEPTION 'Ошибка в таблице UserBook: Книга с id % не существует', NEW.book_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER userbook_book_trigger
    BEFORE INSERT ON UserBook
    FOR EACH ROW
EXECUTE FUNCTION check_book_exists_userbook();



-- Триггер для проверки наличия книги в таблице "Book" перед добавлением записи в таблицу "BookIssue"
CREATE OR REPLACE FUNCTION check_book_exists_bookissue()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM Book
            WHERE id = NEW.book_id
        ) THEN
        RAISE EXCEPTION 'Ошибка в таблице BookIssue: Книга с id % не существует', NEW.book_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER bookissue_book_trigger
    BEFORE INSERT ON BookIssue
    FOR EACH ROW
EXECUTE FUNCTION check_book_exists_bookissue();



-- Триггер для проверки наличия книги в таблице "Publisher" перед добавлением записи в таблицу "BookIssue"
CREATE OR REPLACE FUNCTION check_publisher_exists_bookissue()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM Publisher
            WHERE id = NEW.publisher_id
        ) THEN
        RAISE EXCEPTION 'Ошибка в таблице BookIssue: Publisher с id % не существует', NEW.publisher_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER bookissue_publisher_trigger
    BEFORE INSERT ON BookIssue
    FOR EACH ROW
EXECUTE FUNCTION check_publisher_exists_bookissue();