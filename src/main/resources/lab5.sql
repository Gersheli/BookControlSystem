-- Создание триггера, который автоматически устанавливает текущую дату при вставке новой строки в таблицу "Book"
CREATE TRIGGER set_creation_date
    BEFORE INSERT ON Book
    FOR EACH ROW
EXECUTE FUNCTION update_creation_date();

-- Создание функции, которая обновляет столбец "creation_date" на текущую дату и время
CREATE OR REPLACE FUNCTION update_creation_date()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.creation_date = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

