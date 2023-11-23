CREATE TABLE usermod(
	id INT PRIMARY KEY,
	login VARCHAR(30) NOT NULL,
	email VARCHAR(255) NOT NULL,
	password VARCHAR(30) NOT NULL,
	date_created DATE NOT NULL
	CONSTRAINT email_validation CHECK (email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$')
);

CREATE TABLE art_piece(
	id INT PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	creator VARCHAR(30) NOT NULL REFERENCES usermod(id),
	price NUMERIC NOT NULL,
	picture LONGBLOB,
	comment TEXT,
	date_put_on_sale DATE NOT NULL
);

CREATE TABLE post(
	id INT PRIMARY KEY,
	headline VARCHAR(80) NOT null,
	main_text TEXT NOT null,
	creator VARCHAR(30) NOT NULL REFERENCES usermod(id),
	picture LONGBLOB,
	date_created DATE NOT NULL
);

CREATE TABLE comment(
	id INT PRIMARY KEY,
	thread INT NOT NULL REFERENCES post(id),
	creator VARCHAR(30) NOT NULL REFERENCES usermod(id),
	date_created DATE NOT NULL
);