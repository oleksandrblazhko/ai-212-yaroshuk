CREATE PROCEDURE CommentC (
    @login VARCHAR(30),
    @text TEXT,
    @thread INT
)
AS
BEGIN
	-- Перевірка, чи існує користувач з вказаним логіном та чи не перевищено максимальну довжину логіна
    IF NOT EXISTS (SELECT 1 FROM usermod WHERE login = @login) OR LEN(@login) > 30
        RETURN 0;
	-- Перевірка, чи не перевищена максимальна довжина тексту коментаря
    IF DATALENGTH(@text) > 2000
        RETURN 0;
	-- Перевірка, чи існує вказаний пост
    IF NOT EXISTS (SELECT 1 FROM Post WHERE id = @thread)
        RETURN 0;

	-- Вставка нового коментаря
    INSERT INTO comment (usermod.id, thread, text, date_created)
    VALUES (
        (SELECT id FROM usermod WHERE id = @login),
        (SELECT id FROM post WHERE id = @thread),
        @text,
        GETDATE()
    );
	-- Повернення успішного результату
    RETURN 1;
END;