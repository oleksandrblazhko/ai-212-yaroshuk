CREATE PROCEDURE CommentC (
    @login VARCHAR(30),
    @text TEXT,
    @thread INT
)
AS
BEGIN
	-- ��������, �� ���� ���������� � �������� ������ �� �� �� ���������� ����������� ������� �����
    IF NOT EXISTS (SELECT 1 FROM usermod WHERE login = @login) OR LEN(@login) > 30
        RETURN 0;
	-- ��������, �� �� ���������� ����������� ������� ������ ���������
    IF DATALENGTH(@text) > 2000
        RETURN 0;
	-- ��������, �� ���� �������� ����
    IF NOT EXISTS (SELECT 1 FROM Post WHERE id = @thread)
        RETURN 0;

	-- ������� ������ ���������
    INSERT INTO comment (usermod.id, thread, text, date_created)
    VALUES (
        (SELECT id FROM usermod WHERE id = @login),
        (SELECT id FROM post WHERE id = @thread),
        @text,
        GETDATE()
    );
	-- ���������� �������� ����������
    RETURN 1;
END;