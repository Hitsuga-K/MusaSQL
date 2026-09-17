USE KWS;
GO


CREATE TABLE Users (
    UserID          INT IDENTITY(1,1) PRIMARY KEY,
    Username        NVARCHAR(50)  NOT NULL UNIQUE,
    Email           NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash    NVARCHAR(255) NOT NULL,
    RegistrationDate DATETIME2    NOT NULL DEFAULT GETDATE(),
    IsActive        BIT           NOT NULL DEFAULT 1
);
GO


CREATE TABLE UserProfiles (
    ProfileID       INT IDENTITY(1,1) PRIMARY KEY,
    UserID          INT           NOT NULL UNIQUE,         
    FirstName       NVARCHAR(50)  NULL,
    LastName        NVARCHAR(50)  NULL,
    BirthDate       DATE          NULL,
    Country         NVARCHAR(50)  NULL,
    AvatarURL       NVARCHAR(255) NULL,
    
    CONSTRAINT FK_UserProfiles_Users 
        FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE TABLE Developers (
    DeveloperID     INT IDENTITY(1,1) PRIMARY KEY,
    Name            NVARCHAR(100) NOT NULL,
    Country         NVARCHAR(50)  NULL,
    FoundedYear     INT           NULL,
    
    CONSTRAINT CK_Developers_FoundedYear 
        CHECK (FoundedYear IS NULL OR FoundedYear >= 1950)
);
GO

CREATE TABLE Publishers (
    PublisherID     INT IDENTITY(1,1) PRIMARY KEY,
    Name            NVARCHAR(100) NOT NULL,
    Country         NVARCHAR(50)  NULL
);
GO

CREATE TABLE Games (
    GameID          INT IDENTITY(1,1) PRIMARY KEY,
    Title           NVARCHAR(200) NOT NULL,
    Description     NVARCHAR(MAX) NULL,
    ReleaseDate     DATE          NULL,
    Price           DECIMAL(10,2) NOT NULL DEFAULT 0,
    PublisherID     INT           NULL,
    IsFree          BIT           NOT NULL DEFAULT 0,
    
    CONSTRAINT CK_Games_Price 
        CHECK (Price >= 0),
    
    CONSTRAINT FK_Games_Publishers 
        FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);
GO

CREATE TABLE Genres (
    GenreID         INT IDENTITY(1,1) PRIMARY KEY,
    Name            NVARCHAR(50)  NOT NULL UNIQUE
);
GO

CREATE TABLE Tags (
    TagID           INT IDENTITY(1,1) PRIMARY KEY,
    Name            NVARCHAR(50)  NOT NULL UNIQUE
);
GO

CREATE TABLE GameTags (
    GameID          INT NOT NULL,
    TagID           INT NOT NULL,
    
    PRIMARY KEY (GameID, TagID),
    
    CONSTRAINT FK_GameTags_Games 
        FOREIGN KEY (GameID) REFERENCES Games(GameID),
    CONSTRAINT FK_GameTags_Tags 
        FOREIGN KEY (TagID) REFERENCES Tags(TagID)
);
GO

CREATE TABLE GameDevelopers (
    GameID          INT NOT NULL,
    DeveloperID     INT NOT NULL,
    
    PRIMARY KEY (GameID, DeveloperID),
    
    CONSTRAINT FK_GameDevelopers_Games 
        FOREIGN KEY (GameID) REFERENCES Games(GameID),
    CONSTRAINT FK_GameDevelopers_Developers 
        FOREIGN KEY (DeveloperID) REFERENCES Developers(DeveloperID)
);
GO

CREATE TABLE GameGenres (
    GameID          INT NOT NULL,
    GenreID         INT NOT NULL,
    
    PRIMARY KEY (GameID, GenreID),
    
    CONSTRAINT FK_GameGenres_Games 
        FOREIGN KEY (GameID) REFERENCES Games(GameID),
    CONSTRAINT FK_GameGenres_Genres 
        FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);
GO

CREATE TABLE Purchases (
    PurchaseID      INT IDENTITY(1,1) PRIMARY KEY,
    UserID          INT           NOT NULL,
    GameID          INT           NOT NULL,
    PurchaseDate    DATETIME2     NOT NULL DEFAULT GETDATE(),
    PricePaid       DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT CK_Purchases_PricePaid 
        CHECK (PricePaid >= 0),
    
    CONSTRAINT FK_Purchases_Users 
        FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Purchases_Games 
        FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
GO

CREATE TABLE Libraries (
    LibraryID       INT IDENTITY(1,1) PRIMARY KEY,
    UserID          INT           NOT NULL,
    GameID          INT           NOT NULL,
    AddedDate       DATETIME2     NOT NULL DEFAULT GETDATE(),
    IsGift          BIT           NOT NULL DEFAULT 0,
    
    CONSTRAINT FK_Libraries_Users 
        FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Libraries_Games 
        FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
GO

CREATE TABLE Wallets (
    WalletID        INT IDENTITY(1,1) PRIMARY KEY,
    UserID          INT           NOT NULL UNIQUE,          
    Balance         DECIMAL(12,2) NOT NULL DEFAULT 0,
    
    CONSTRAINT CK_Wallets_Balance 
        CHECK (Balance >= 0),
    
    CONSTRAINT FK_Wallets_Users 
        FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE TABLE Transactions (
    TransactionID   INT IDENTITY(1,1) PRIMARY KEY,
    WalletID        INT           NOT NULL,
    Amount          DECIMAL(12,2) NOT NULL,
    TransactionType NVARCHAR(20)  NOT NULL,
    TransactionDate DATETIME2     NOT NULL DEFAULT GETDATE(),
    Description     NVARCHAR(255) NULL,
    
    CONSTRAINT CK_Transactions_Type 
        CHECK (TransactionType IN (N'Deposit', N'Purchase', N'Refund')),
    
    CONSTRAINT FK_Transactions_Wallets 
        FOREIGN KEY (WalletID) REFERENCES Wallets(WalletID)
);
GO

INSERT INTO Users (Username, Email, PasswordHash) VALUES
(N'govoryashiy_kot',        N'kot@mur.ru',            N'hash_mur'),
(N'chelovek_pelmen',        N'pelmen@gmail.com',      N'hash_pelmen'),
(N'admin_iz_sna',           N'son@yandex.ru',         N'hash_sleep'),
(N'kto_ukral_moy_kvas',     N'kvas@mail.ru',          N'hash_kvas'),
(N'windows_xp_fan',         N'xp@gmail.com',          N'hash_xp'),
(N'babushka_na_drone',      N'drone@yandex.ru',       N'hash_babka'),
(N'krolik_bez_kompleksov',  N'krolik@mail.ru',        N'hash_krolik');
GO

INSERT INTO UserProfiles (UserID, FirstName, LastName, BirthDate, Country) VALUES
(1, N'Антон',       N'Просто Антон',      '1834-03-12', N'Диван'),
(2, N'Пельмень',    N'Сметанович',        '1998-07-22', N'Кастрюля'),
(3, N'Сон',         N'Недосыпов',         '2007-11-05', N'Кровать'),
(4, N'Квас',        N'Украденный',        '2000-01-15', N'Холодильник'),
(5, N'Windows',     N'XP',                '1997-09-30', N'Синий экран'),
(6, N'Бабуля',      N'На Дроне',          '1930-04-18', N'Дача'),
(7, N'Кролик',      N'Без Комплексов',    '2010-12-03', N'Нора');
GO

INSERT INTO Developers (Name, Country, FoundedYear) VALUES
(N'Антон',                     N'Диван',         2002),
(N'Кот Валера',                N'Кухня',         1996),
(N'ООО «Пельмени и Софт»',     N'Кастрюля',      1986),
(N'TikTok',                    N'Интернет',      1997),
(N'Сосед с перфоратором',      N'Стена',         1988),
(N'Бабушка на дроне',          N'Дача',          2001),
(N'Кролик Инкорпорейтед',      N'Нора',          1984);
GO

INSERT INTO Publishers (Name, Country) VALUES
(N'Министерство Носков',       N'Ящик'),
(N'Квасная Федерация',         N'Бочка'),
(N'Союз Пельменей',            N'Морозилка'),
(N'TikTok',                    N'Интернет'),
(N'Бабуля Паблишинг',          N'Дача'),
(N'Кот Валера Геймс',          N'Кухня'),
(N'ООО «Синий Экран»',         N'Компьютер');
GO

INSERT INTO Games (Title, Description, ReleaseDate, Price, PublisherID, IsFree) VALUES
(N'TikTok: Хоррор',            N'Смотришь видео — а оно смотрит на тебя', '2020-12-10', 1999.00, 1, 0),
(N'Симулятор Носка',           N'Ты носок. Постирайся или умри',          '2004-11-16',  499.00, 2, 0),
(N'Антон против Всех',         N'Антон вышел за хлебом. Это был плохой день', '2022-02-25', 2499.00, 3, 0),
(N'Пельмень-Рогалик',          N'Рогалик, но ты пельмень',                '2020-11-10', 1799.00, 4, 0),
(N'GTA: Дача',                 N'Укради урожай у бабушки',                '2013-09-17',  999.00, 5, 0),
(N'Скайрим: Кролик',           N'Ты кролик. Ешь морковь. Стань драконом', '2011-11-11',  799.00, 6, 0),
(N'The Last of Us: Соседи',    N'Выживание после ремонта',                '2023-03-28', 2999.00, 7, 0),
(N'Дота 2: Диван',             N'Бесплатная MOBA, но ты лежишь',          '2013-07-09',    0.00, 2, 1),
(N'CS2: Кухня',                N'Тактический шутер тапками',              '2023-09-27',    0.00, 2, 1);
GO

INSERT INTO Genres (Name) VALUES
(N'TikTok'),
(N'Абсурд'),
(N'Хоррор на диване'),
(N'Стратегия поедания пельменей'),
(N'Симулятор носка'),
(N'Кроличий хоррор'),
(N'Приключения бабушки на дроне');
GO

INSERT INTO Tags (Name) VALUES
(N'кооператив с котом'),
(N'пиксель-арт из пельменей'),
(N'хоррор TikTok'),
(N'ранний доступ к холодильнику'),
(N'открытый мир дачи'),
(N'мультиплеер с бабушкой'),
(N'одиночная игра в носке'),
(N'сюжет про Антона');
GO


INSERT INTO GameTags (GameID, TagID) VALUES
(1, 5), (1, 7), (1, 8),         
(2, 7), (2, 8),                 
(3, 5), (3, 7), (3, 8),          
(4, 5), (4, 7),                  
(5, 5), (5, 6), (5, 7),          
(6, 5), (6, 7), (6, 8),         
(7, 7), (7, 8),                 
(8, 1), (8, 6),                 
(9, 1), (9, 6);                  
GO

INSERT INTO GameDevelopers (GameID, DeveloperID) VALUES
(1, 1),     
(2, 2),     
(3, 3),    
(4, 4),    
(5, 5),    
(6, 6),    
(7, 7),     
(8, 2),     
(9, 2);     
GO

INSERT INTO GameGenres (GameID, GenreID) VALUES
(1, 1), (1, 3),         
(2, 2),                 
(3, 1), (3, 3),          
(4, 3), (4, 7),         
(5, 3), (5, 7),
(6, 1),                 
(7, 3), (7, 7),         
(8, 4),                  
(9, 2);                 
GO

INSERT INTO Purchases (UserID, GameID, PricePaid) VALUES
(1, 1, 1999.00),
(1, 3, 2499.00),
(2, 5,  999.00),
(3, 2,  499.00),
(4, 6,  799.00),
(5, 4, 1799.00),
(6, 7, 2999.00),
(7, 1, 1999.00);
GO

INSERT INTO Libraries (UserID, GameID, IsGift) VALUES
(1, 1, 0),
(1, 3, 0),
(1, 8, 0),         
(2, 5, 0),
(2, 9, 0),          
(3, 2, 0),
(4, 6, 0),
(5, 4, 0),
(6, 7, 0),
(7, 1, 1);          
GO

INSERT INTO Wallets (UserID, Balance) VALUES
(1, 1500.00),
(2,  320.50),
(3,  890.00),
(4, 2100.00),
(5,   50.00),
(6, 5000.00),
(7,  750.25);
GO

INSERT INTO Transactions (WalletID, Amount, TransactionType, Description) VALUES
(1, 2000.00, N'Deposit',  N'Пополнение через карту'),
(1, -1999.00, N'Purchase', N'Покупка Cyberpunk 2077'),
(2, 1000.00, N'Deposit',  N'Пополнение'),
(2, -999.00, N'Purchase', N'Покупка GTA V'),
(3,  500.00, N'Deposit',  N'Пополнение'),
(4, 3000.00, N'Deposit',  N'Пополнение'),
(5,  100.00, N'Deposit',  N'Пополнение'),
(6, 5000.00, N'Deposit',  N'Пополнение'),
(7, 1000.00, N'Deposit',  N'Пополнение'),
(7, -1999.00, N'Purchase', N'Покупка Cyberpunk 2077');
GO

SELECT * FROM Users;
GO

SELECT * FROM Games;
GO

SELECT * FROM Genres;
GO

SELECT * FROM Tags;
GO

SELECT * FROM Developers;
GO

SELECT * FROM Publishers;
GO

SELECT * FROM Purchases;
GO

SELECT * FROM Libraries;
GO

SELECT * FROM Wallets;
GO

SELECT * FROM Transactions;
GO