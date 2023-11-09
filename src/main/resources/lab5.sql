-- Триггер для проверки, что поле author_id в таблице Book ссылается на существующего автора в таблице Author
CREATE OR REPLACE FUNCTION validate_author()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS(
            SELECT 1 FROM author WHERE id = NEW.author_id
        ) THEN
        RAISE EXCEPTION 'Автор не существует';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER book_author_trigger
    BEFORE INSERT OR UPDATE
    ON book
    FOR EACH ROW
EXECUTE FUNCTION validate_author();



-- Триггер для проверки, что поле genre_id в таблице Book ссылается на существующий жанр в таблице Genre:
CREATE OR REPLACE FUNCTION validate_genre()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.genre_id IS NOT NULL AND NOT EXISTS (
            SELECT 1 FROM genre WHERE id = NEW.genre_id
        ) THEN
        RAISE EXCEPTION 'Жанр не существует';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER book_genre_trigger
    BEFORE INSERT OR UPDATE ON book
    FOR EACH ROW
EXECUTE FUNCTION validate_genre();



-- Триггер для проверки, что пользователь не может иметь несколько копий одной и той же книги в таблице UserBook
CREATE OR REPLACE FUNCTION validate_userbook_duplicates()
    RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
            SELECT 1 FROM userbook
            WHERE user_id = NEW.user_id
              AND book_id = NEW.book_id
              AND is_demanded = TRUE
        ) THEN
        RAISE EXCEPTION 'Пользователь уже запросил данную книгу';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER userbook_duplicates_trigger
    BEFORE INSERT OR UPDATE ON userbook
    FOR EACH ROW
EXECUTE FUNCTION validate_userbook_duplicates();



-- Триггер для проверки наличия книги в таблице "Book" перед добавлением записи в таблицу "Recommendation"
CREATE OR REPLACE FUNCTION check_book_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM Book
            WHERE id = NEW.book_id
        ) THEN
        RAISE EXCEPTION 'Книга с id % не существует', NEW.book_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_book_exists
    BEFORE INSERT ON Recommendation
    FOR EACH ROW
EXECUTE FUNCTION check_book_exists();



-- Триггер для проверки оценки книги в таблице "BookReview" перед добавлением записи
CREATE OR REPLACE FUNCTION check_rating_range()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rating < 0 OR NEW.rating > 100 THEN
        RAISE EXCEPTION 'Rating must be between 0 and 100';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_rating_range
    BEFORE INSERT ON BookReview
    FOR EACH ROW
EXECUTE FUNCTION check_rating_range();



-- Триггер для проверки наличия пользователя в таблице "User" перед добавлением записи в таблицу "UserBook"
CREATE OR REPLACE FUNCTION check_user_exists()
    RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
            SELECT 1
            FROM "User"
            WHERE id = NEW.user_id
        ) THEN
        RAISE EXCEPTION 'User with id % does not exist', NEW.user_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_user_exists
    BEFORE INSERT ON UserBook
    FOR EACH ROW
EXECUTE FUNCTION check_user_exists();



