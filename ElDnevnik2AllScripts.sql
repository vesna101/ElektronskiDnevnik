USE [ElDnevnik2]
GO
/****** Object:  Table [dbo].[Ucenici]    Script Date: 9/20/2018 2:58:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ucenici](
	[MaticniBroj] [char](7) NOT NULL,
	[Ime] [nvarchar](50) NOT NULL,
	[Prezime] [nvarchar](50) NOT NULL,
	[OdeljenjeID] [int] NOT NULL,
	[JMBG] [nvarchar](50) NULL,
	[DatumRodjenja] [nvarchar](50) NULL,
	[MestoRodjenja] [nvarchar](50) NULL,
	[OpstinaRodjenja] [nvarchar](50) NULL,
	[Drzava] [nvarchar](50) NULL,
	[Telefon] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[OtacIme] [nvarchar](50) NULL,
	[OtacPrezime] [nvarchar](50) NULL,
	[OtacTelefon] [nvarchar](50) NULL,
	[OtacEmail] [nvarchar](50) NULL,
	[MajkaIme] [nvarchar](50) NULL,
	[MajkaPrezime] [nvarchar](50) NULL,
	[MajkaTelefon] [nvarchar](50) NULL,
	[MajkaEmail] [nvarchar](50) NULL,
	[Sifra] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaticniBroj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Predmeti]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Predmeti](
	[PredmetID] [int] IDENTITY(1,1) NOT NULL,
	[Redosled] [int] NOT NULL,
	[Naziv] [nvarchar](50) NOT NULL,
	[ProfesorID] [int] NOT NULL,
	[GodinaID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PredmetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OceneDnevnik]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OceneDnevnik](
	[OcenaID] [int] IDENTITY(1,1) NOT NULL,
	[TipOcene] [nvarchar](50) NULL,
	[Ocena] [int] NOT NULL,
	[DatumOcene] [date] NOT NULL,
	[MaticniBroj] [char](7) NOT NULL,
	[ProfesorID] [int] NOT NULL,
	[PredmetID] [int] NOT NULL,
 CONSTRAINT [PK__OceneDne__9668938D6A020FCB] PRIMARY KEY CLUSTERED 
(
	[OcenaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profesori]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesori](
	[ProfesorID] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[Telefon] [nvarchar](50) NULL,
	[Sifra] [nvarchar](50) NOT NULL,
	[ProfAdmin] [bit] NOT NULL,
 CONSTRAINT [PK__Profesor__4DF3F028E999DD7A] PRIMARY KEY CLUSTERED 
(
	[ProfesorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SveOcene]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SveOcene]
AS
SELECT Ucenici.Ime AS ImeUcenika, Ucenici.Prezime AS PrezimeUcenika, Ocena, TipOcene, Naziv, Profesori.Ime AS ImeProfesora, DatumOcene  FROM OceneDnevnik
JOIN Ucenici ON Ucenici.MaticniBroj = OceneDnevnik.MaticniBroj
JOIN Predmeti ON Predmeti.PredmetID = OceneDnevnik.PredmetID
JOIN Profesori ON Profesori.ProfesorID = OceneDnevnik.ProfesorID
GO
/****** Object:  View [dbo].[SveOcene2]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SveOcene2]
AS
SELECT Ucenici.MaticniBroj AS [Матични број ученика], Ucenici.Ime AS [Име ученика], Ucenici.Prezime AS [Презиме ученика], Ocena AS Оцена, TipOcene AS [Тип оцене], OD.PredmetID, Naziv AS [Предмет], OD.ProfesorID, Profesori.Ime AS [Професор], DatumOcene AS [Датум] 
FROM OceneDnevnik AS OD
JOIN Ucenici ON Ucenici.MaticniBroj = OD.MaticniBroj
JOIN Predmeti ON Predmeti.PredmetID = OD.PredmetID
JOIN Profesori ON Profesori.ProfesorID = OD.ProfesorID
GO
/****** Object:  Table [dbo].[Odeljenja]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Odeljenja](
	[OdeljenjeID] [int] IDENTITY(1,1) NOT NULL,
	[OdeljenjeBr] [int] NOT NULL,
	[GodinaID] [int] NOT NULL,
	[Razredni] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OdeljenjeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_Odeljenja] UNIQUE NONCLUSTERED 
(
	[OdeljenjeBr] ASC,
	[GodinaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Godine]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Godine](
	[GodinaID] [int] IDENTITY(1,1) NOT NULL,
	[GodinaSkolovanja] [int] NOT NULL,
	[SkolskaGodina] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GodinaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_Godine] UNIQUE NONCLUSTERED 
(
	[GodinaSkolovanja] ASC,
	[SkolskaGodina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[IspisOdeljenja]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE VIEW [dbo].[IspisOdeljenja]
  AS
  SELECT OdeljenjeID, Godine.GodinaSkolovanja, Odeljenja.OdeljenjeBr
  FROM Odeljenja
	JOIN Godine
	ON Odeljenja.GodinaID = Godine.GodinaID
GO
/****** Object:  Table [dbo].[Arhiva]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arhiva](
	[MaticniBroj] [char](7) NOT NULL,
	[Ime] [nvarchar](50) NOT NULL,
	[Prezime] [nvarchar](50) NOT NULL,
	[OdeljenjeID] [int] NOT NULL,
	[JMBG] [nvarchar](50) NULL,
	[DatumRodjenja] [nvarchar](50) NULL,
	[MestoRodjenja] [nvarchar](50) NULL,
	[OpstinaRodjenja] [nvarchar](50) NULL,
	[Drzava] [nvarchar](50) NULL,
	[Telefon] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[OtacIme] [nvarchar](50) NULL,
	[OtacPrezime] [nvarchar](50) NULL,
	[OtacTelefon] [nvarchar](50) NULL,
	[OtacEmail] [nvarchar](50) NULL,
	[MajkaIme] [nvarchar](50) NULL,
	[MajkaPrezime] [nvarchar](50) NULL,
	[MajkaTelefon] [nvarchar](50) NULL,
	[MajkaEmail] [nvarchar](50) NULL,
	[Sifra] [nvarchar](50) NOT NULL,
	[PredmetID] [int] NOT NULL,
	[ZakljucnaOcena] [int] NOT NULL,
	[GodinaID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaticniBroj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OcenePromene]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OcenePromene](
	[PromenaID] [int] IDENTITY(1,1) NOT NULL,
	[OcenaID] [int] NOT NULL,
	[TipOcene] [nvarchar](50) NULL,
	[Ocena] [nvarchar](50) NOT NULL,
	[DatumOcene] [date] NOT NULL,
	[MaticniBroj] [char](7) NOT NULL,
	[ProfesorID] [int] NOT NULL,
	[PredmetID] [int] NOT NULL,
 CONSTRAINT [PK__OcenePro__016494759B3D7924] PRIMARY KEY CLUSTERED 
(
	[PromenaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OceneTipovi]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OceneTipovi](
	[TipOcene] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TipOcene] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfesoriPredmetiOdeljenja]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfesoriPredmetiOdeljenja](
	[ProfPredOdID] [int] IDENTITY(1,1) NOT NULL,
	[ProfesorID] [int] NOT NULL,
	[PredmetID] [int] NOT NULL,
	[OdeljenjeID] [int] NOT NULL,
 CONSTRAINT [PK_PPO] PRIMARY KEY CLUSTERED 
(
	[ProfesorID] ASC,
	[PredmetID] ASC,
	[OdeljenjeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SesijeKorisnika]    Script Date: 9/20/2018 2:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SesijeKorisnika](
	[SesijaID] [int] NOT NULL,
	[Korisnik] [int] NOT NULL,
	[VremeLogIn] [datetime] NULL,
	[VremeLogOut] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SesijaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UceniciPredmeti]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UceniciPredmeti](
	[UcPredID] [int] IDENTITY(1,1) NOT NULL,
	[MaticniBroj] [char](7) NOT NULL,
	[PredmetID] [int] NOT NULL,
 CONSTRAINT [PK_UcPred] PRIMARY KEY CLUSTERED 
(
	[MaticniBroj] ASC,
	[PredmetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OceneDnevnik] ADD  CONSTRAINT [DF_DatumOcene]  DEFAULT (getdate()) FOR [DatumOcene]
GO
ALTER TABLE [dbo].[Profesori] ADD  CONSTRAINT [DF__Profesori__ProfA__7E37BEF6]  DEFAULT ((0)) FOR [ProfAdmin]
GO
ALTER TABLE [dbo].[OceneDnevnik]  WITH CHECK ADD  CONSTRAINT [FK_OD_OTipovi] FOREIGN KEY([TipOcene])
REFERENCES [dbo].[OceneTipovi] ([TipOcene])
GO
ALTER TABLE [dbo].[OceneDnevnik] CHECK CONSTRAINT [FK_OD_OTipovi]
GO
ALTER TABLE [dbo].[OceneDnevnik]  WITH CHECK ADD  CONSTRAINT [FK_OD_Predmeti] FOREIGN KEY([PredmetID])
REFERENCES [dbo].[Predmeti] ([PredmetID])
GO
ALTER TABLE [dbo].[OceneDnevnik] CHECK CONSTRAINT [FK_OD_Predmeti]
GO
ALTER TABLE [dbo].[OceneDnevnik]  WITH CHECK ADD  CONSTRAINT [FK_OD_Profesori] FOREIGN KEY([ProfesorID])
REFERENCES [dbo].[Profesori] ([ProfesorID])
GO
ALTER TABLE [dbo].[OceneDnevnik] CHECK CONSTRAINT [FK_OD_Profesori]
GO
ALTER TABLE [dbo].[OceneDnevnik]  WITH CHECK ADD  CONSTRAINT [FK_OD_Ucenici] FOREIGN KEY([MaticniBroj])
REFERENCES [dbo].[Ucenici] ([MaticniBroj])
GO
ALTER TABLE [dbo].[OceneDnevnik] CHECK CONSTRAINT [FK_OD_Ucenici]
GO
ALTER TABLE [dbo].[OcenePromene]  WITH CHECK ADD  CONSTRAINT [FK_OcenePromene_OceneDnevnik] FOREIGN KEY([OcenaID])
REFERENCES [dbo].[OceneDnevnik] ([OcenaID])
GO
ALTER TABLE [dbo].[OcenePromene] CHECK CONSTRAINT [FK_OcenePromene_OceneDnevnik]
GO
ALTER TABLE [dbo].[Odeljenja]  WITH CHECK ADD  CONSTRAINT [FK_Odeljenja_Godine] FOREIGN KEY([GodinaID])
REFERENCES [dbo].[Godine] ([GodinaID])
GO
ALTER TABLE [dbo].[Odeljenja] CHECK CONSTRAINT [FK_Odeljenja_Godine]
GO
ALTER TABLE [dbo].[Odeljenja]  WITH CHECK ADD  CONSTRAINT [FK_Odeljenja_Razredni] FOREIGN KEY([Razredni])
REFERENCES [dbo].[Profesori] ([ProfesorID])
GO
ALTER TABLE [dbo].[Odeljenja] CHECK CONSTRAINT [FK_Odeljenja_Razredni]
GO
ALTER TABLE [dbo].[ProfesoriPredmetiOdeljenja]  WITH CHECK ADD  CONSTRAINT [FK_PPO_Odeljenja] FOREIGN KEY([OdeljenjeID])
REFERENCES [dbo].[Odeljenja] ([OdeljenjeID])
GO
ALTER TABLE [dbo].[ProfesoriPredmetiOdeljenja] CHECK CONSTRAINT [FK_PPO_Odeljenja]
GO
ALTER TABLE [dbo].[ProfesoriPredmetiOdeljenja]  WITH CHECK ADD  CONSTRAINT [FK_PPO_Predmeti] FOREIGN KEY([PredmetID])
REFERENCES [dbo].[Predmeti] ([PredmetID])
GO
ALTER TABLE [dbo].[ProfesoriPredmetiOdeljenja] CHECK CONSTRAINT [FK_PPO_Predmeti]
GO
ALTER TABLE [dbo].[ProfesoriPredmetiOdeljenja]  WITH CHECK ADD  CONSTRAINT [FK_PPO_Profesori] FOREIGN KEY([ProfesorID])
REFERENCES [dbo].[Profesori] ([ProfesorID])
GO
ALTER TABLE [dbo].[ProfesoriPredmetiOdeljenja] CHECK CONSTRAINT [FK_PPO_Profesori]
GO
ALTER TABLE [dbo].[SesijeKorisnika]  WITH CHECK ADD  CONSTRAINT [FK_Sesije_Profesori] FOREIGN KEY([Korisnik])
REFERENCES [dbo].[Profesori] ([ProfesorID])
GO
ALTER TABLE [dbo].[SesijeKorisnika] CHECK CONSTRAINT [FK_Sesije_Profesori]
GO
ALTER TABLE [dbo].[Ucenici]  WITH CHECK ADD  CONSTRAINT [FK_Ucenici_Odeljenja] FOREIGN KEY([OdeljenjeID])
REFERENCES [dbo].[Odeljenja] ([OdeljenjeID])
GO
ALTER TABLE [dbo].[Ucenici] CHECK CONSTRAINT [FK_Ucenici_Odeljenja]
GO
ALTER TABLE [dbo].[UceniciPredmeti]  WITH CHECK ADD  CONSTRAINT [FK_UP_Predmeti] FOREIGN KEY([PredmetID])
REFERENCES [dbo].[Predmeti] ([PredmetID])
GO
ALTER TABLE [dbo].[UceniciPredmeti] CHECK CONSTRAINT [FK_UP_Predmeti]
GO
ALTER TABLE [dbo].[UceniciPredmeti]  WITH CHECK ADD  CONSTRAINT [FK_UP_Ucenici] FOREIGN KEY([MaticniBroj])
REFERENCES [dbo].[Ucenici] ([MaticniBroj])
GO
ALTER TABLE [dbo].[UceniciPredmeti] CHECK CONSTRAINT [FK_UP_Ucenici]
GO
ALTER TABLE [dbo].[Godine]  WITH CHECK ADD  CONSTRAINT [CHK_GodinaSkolovanja] CHECK  (([GodinaSkolovanja]>=(1) AND [GodinaSkolovanja]<=(4)))
GO
ALTER TABLE [dbo].[Godine] CHECK CONSTRAINT [CHK_GodinaSkolovanja]
GO
ALTER TABLE [dbo].[OceneDnevnik]  WITH CHECK ADD  CONSTRAINT [CHK_DatumOcene] CHECK  (([DatumOcene]<=getdate()))
GO
ALTER TABLE [dbo].[OceneDnevnik] CHECK CONSTRAINT [CHK_DatumOcene]
GO
ALTER TABLE [dbo].[Profesori]  WITH CHECK ADD  CONSTRAINT [CHK_Sifra_Prof] CHECK  ((len([Sifra])>(7)))
GO
ALTER TABLE [dbo].[Profesori] CHECK CONSTRAINT [CHK_Sifra_Prof]
GO
ALTER TABLE [dbo].[Ucenici]  WITH CHECK ADD  CONSTRAINT [CHK_Sifra_Uc] CHECK  ((len([Sifra])>(7)))
GO
ALTER TABLE [dbo].[Ucenici] CHECK CONSTRAINT [CHK_Sifra_Uc]
GO
/****** Object:  StoredProcedure [dbo].[LoginKorisnika]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[LoginKorisnika]
@Username nvarchar(50), @Sifra nvarchar(50)
AS

BEGIN TRY

	IF EXISTS (SELECT ProfesorID, Sifra FROM Profesori
				WHERE CAST(ProfesorID AS nvarchar) = @username
				AND Sifra = @sifra 
				AND ProfAdmin = 1)
		BEGIN
			RETURN 1 -- admin
		END
	ELSE IF EXISTS (SELECT 1 FROM Profesori
				WHERE CAST(ProfesorID AS nvarchar) = @username
				AND Sifra=@sifra
				AND ProfAdmin = 0)
		BEGIN
			RETURN 2 -- profesor
		END
	ELSE IF EXISTS (SELECT 1 FROM Ucenici
				WHERE MaticniBroj = @Username
				AND Sifra = @Sifra)
		BEGIN
			RETURN 3 -- ucenik
		END

	ELSE
		BEGIN
			RETURN 0 -- ostalo
		END

END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[LoginProf]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoginProf]
@username nvarchar(50), @sifra nvarchar(50)
AS

BEGIN TRY

	IF EXISTS (SELECT ProfesorID, Sifra FROM Profesori
				WHERE ProfesorID = CAST(@username AS INT)
				AND Sifra = @sifra 
				AND ProfAdmin = 1)
		BEGIN
			RETURN 1
		END
	IF EXISTS (SELECT 1 FROM Profesori WHERE ProfesorID = CAST(@username AS INT) AND Sifra=@sifra AND ProfAdmin = 0)
		BEGIN
			RETURN 2
		END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[LoginUc]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LoginUc]
@username nvarchar(50), @sifra nvarchar(50)
AS
BEGIN TRY
	IF EXISTS (SELECT MaticniBroj, Sifra FROM Ucenici 
				WHERE (MaticniBroj = @username
				AND Sifra = @sifra))
		BEGIN
			RETURN 0
		END
	ELSE 
		BEGIN
			RETURN 1
		END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[OceneDnevnikINSERT]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[OceneDnevnikINSERT]
@TipOcene nvarchar(50), @Ocena int, @DatumOcene date, @MaticniBroj char(7), @ProfesorID int, @PredmetID int
AS

BEGIN TRY

	-- da li je razredni
	IF NOT EXISTS 
		(SELECT * FROM Ucenici
		JOIN Odeljenja ON Ucenici.OdeljenjeID = Odeljenja.OdeljenjeID
		JOIN Profesori ON Odeljenja.Razredni = Profesori.ProfesorID
		WHERE Ucenici.MaticniBroj = @MaticniBroj AND Profesori.ProfesorID = @ProfesorID)

		BEGIN
			PRINT N'Taj profesor nije razredni tom uceniku, unos ocene nije dozvoljen'
			RETURN 1
		END
		
	-- da li taj profesor predaje taj predmet tom uceniku 
	ELSE IF NOT EXISTS
		(SELECT * FROM Ucenici JOIN ProfesoriPredmetiOdeljenja AS PPO ON Ucenici.OdeljenjeID = PPO.OdeljenjeID
		JOIN UceniciPredmeti AS UP ON PPO.PredmetID = UP.PredmetID
		JOIN Predmeti ON UP.PredmetID = Predmeti.PredmetID
		JOIN Profesori ON PPO.ProfesorID = Profesori.ProfesorID
		WHERE Ucenici.MaticniBroj = @MaticniBroj AND PPO.ProfesorID = @ProfesorID)
		
		BEGIN
			PRINT N'Taj profesor ne predaje taj predmet tom uceniku, unos ocene nije dozvoljen'
			RETURN 2
		END

	ELSE
		BEGIN
			PRINT N'Taj profesor predaje taj predmet, ili je razredni tom uceniku, unos ocene dozvoljen'
			INSERT INTO OceneDnevnik
			(TipOcene, Ocena, DatumOcene, MaticniBroj, ProfesorID, PredmetID)
			VALUES
			(@TipOcene, @Ocena, @DatumOcene, @MaticniBroj, @ProfesorID, @PredmetID)
		END

END TRY
BEGIN CATCH
		PRINT @@ERROR
		PRINT N'Unos ocene nije uspeo'
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[OceneDnevnikINSERT2]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[OceneDnevnikINSERT2]
@TipOcene nvarchar(50), @Ocena int, @DatumOcene date, @MaticniBroj char(7), @ProfesorID int, @PredmetID int
AS
BEGIN TRY
	INSERT INTO OceneDnevnik
			(TipOcene, Ocena, DatumOcene, MaticniBroj, ProfesorID, PredmetID)
			VALUES
			(@TipOcene, @Ocena, @DatumOcene, @MaticniBroj, @ProfesorID, @PredmetID)
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PrikazOcena]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazOcena]
@MaticniBroj char(7)
AS

SELECT * FROM dbo.SveOcene2
WHERE [Матични број ученика] = @MaticniBroj
ORDER BY [Предмет]
GO
/****** Object:  StoredProcedure [dbo].[PrikazOcena2]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazOcena2]
@MaticniBroj char(7), @PredmetID int
AS

SELECT * FROM dbo.SveOcene2
WHERE [Матични број ученика] = @MaticniBroj AND [Предмет] = @PredmetID

GO
/****** Object:  StoredProcedure [dbo].[PrikazOcenaPoPredmetu]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazOcenaPoPredmetu]
@MaticniBroj char(7), @PredmetID int
AS

SELECT * FROM dbo.SveOcene2
WHERE [Матични број ученика] = @MaticniBroj AND PredmetID = @PredmetID

GO
/****** Object:  StoredProcedure [dbo].[PrikazOdeljenja]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazOdeljenja]
@ProfesorID int
AS
SELECT IsO.GodinaSkolovanja AS Razred, Iso.OdeljenjeBr AS RedniBrOd
FROM ProfesoriPredmetiOdeljenja AS PPO
JOIN IspisOdeljenja AS IsO
ON PPO.OdeljenjeID = IsO.OdeljenjeID
WHERE ProfesorID = @ProfesorID

GO
/****** Object:  StoredProcedure [dbo].[PrikazPredmetaZaProfesora]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazPredmetaZaProfesora]
@ProfesorID int
AS
SELECT DISTINCT Naziv
FROM ProfesoriPredmetiOdeljenja AS PPO
JOIN Predmeti AS P
ON PPO.PredmetID = P.PredmetID
WHERE PPO.ProfesorID = @ProfesorID
GO
/****** Object:  StoredProcedure [dbo].[PrikazPredmetaZaProfesora2]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazPredmetaZaProfesora2]
@ProfesorID nvarchar(50)
AS
SELECT DISTINCT Naziv
FROM ProfesoriPredmetiOdeljenja AS PPO
JOIN Predmeti AS P
ON PPO.PredmetID = P.PredmetID
WHERE CAST (PPO.ProfesorID AS nvarchar(50)) = @ProfesorID
GO
/****** Object:  StoredProcedure [dbo].[PrikazUcenikaZaProfesora]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazUcenikaZaProfesora]
@OdeljenjeID int
AS

SELECT MaticniBroj, Ime, Prezime, Ucenici.OdeljenjeID
FROM Ucenici
JOIN Odeljenja
ON Ucenici.OdeljenjeID = Odeljenja.OdeljenjeID
WHERE Ucenici.OdeljenjeID = @OdeljenjeID
GO
/****** Object:  StoredProcedure [dbo].[PrikazUcenikaZaProfesora2]    Script Date: 9/20/2018 2:58:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PrikazUcenikaZaProfesora2]
@ProfesorID int, @PredmetID int, @OdeljenjeID int
AS

SELECT MaticniBroj, Ime, Prezime, Ucenici.OdeljenjeID
FROM ProfesoriPredmetiOdeljenja AS PPO
JOIN Ucenici
ON Ucenici.OdeljenjeID = PPO.OdeljenjeID
WHERE ProfesorID = @ProfesorID AND PredmetID = @PredmetID AND PPO.OdeljenjeID = @OdeljenjeID
GO
