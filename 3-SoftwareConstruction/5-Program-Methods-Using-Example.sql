DECLARE @login VARCHAR(30) = 'user1';
DECLARE @text VARCHAR(MAX) = 'sample text';
DECLARE @thread INT = 1;

DECLARE @result INT;
EXEC @result = CommentC @login, @text, @thread;

IF @result = 1
    SELECT '�������� ������ ������.' AS ResultMessage;
ELSE
    SELECT '������� ��� �������� ���������.' AS ResultMessage;