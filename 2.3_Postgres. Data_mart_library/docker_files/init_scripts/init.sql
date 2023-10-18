CREATE TABLE IF NOT EXISTS public.reader_card (
    ReaderCardID serial PRIMARY KEY,
    Surname VARCHAR (50) NOT NULL,
    ReaderName  VARCHAR (50) NOT NULL,
    Patronymic VARCHAR (50),
    Address VARCHAR (250)
);
CREATE TABLE IF NOT EXISTS public.phone_number (
    ReaderCardID BIGINT,
    FOREIGN KEY (ReaderCardID) REFERENCES reader_card (ReaderCardID) ON DELETE CASCADE,
    PhoneNumber  VARCHAR (20) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.publisher (
    PublisherID serial PRIMARY KEY,
    PublisherName VARCHAR (200) NOT NULL,
    PublisherTown VARCHAR (200) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.book (
    BookID serial PRIMARY KEY,
    BookName VARCHAR (250) NOT NULL,
    YearIssue DATE,
    Volume INTEGER,
    Price NUMERIC (15,3),
    PublisherID BIGINT,
    FOREIGN KEY (PublisherID) REFERENCES publisher (PublisherID) ON DELETE CASCADE,
    Amount INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS public.reader_book (
    ReaderCardID BIGINT,
    BookID BIGINT,
    FOREIGN KEY (ReaderCardID) REFERENCES reader_card (ReaderCardID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES book (BookID) ON DELETE CASCADE,
    DateIssue DATE,
    DateReturn DATE, 
    BookOK BOOLEAN
);
CREATE TABLE IF NOT EXISTS public.warehouse_rest (
    BookID BIGINT,
    FOREIGN KEY (BookID) REFERENCES book (BookID) ON DELETE CASCADE,
    BookRest INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS public.genre (
    GenreID serial PRIMARY KEY,
    GenreName VARCHAR (100) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.author (
    AuthorID serial PRIMARY KEY,
    Author VARCHAR (250) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.book_author (
    BookID BIGINT,
    AuthorID BIGINT,
    FOREIGN KEY (BookID) REFERENCES book (BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES author (AuthorID) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS public.book_genre (
    BookID BIGINT,
    GenreID BIGINT,
    FOREIGN KEY (BookID) REFERENCES book (BookID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES genre (GenreID) ON DELETE CASCADE
);
INSERT INTO public.publisher (PublisherID, PublisherName, PublisherTown)  VALUES 
(1, 'Артхаус', 'Москва'),
(2, 'Дом книги', 'Санкт-Петербург'),
(3, 'Печатный дом', 'Омск');
INSERT INTO public.book (BookID, BookName, YearIssue, Volume, Price, PublisherID, Amount) VALUES 
(1, 'Остров желаний', '2022-07-09', 257, 30.0, 1, 20),
(2, 'Война и мир', '1922-07-09', 2570, 3000.0, 2, 10),
(3, 'О любви просто', '2018-04-09', 10, 157.0, 3, 10),
(4, 'Атлант расправил плечи', '2012-07-05', 2570, 189.0, 1, 10),
(5, 'Перевал', '2002-08-09', 324, 300.0, 3, 10),
(6, 'Село и сабли', '1955-01-04', 765, 29200.0, 1, 10),
(7, 'Ржавый гвоздь', '1999-02-07', 786, 5000.0, 3, 10),
(8, 'Человек и слон', '2021-12-09', 43, 10000.0, 2, 10);
INSERT INTO public.genre (GenreID, GenreName) VALUES 
(1, 'Роман'),
(2, 'Фэнтези'),
(3, 'Любовный роман'),
(4, 'Философия'),
(5, 'Научная фантастика');
INSERT INTO public.book_genre (BookID, GenreID)  VALUES 
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(3, 3),
(7, 4),
(8, 4),
(6, 5),
(5, 1);
INSERT INTO public.author (AuthorID, Author)VALUES 
(1, 'Толстой'),
(2, 'Крыжак'),
(3, 'Достоевский'),
(4, 'Сарк'),
(5, 'Дюпери'),
(6, 'Шимовной'),
(7, 'Потапов'),
(8, 'Лапшина');
INSERT INTO public.book_author (BookID, AuthorID) VALUES 
(1, 2),
(2, 1),
(3, 4),
(4, 5),
(5, 8),
(6, 7),
(7, 8),
(8, 3);
INSERT INTO public.reader_card (ReaderCardID, Surname, ReaderName, Patronymic, Address)  VALUES 
(1, 'Потапова', 'Марина', 'Александровна', null),
(2, 'Лапшин', 'Сергей', null, null),
(3, 'Дубакин', 'Александр', 'Игоревич', null),
(4, 'Ромашов', 'Олег', 'Иванович', null),
(5, 'Дубов', 'Максим', 'Алексеевич', null),
(6, 'Платонов', 'Николай', 'Максимович', null),
(7, 'Мордвинов', 'Петр', 'Матвеевич', null),
(8, 'Конов', 'Кирилл', 'Владимирович', null),
(9, 'Пузырьков', 'Михаил', 'Олегович', null);

INSERT INTO public.reader_book (ReaderCardID, BookID, DateIssue, DateReturn, BookOK) VALUES 
(1, 1, '2022-07-09', '2022-07-11', 'TRUE'),
(2, 2, '2022-07-11', '2022-08-11', 'TRUE'),
(2, 3, '2023-01-11', null, null),
(2, 7, '2022-09-09', '2023-07-11', 'TRUE'),
(2, 1, '2022-07-11', null, null),
(3, 3, '2023-01-11', '2023-01-14', null),
(4, 2, '2022-07-09', '2022-07-11', 'TRUE'),
(4, 5, '2022-02-11', '2022-08-11', 'TRUE'),
(5, 8, '2023-01-11', null, null),
(5, 7, '2022-03-09', '2023-03-11', 'TRUE'),
(6, 6, '2022-02-11', null, null),
(6, 3, '2023-02-11', '2023-02-21', null),
(8, 5, '2022-02-11', '2022-08-11', 'TRUE'),
(9, 8, '2022-01-11', null, null),
(9, 7, '2023-03-09', '2023-07-11', 'TRUE'),
(9, 6, '2023-02-11', null, null),
(9, 3, '2021-03-11', '2023-09-11', null);
