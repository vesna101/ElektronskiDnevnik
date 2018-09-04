-- test baze
USE ElDnevnik2
GO
-- napuniti: tipove ocena, godine, profesore, odeljenja, predmete, ucenike, pa ocene

INSERT INTO OceneTipovi
(TipOcene)
VALUES
(N'усмени одговор'),
(N'контролна вежба'),
(N'писмени задатак'),
(N'активност на часу'),
(N'друго')
GO
INSERT INTO OceneTipovi
(TipOcene)
VALUES
(N'zakljucna')
GO
SELECT * FROM OceneTipovi

INSERT INTO Godine
(GodinaSkolovanja, SkolskaGodina)
VALUES
(1, 2018),
(2, 2018),
(3, 2018),
(4, 2018)
GO
INSERT INTO Godine
(GodinaSkolovanja, SkolskaGodina)
VALUES
(4, 2017) -- npr. oni koji su prosle godine bili 4. razred
GO

SELECT * FROM Godine

INSERT INTO Profesori
(Ime, Sifra)
VALUES
(N'Србиста', N'sifrasrbista'),
(N'Англиста', N'sifraanglista'),
(N'Психолог', N'sifrapsiholog'),
(N'Филозоф', N'sifrafilozof'),
(N'Историчар', N'sifraistoricar'),
(N'Физичар', N'sifrafizicar'),
(N'Географ', N'sifrageograf'),
(N'Хемичар', N'sifrahemicar'),
(N'Биолог', N'sifrabiolog'),
(N'Физички васпитач', N'sifrafizicko'),
(N'Уметник', N'sifraumetnik'),
(N'Математичар', N'siframatematicar')
GO

INSERT INTO Profesori
(Ime, Sifra, ProfAdmin)
VALUES
(N'Admin', N'sifraadmin', 1)
GO

SELECT * FROM Profesori
SELECT * FROM Godine

INSERT INTO Predmeti
(Redosled, Naziv, ProfesorID, GodinaID)
VALUES
(70, N'Географија', 7, 3),
(20, N'Енглески језик', 2, 3),
(120, N'Математика', 12, 1),
(30, N'Психологија', 3, 4),
(60, N'Физика', 6, 3),
(90, N'Биологија', 9, 3),
(50, N'Историја', 5, 3),
(10, N'Српски језик и књижевност', 1, 3),
(80, N'Хемија', 8, 3),
(100, N'Физичко васпитање', 10, 3),
(110, N'Уметност', 11, 3),
(40, N'Филозофија', 4, 6)
GO

INSERT INTO Odeljenja
(OdeljenjeBr, GodinaID, Razredni)
VALUES
(1, 3, 1), -- prvom jedan razredni je srbista
(2, 3, 6), -- prvom dva razredni je fizicar
(1, 4, 12), -- drugom jedan razredni je matematicar
(2, 4, 9) -- drugom dva razredni je biolog
GO
SELECT * FROM Odeljenja

-- koji nastavnik je kom odeljenju razredni: - sacuvati kao view
SELECT G.GodinaSkolovanja AS Razred, O.OdeljenjeBr AS Odeljenje, P.Ime AS Razredni
FROM Godine AS G JOIN Odeljenja AS O ON G.GodinaID = O.GodinaID
JOIN Profesori AS P ON O.Razredni = P.ProfesorID

/*
odeljenjaID: 1 - prvo jedan, 2 - prvo dva, 3 - drugo jedan, 4 - drugo dva
*/

INSERT INTO Ucenici
(MaticniBroj, Ime, Prezime, OdeljenjeID, Sifra)
VALUES
(N'1111111', N'Миле', N'Милић', 1, N'milesifra'),
(N'1111112', N'Дана', N'Данић', 1, N'danasifra'),
(N'1111113', N'Зора', N'Зорић', 1, N'zorasifra'),
(N'1111114', N'Мики', N'Микић', 1, N'mikisifra'),
(N'1111115', N'Бока', N'Бокић', 1, N'bokasifra'),
(N'1111116', N'Вера', N'Верић', 2, N'verasifra'),
(N'1111117', N'Мица', N'Мицковић', 2, N'micasifra'),
(N'1111118', N'Џон', N'Смит', 2, N'dzonsifra'),
(N'1111119', N'Џејн', N'Остин', 2, N'dzejnsifra'),
(N'1111110', N'Пера', N'Перић', 2, N'perasifra')
GO
SELECT * FROM Ucenici
SELECT * FROM Predmeti
GO

-- koji ucenik ima koje predmete:


-- neka svi ucenici prvog jedan imaju srpski, matematiku, engleski i fizicko, razredni srbista
INSERT INTO UceniciPredmeti -- zasto ne vidi ovu tabelu?
(MaticniBroj, PredmetID)
SELECT MaticniBroj, PredmetID FROM Ucenici, Predmeti WHERE OdeljenjeID = 1 AND PredmetID IN (8, 3, 2, 10)
GO
-- neka svi ucenici prvog dva imaju srpski, matematiku, fiziku i umetnost, razredni fizicar
INSERT INTO UceniciPredmeti 
(MaticniBroj, PredmetID)
SELECT MaticniBroj, PredmetID FROM Ucenici, Predmeti WHERE OdeljenjeID = 2 AND PredmetID IN (8, 3, 5, 11)
GO
-- VAZNO: izmeniti poneki red tako da nemaju svi ucenici u odeljenju iste predmete (npr. gradjansko/verska)
SELECT * FROM UceniciPredmeti


-- Koji profesor koji predmet predaje kom odeljenju:
-- Matematicar predaje matematiku prvom jedan, a Matematicar2 predaje matematiku prvom dva
-- Za ostale predmete imaju iste profesore


INSERT INTO Profesori
(Ime, Sifra)
VALUES
(N'Математичар2', N'siframata2')
GO

SELECT * FROM Profesori
SELECT * FROM Predmeti
SELECT * FROM Odeljenja

INSERT INTO ProfesoriPredmetiOdeljenja
(ProfesorID, PredmetID, OdeljenjeID)
VALUES
(12, 3, 1),
(1, 8, 1),
(2, 2, 1),
(10, 10, 1),
(14, 3, 2),
(1, 8, 2),
(6, 5, 2),
(11, 11, 2)
GO

-- Koji profesor koji predmet predaje kom odeljenju: - sacuvati kao view

SELECT G.GodinaSkolovanja AS Razred, O.OdeljenjeBr AS Odeljenje, Predmeti.Naziv, Profesori.Ime
FROM Godine AS G
JOIN Odeljenja AS O ON G.GodinaID = O.GodinaID
JOIN ProfesoriPredmetiOdeljenja AS PPO ON O.OdeljenjeID = PPO.OdeljenjeID
JOIN Predmeti ON PPO.PredmetID = Predmeti.PredmetID
JOIN Profesori ON PPO.ProfesorID = Profesori.ProfesorID

SELECT * FROM Ucenici
SELECT * FROM Profesori


-- INSERT OCENA:
-- primeri:
-- Srbista moze Dani da daje sve ocene, a Veri samo iz srpskog
-- Matematicar moze Dani da daje ocene iz matematike, a Matematicar2 ne moze
-- Psiholog ne moze Dani da daje ocene


-- da li taj profesor predaje taj predmet tom uceniku


-- da li Miletu prvo jedan predaje Matematicar - da, ali izbacuje isti slog 10 puta
SELECT *
FROM Ucenici JOIN ProfesoriPredmetiOdeljenja AS PPO ON Ucenici.OdeljenjeID = PPO.OdeljenjeID
JOIN UceniciPredmeti AS UP ON PPO.PredmetID = UP.PredmetID
JOIN Predmeti ON UP.PredmetID = Predmeti.PredmetID
JOIN Profesori ON PPO.ProfesorID = Profesori.ProfesorID
WHERE Ucenici.MaticniBroj = N'1111111' AND PPO.ProfesorID = 12
GO

-- da li Miletu prvo jedan predaje Matematicar2 - ne, ok
SELECT *
FROM Ucenici JOIN ProfesoriPredmetiOdeljenja AS PPO ON Ucenici.OdeljenjeID = PPO.OdeljenjeID
JOIN UceniciPredmeti AS UP ON PPO.PredmetID = UP.PredmetID
JOIN Predmeti ON UP.PredmetID = Predmeti.PredmetID
JOIN Profesori ON PPO.ProfesorID = Profesori.ProfesorID
WHERE Ucenici.MaticniBroj = N'1111111' AND PPO.ProfesorID = 14
GO

-- da li Miletu predaje Srbista - da, izbacuje 2 ista sloga
SELECT Ucenici.MaticniBroj, Ucenici.Ime, Predmeti.PredmetID, Predmeti.Naziv, Profesori.ProfesorID, Profesori.Ime
FROM Ucenici
JOIN UceniciPredmeti AS UP ON Ucenici.MaticniBroj = UP.MaticniBroj
JOIN Predmeti ON UP.PredmetID = Predmeti.PredmetID
JOIN Profesori ON Profesori.ProfesorID = Predmeti.ProfesorID 
JOIN ProfesoriPredmetiOdeljenja AS PPO ON PPO.ProfesorID = Profesori.ProfesorID
WHERE Ucenici.MaticniBroj = N'1111111' AND Profesori.ProfesorID = 1 -- zasto se javlja 2 ista sloga?




-- da li je taj profesor tom uceniku razredni / Miletu Srbista / da
SELECT Ucenici.MaticniBroj, Ucenici.Ime, Ucenici.Prezime, Ucenici.OdeljenjeID, Profesori.Ime
FROM Ucenici
JOIN Odeljenja ON Ucenici.OdeljenjeID = Odeljenja.OdeljenjeID
JOIN Profesori ON Odeljenja.Razredni = Profesori.ProfesorID
WHERE Ucenici.MaticniBroj = N'1111111' AND Profesori.ProfesorID = 1


GO

-- ISTRAZITI jednostavnije nacine preko subqueries





INSERT INTO OceneDnevnik
(TipOcene, Ocena, DatumOcene, MaticniBroj, ProfesorID, PredmetID)
VALUES
(N'друго', 5, GETDATE(), N'1111111', 1, 1) -- Miletu je Srbista dao ocenu iz geografije
GO -- 

INSERT INTO OceneDnevnik
(TipOcene, Ocena, DatumOcene, MaticniBroj, ProfesorID, PredmetID)
VALUES
(N'друго', 5, GETDATE(), N'1111111', 5, 11)
GO -- Miletu je Istoricar dao ocenu iz umetnosti

DELETE FROM OceneDnevnik WHERE ProfesorID = 1


-- popis svih ocena: - snimiti kao view
SELECT Ucenici.Ime AS ImeUcenika, Ucenici.Prezime AS PrezimeUcenika, Ocena, TipOcene, Naziv, Profesori.Ime AS ImeProfesora, DatumOcene  FROM OceneDnevnik
JOIN Ucenici ON Ucenici.MaticniBroj = OceneDnevnik.MaticniBroj
JOIN Predmeti ON Predmeti.PredmetID = OceneDnevnik.PredmetID
JOIN Profesori ON Profesori.ProfesorID = OceneDnevnik.ProfesorID
-- WHERE Ucenici.MaticniBroj = ... - za prikaz svih ocena jednog ucenika (za roditelje)
-- WHERE PredmetID = ... - za prikaz svih ocena na predmetu (za profesore)
-- ORDER BY ...





-- Stored procedura za unos ocene
-- parametri: tip ocene, ocena, datum, maticnibroj, profesorID, predmetID
GO

ALTER PROC OceneDnevnikINSERT
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
			--RETURN 1
		END
		
	-- da li taj profesor predaje taj predmet tom uceniku - ovaj deo NIJE DOBAR!!!
	--ELSE--
	 IF NOT EXISTS
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


EXEC  OceneDnevnikINSERT N'друго', 4, N'20180901', N'1111112', 1, 1
-- NE VALJA! Dozvoljava Srbisti da unese ocenu iz geografije - ZATO STO JE RAZREDNI!?

/*
Da li provere 
	1. da li taj profesor predaje taj predmet tom uceniku
	2. da li je taj profesor razredni tom uceniku
vrsiti u zasebnim SP pa povezati sa SP za unos u okviru TRAN? 

-- SP1 provera razrednog
-- SP2 provera veze ucenik/predmet/profesor
-- SP3 upis ocena
BEGIN TRAN if SP1 ok ili SP2 ok, onda radi SP3 END TRAN

*/

-- kreirati view-ove
GO

CREATE VIEW SveOcene
AS
SELECT Ucenici.Ime AS ImeUcenika, Ucenici.Prezime AS PrezimeUcenika, Ocena, TipOcene, Naziv, Profesori.Ime AS ImeProfesora, DatumOcene  FROM OceneDnevnik
JOIN Ucenici ON Ucenici.MaticniBroj = OceneDnevnik.MaticniBroj
JOIN Predmeti ON Predmeti.PredmetID = OceneDnevnik.PredmetID
JOIN Profesori ON Profesori.ProfesorID = OceneDnevnik.ProfesorID
GO

SELECT * FROM SveOcene WHERE ImeUcenika = N'Миле'
GO

SELECT * FROM OceneDnevnik
GO


EXEC  OceneDnevnikINSERT N'друго', 4, N'20180901', N'1111112', 12, 3
GO

EXEC  OceneDnevnikINSERT N'друго', 4, N'20180901', N'1111112', 14, 3
GO