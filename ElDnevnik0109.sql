-- 1. 9. 2018.
-- baza ElDnevnik2 (1. 9. 2018) - kompletan script

USE master
GO

CREATE DATABASE [ElDnevnik2]

 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ElDnevnik2_data', FILENAME = N'D:\CET praksa\DataLog\ElDnevnik2_Data' , SIZE = 8192KB , MAXSIZE = 102400KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'ElDnevnik2_log', FILENAME = N'D:\CET praksa\DataLog\ElDnevnik2_Log' , SIZE = 8192KB , MAXSIZE = 102400KB , FILEGROWTH = 10%)
GO

USE ElDnevnik2
GO


CREATE TABLE Ucenici
(
MaticniBroj char(7) PRIMARY KEY,
Ime nvarchar(50) NOT NULL,
Prezime nvarchar(50) NOT NULL,
OdeljenjeID int NOT NULL,
JMBG nvarchar(50) NULL,
DatumRodjenja nvarchar(50) NULL,
MestoRodjenja nvarchar(50) NULL,
OpstinaRodjenja nvarchar(50) NULL,
Drzava nvarchar(50) NULL,
Telefon nvarchar(50) NULL,
Email nvarchar(50) NULL,
OtacIme nvarchar(50) NULL,
OtacPrezime nvarchar(50) NULL,
OtacTelefon nvarchar(50) NULL,
OtacEmail nvarchar(50) NULL,
MajkaIme nvarchar(50) NULL,
MajkaPrezime nvarchar(50) NULL,
MajkaTelefon nvarchar(50) NULL,
MajkaEmail nvarchar(50) NULL,
Sifra nvarchar(50) NOT NULL
)
GO

CREATE TABLE Profesori
(
ProfesorID int PRIMARY KEY IDENTITY,
Ime nvarchar(50) NOT NULL,
Email nvarchar(255) NULL,
Telefon nvarchar(50) NULL,
Sifra nvarchar(50) NOT NULL
)
GO

CREATE TABLE Predmeti
(
PredmetID int PRIMARY KEY IDENTITY,
Redosled int NOT NULL,
Naziv nvarchar(50) NOT NULL,
ProfesorID int NOT NULL,
GodinaID int NOT NULL
)
GO

CREATE TABLE Odeljenja
(
OdeljenjeID int IDENTITY PRIMARY KEY,
OdeljenjeBr int NOT NULL,
GodinaID int NOT NULL,
Razredni int NOT NULL
)
GO

CREATE TABLE Godine
(
GodinaID int PRIMARY KEY IDENTITY,
GodinaSkolovanja int NOT NULL, 
SkolskaGodina int NOT NULL
)
GO

-- ocene odvojiti na 2 tabele: OceneDnevnik i OceneTipovi

CREATE TABLE OceneDnevnik
(
OcenaID int PRIMARY KEY IDENTITY,
TipOcene nvarchar(50) NULL, -- dozvoljen null za versku, gradjansko i sl. - mada to moze da se svrsta u DRUGO
Ocena int NOT NULL, -- definisati opseg po predmetima i odgovarajuce opise
-- OcenaOpis nvarchar(50), - suvisno!
DatumOcene date NOT NULL,
MaticniBroj char(7) NOT NULL,
ProfesorID int NOT NULL,
PredmetID int NOT NULL
)
GO


CREATE TABLE OceneTipovi
(
TipOcene nvarchar(50) PRIMARY KEY
)

-- log / promene ocena / gde se cuvaju stare ocene nakon promene i brisanja:
-- ova tabela mora da ima dodatnu ID kolonu!
CREATE TABLE OcenePromene
(
PromenaID int PRIMARY KEY IDENTITY,
OcenaID int NOT NULL,
TipOcene nvarchar(50) NULL,
Ocena int NOT NULL,
DatumOcene date NOT NULL,
MaticniBroj char(7) NOT NULL,
ProfesorID int NOT NULL,
PredmetID int NOT NULL
)
GO


-- medjutabele:

-- profesori/predmeti/odeljenja
CREATE TABLE ProfesoriPredmetiOdeljenja
(
ProfPredOdID int IDENTITY NOT NULL,
ProfesorID int NOT NULL,
PredmetID int NOT NULL,
OdeljenjeID int NOT NULL
)
GO
ALTER TABLE ProfesoriPredmetiOdeljenja
ADD CONSTRAINT PK_PPO
PRIMARY KEY (ProfesorID, PredmetID, OdeljenjeID)
GO

-- ucenici/predmeti
CREATE TABLE UceniciPredmeti
(
UcPredID int IDENTITY NOT NULL,
MaticniBroj char(7) NOT NULL,
PredmetID int NOT NULL
)
GO
ALTER TABLE UceniciPredmeti
ADD CONSTRAINT PK_UcPred
PRIMARY KEY (MaticniBroj, PredmetID)
GO

--tabela za sesije korisnika:
CREATE TABLE SesijeKorisnika
(
SesijaID int PRIMARY KEY,
Korisnik int NOT NULL,
VremeLogIn datetime,
VremeLogOut datetime -- da li za vreme logout staviti not null?
)
GO

-- tabela za arhivu: podaci o ucenicima + zakljucene ocene po godinama i predmetima: 
CREATE TABLE Arhiva
(
MaticniBroj char(7) PRIMARY KEY,
Ime nvarchar(50) NOT NULL,
Prezime nvarchar(50) NOT NULL,
OdeljenjeID int NOT NULL,
JMBG nvarchar(50) NULL,
DatumRodjenja nvarchar(50) NULL,
MestoRodjenja nvarchar(50) NULL,
OpstinaRodjenja nvarchar(50) NULL,
Drzava nvarchar(50) NULL,
Telefon nvarchar(50) NULL,
Email nvarchar(50) NULL,
OtacIme nvarchar(50) NULL,
OtacPrezime nvarchar(50) NULL,
OtacTelefon nvarchar(50) NULL,
OtacEmail nvarchar(50) NULL,
MajkaIme nvarchar(50) NULL,
MajkaPrezime nvarchar(50) NULL,
MajkaTelefon nvarchar(50) NULL,
MajkaEmail nvarchar(50) NULL,
Sifra nvarchar(50) NOT NULL,

PredmetID int NOT NULL,
ZakljucnaOcena int NOT NULL,
GodinaID int NOT NULL

)
GO

-- RELACIJE: 

-- ucenici/odeljenja
ALTER TABLE Ucenici
ADD CONSTRAINT FK_Ucenici_Odeljenja
FOREIGN KEY (OdeljenjeID)
REFERENCES Odeljenja (OdeljenjeID)
GO

-- medjutabela profesori/predmeti/odeljenja
ALTER TABLE ProfesoriPredmetiOdeljenja
ADD CONSTRAINT FK_PPO_Profesori
FOREIGN KEY (ProfesorID)
REFERENCES Profesori (ProfesorID)
GO
ALTER TABLE ProfesoriPredmetiOdeljenja
ADD CONSTRAINT FK_PPO_Predmeti
FOREIGN KEY (PredmetID)
REFERENCES Predmeti (PredmetID)
GO
ALTER TABLE ProfesoriPredmetiOdeljenja
ADD CONSTRAINT FK_PPO_Odeljenja
FOREIGN KEY (OdeljenjeID)
REFERENCES Odeljenja (OdeljenjeID)
GO

-- medjutabela ucenici/predmeti
ALTER TABLE UceniciPredmeti
ADD CONSTRAINT FK_UP_Ucenici
FOREIGN KEY (MaticniBroj)
REFERENCES Ucenici (MaticniBroj)
GO
ALTER TABLE UceniciPredmeti
ADD CONSTRAINT FK_UP_Predmeti
FOREIGN KEY (PredmetID)
REFERENCES Predmeti (PredmetID)
GO

--veza ocena i: ucenika, predmeta, profesora, tipova ocena
ALTER TABLE OceneDnevnik
ADD CONSTRAINT FK_OD_Ucenici
FOREIGN KEY (MaticniBroj)
REFERENCES Ucenici (MaticniBroj)
GO
ALTER TABLE OceneDnevnik
ADD CONSTRAINT FK_OD_Predmeti
FOREIGN KEY (PredmetID)
REFERENCES Predmeti (PredmetID)
GO
ALTER TABLE OceneDnevnik
ADD CONSTRAINT FK_OD_Profesori
FOREIGN KEY (ProfesorID)
REFERENCES Profesori (ProfesorID)
GO

ALTER TABLE OceneDnevnik
ADD CONSTRAINT FK_OD_OTipovi
FOREIGN KEY (TipOcene)
REFERENCES OceneTipovi (TipOcene)
GO

-- sve isto za ocenePromene

/*
ALTER TABLE OcenePromene
ADD CONSTRAINT FK_OP_Ucenici
FOREIGN KEY (MaticniBroj)
REFERENCES Ucenici (MaticniBroj)
GO
ALTER TABLE OcenePromene
ADD CONSTRAINT FK_OP_Predmeti
FOREIGN KEY (PredmetID)
REFERENCES Predmeti (PredmetID)
GO
ALTER TABLE OcenePromene
ADD CONSTRAINT FK_OP_Profesori
FOREIGN KEY (ProfesorID)
REFERENCES Profesori (ProfesorID)
GO
*/

-- nema potrebe, dovoljno je povezati OcenePromene/OceneDnevnik

ALTER TABLE OcenePromene
ADD CONSTRAINT FK_OcenePromene_OceneDnevnik
FOREIGN KEY (OcenaID)
REFERENCES OceneDnevnik (OcenaID)
GO

-- odeljenja/profesori (za razredne)
ALTER TABLE Odeljenja
ADD CONSTRAINT FK_Odeljenja_Razredni
FOREIGN KEY (Razredni)
REFERENCES Profesori (ProfesorID)
GO

-- odeljenja/godine
ALTER TABLE Odeljenja
ADD CONSTRAINT FK_Odeljenja_Godine
FOREIGN KEY (GodinaID)
REFERENCES Godine (GodinaID)
GO

-- sesije korisnika / profesori
ALTER TABLE SesijeKorisnika
ADD CONSTRAINT FK_Sesije_Profesori
FOREIGN KEY (Korisnik)
REFERENCES Profesori (ProfesorID)
GO


-- VAZNO!
-- Dodavanja admin bit kolone tabeli profesori
ALTER TABLE Profesori
ADD ProfAdmin bit NOT NULL DEFAULT 0
GO



-- CONSTRAINTS:

ALTER TABLE Ucenici
ADD CONSTRAINT CHK_Sifra_Uc
CHECK (LEN(Sifra)>7)
GO

ALTER TABLE Profesori
ADD CONSTRAINT CHK_Sifra_Prof
CHECK (LEN(Sifra)>7)
GO

ALTER TABLE Godine
ADD CONSTRAINT CHK_GodinaSkolovanja
CHECK (GodinaSkolovanja BETWEEN 1 AND 4)
GO

ALTER TABLE OceneDnevnik
ADD CONSTRAINT CHK_DatumOcene
CHECK (DatumOcene <= GETDATE())
GO

ALTER TABLE OceneDnevnik
ADD CONSTRAINT DF_DatumOcene
DEFAULT (GETDATE()) FOR DatumOcene
GO

ALTER TABLE Godine
ADD CONSTRAINT U_Godine
UNIQUE (GodinaSkolovanja, SkolskaGodina)
GO

ALTER TABLE Odeljenja
ADD CONSTRAINT U_Odeljenja
UNIQUE (OdeljenjeBr, GodinaID)
GO



-- STORED PROCEDURE:

-- login prof/admin
CREATE PROCEDURE LoginProf
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
	ELSE IF EXISTS (SELECT 1 FROM Profesori
					WHERE ProfesorID = CAST(@username AS INT)
					AND ProfAdmin = 0)
		BEGIN
			RETURN 2
		END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH
GO

-- login ucenik (roditelj)
CREATE PROC LoginUc
@username nvarchar(50), @sifra nvarchar(50)
AS
BEGIN TRY
	IF EXISTS (SELECT 1 FROM Ucenici 
				WHERE MaticniBroj = @username
				AND Sifra = @sifra)
		BEGIN
			RETURN 0
		END
END TRY
BEGIN CATCH
	RETURN @@ERROR
END CATCH