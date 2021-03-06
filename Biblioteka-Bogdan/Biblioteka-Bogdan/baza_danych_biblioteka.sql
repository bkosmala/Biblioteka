USE [testy]
GO
/****** Object:  StoredProcedure [dbo].[Biblioteka_DML]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Biblioteka_DML]
AS
   declare @InsertControl int;
   declare @UpdateControl int;
   declare @DeleteControl int;
   set @InsertControl=0;
   set @UpdateControl=0;
   set @DeleteControl=0;

   SET NOCOUNT ON;


INSERT INTO [Biblioteka.Wypozyczenia] VALUES (1,1,1,DATEADD(hour,cast(rand()*10 as int)%9,DATEADD(day,cast(rand()*1000 as int)%365,'2014-01-01 8:10:13.000')),
													DATEADD(hour,cast(rand()*10 as int)%9,DATEADD(day,cast(rand()*1000 as int)%365,'2015-01-02 8:10:13.000'))),
											 (1,1,1,DATEADD(hour,cast(rand()*10 as int)%9,DATEADD(day,cast(rand()*1000 as int)%365,'2014-01-01 8:10:13.000')),
													DATEADD(hour,cast(rand()*10 as int)%9,DATEADD(day,cast(rand()*1000 as int)%365,'2015-01-02 8:10:13.000')));
select @InsertControl = @@ROWCOUNT;

update [Biblioteka.Wypozyczenia] set data_zwrotu=null where id_czyt=92
select @UpdateControl = @@ROWCOUNT; 

delete from [Biblioteka.Wypozyczenia] where id_poz=1 and id_czyt=1 and id_prac=1;
select @DeleteControl = @@ROWCOUNT; 

SELECT @InsertControl as ilosc_insert,@UpdateControl as ilosc_update, @DeleteControl  as ilosc_delete;


GO
/****** Object:  StoredProcedure [dbo].[Biblioteka_Get_Category_Names]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Biblioteka_Get_Category_Names]
AS
select nazwa from [Biblioteka.Kategorie] order by nazwa;
GO
/****** Object:  StoredProcedure [dbo].[Biblioteka_Get_Pozycje_W_Kategorii]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Biblioteka_Get_Pozycje_W_Kategorii] @s nvarchar(30)
AS
select * from [Biblioteka.Pozycje] where id_kategorii = (select id_kategoria from [Biblioteka.Kategorie] where nazwa=@s);
GO
/****** Object:  StoredProcedure [dbo].[Czytelnicy_Z_Miasta]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Czytelnicy_Z_Miasta] @miasto nvarchar(40)
AS
BEGIN
	SELECT Top 10 * from [Biblioteka.Czytelnicy] as c
	where c.miejscowosc = @miasto
END
GO
/****** Object:  StoredProcedure [dbo].[Czytelnik_O_Id]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Czytelnik_O_Id] @id int
AS
BEGIN
	SELECT * from [Biblioteka.Czytelnicy] as c
	where c.id_czyt = @id
END

GO
/****** Object:  StoredProcedure [dbo].[Pesel_Czytelnika_O_Id]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pesel_Czytelnika_O_Id] @id int
AS
BEGIN
	SELECT pesel from [Biblioteka.Czytelnicy] as c
	where c.id_czyt = @id
END

GO
/****** Object:  Table [dbo].[Biblioteka.Czytelnicy]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biblioteka.Czytelnicy](
	[id_czyt] [int] IDENTITY(1,1) NOT NULL,
	[imie] [nvarchar](30) NOT NULL,
	[nazwisko] [nvarchar](40) NOT NULL,
	[miejscowosc] [nvarchar](40) NOT NULL,
	[adres] [nvarchar](50) NOT NULL,
	[pesel] [decimal](11, 0) NOT NULL,
	[telefon] [nvarchar](15) NULL,
 CONSTRAINT [PK_Biblioteka.Czytelnicy] PRIMARY KEY CLUSTERED 
(
	[id_czyt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Biblioteka.Kategorie]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biblioteka.Kategorie](
	[id_kategoria] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [nvarchar](30) NOT NULL,
	[opis] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Biblioteka.Kategorie] PRIMARY KEY CLUSTERED 
(
	[id_kategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Biblioteka.Logi]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biblioteka.Logi](
	[id_log] [int] IDENTITY(1,1) NOT NULL,
	[opis] [nvarchar](150) NOT NULL,
	[data] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Biblioteka.Pozycje]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biblioteka.Pozycje](
	[id_poz] [int] IDENTITY(1,1) NOT NULL,
	[tytul] [nvarchar](50) NOT NULL,
	[autor] [nvarchar](40) NOT NULL,
	[opis] [nvarchar](150) NULL,
	[jezyk] [nchar](5) NULL,
	[wydawca] [nvarchar](30) NULL,
	[rok_wydania] [int] NOT NULL,
	[id_kategorii] [int] NOT NULL,
 CONSTRAINT [PK_Biblioteka.Pozycje_1] PRIMARY KEY CLUSTERED 
(
	[id_poz] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Biblioteka.Pracownicy]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biblioteka.Pracownicy](
	[id_prac] [int] IDENTITY(1,1) NOT NULL,
	[imie] [nvarchar](20) NOT NULL,
	[nazwisko] [nvarchar](30) NOT NULL,
	[miejscowosc] [nvarchar](40) NOT NULL,
	[adres] [nvarchar](50) NOT NULL,
	[pesel] [decimal](11, 0) NOT NULL,
	[telefon] [nvarchar](20) NULL,
 CONSTRAINT [PK_Biblioteka.Pracownicy] PRIMARY KEY CLUSTERED 
(
	[id_prac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Biblioteka.Wypozyczenia]    Script Date: 10-08-2016 16:59:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biblioteka.Wypozyczenia](
	[id_poz] [int] NOT NULL,
	[id_czyt] [int] NOT NULL,
	[id_prac] [int] NOT NULL,
	[data_wypozyczenia] [datetime] NOT NULL,
	[data_zwrotu] [datetime] NULL,
	[ilosc_dni_wypozyczenia]  AS (datediff(day,[data_wypozyczenia],[data_zwrotu]))
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Biblioteka.Pozycje]  WITH CHECK ADD  CONSTRAINT [FK_Biblioteka.Pozycje_Biblioteka.Kategorie] FOREIGN KEY([id_kategorii])
REFERENCES [dbo].[Biblioteka.Kategorie] ([id_kategoria])
GO
ALTER TABLE [dbo].[Biblioteka.Pozycje] CHECK CONSTRAINT [FK_Biblioteka.Pozycje_Biblioteka.Kategorie]
GO
ALTER TABLE [dbo].[Biblioteka.Wypozyczenia]  WITH CHECK ADD  CONSTRAINT [FK_Biblioteka.Wypozyczenia_Biblioteka.Czytelnicy1] FOREIGN KEY([id_czyt])
REFERENCES [dbo].[Biblioteka.Czytelnicy] ([id_czyt])
GO
ALTER TABLE [dbo].[Biblioteka.Wypozyczenia] CHECK CONSTRAINT [FK_Biblioteka.Wypozyczenia_Biblioteka.Czytelnicy1]
GO
ALTER TABLE [dbo].[Biblioteka.Wypozyczenia]  WITH CHECK ADD  CONSTRAINT [FK_Biblioteka.Wypozyczenia_Biblioteka.Pozycje] FOREIGN KEY([id_poz])
REFERENCES [dbo].[Biblioteka.Pozycje] ([id_poz])
GO
ALTER TABLE [dbo].[Biblioteka.Wypozyczenia] CHECK CONSTRAINT [FK_Biblioteka.Wypozyczenia_Biblioteka.Pozycje]
GO
ALTER TABLE [dbo].[Biblioteka.Wypozyczenia]  WITH CHECK ADD  CONSTRAINT [FK_Biblioteka.Wypozyczenia_Biblioteka.Pracownicy] FOREIGN KEY([id_prac])
REFERENCES [dbo].[Biblioteka.Pracownicy] ([id_prac])
GO
ALTER TABLE [dbo].[Biblioteka.Wypozyczenia] CHECK CONSTRAINT [FK_Biblioteka.Wypozyczenia_Biblioteka.Pracownicy]
GO
ALTER TABLE [dbo].[Biblioteka.Czytelnicy]  WITH CHECK ADD  CONSTRAINT [maska_wprowadzania_telefonu_dla_czytelnika] CHECK  (([telefon] like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Biblioteka.Czytelnicy] CHECK CONSTRAINT [maska_wprowadzania_telefonu_dla_czytelnika]
GO
ALTER TABLE [dbo].[Biblioteka.Pracownicy]  WITH CHECK ADD  CONSTRAINT [maska_wprowadzania_telefonu_dla_pracownika] CHECK  (([telefon] like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Biblioteka.Pracownicy] CHECK CONSTRAINT [maska_wprowadzania_telefonu_dla_pracownika]
GO
