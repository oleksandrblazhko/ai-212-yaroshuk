--Створення таблиці Користувачів
CREATE TABLE usermod(
	id INT PRIMARY KEY,
	login VARCHAR(30) NOT NULL,
	email VARCHAR(255) NOT NULL,
	password VARCHAR(30) NOT NULL,
	date_created DATE NOT NULL
	CONSTRAINT email_validation CHECK (email LIKE '%@%.%')
);

--Створення таблиці Витворів мистецтва
CREATE TABLE art_piece(
	id INT PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	creator INT NOT NULL REFERENCES usermod(id),
	price NUMERIC NOT NULL,
	picture image,
	comment TEXT,
	date_put_on_sale DATE NOT NULL
);

--Створення таблиці Постів
CREATE TABLE post(
	id INT PRIMARY KEY,
	headline VARCHAR(80) NOT null,
	main_text TEXT NOT null,
	creator INT NOT NULL REFERENCES usermod(id),
	picture image,
	date_created DATE NOT NULL
);

--Створення таблиці Коментарів для постів
CREATE TABLE comment(
	id INT PRIMARY KEY,
	thread INT NOT NULL REFERENCES post(id),
	creator INT NOT NULL REFERENCES usermod(id),
	text text NOT NULL,
	date_created DATE NOT NULL
);