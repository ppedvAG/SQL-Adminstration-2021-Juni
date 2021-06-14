create database kursDB

/*
Grundeinstellungen der DB

Initialgrößen:
SQL 2012: 3MB Daten und 2 MB Log
SQL 2014: 5MB           2MB
SQL 2016: 8MB		    8MB

Wachstumsraten:
bis SQL 2014: Daten    1MB   Log 10%
ab  SQL 2016: Daten    64MB  Log 64MB

evtl Anfangsgrößen ändern-->Wie lange exisitiert der Server?
--Wachstumsraten anspassen auf ein moderates Niveau: 1 GB
--Vergrößerungen so selten wie möglich und so wenig aufwenig wie möglich

USE [master]
GO
ALTER DATABASE [KursDb2] MODIFY FILE ( NAME = N'KursDb2', SIZE = 153600KB , FILEGROWTH = 1126400KB )
GO
ALTER DATABASE [KursDb2] MODIFY FILE ( NAME = N'KursDb2_log', SIZE = 40960KB )
GO


--Ziel: IO vermeiden! IO reduzieren!


DBDesign:

ref Integrität
PK-FK
Normalisierung 1. 2. 3. BC 4. 5.

1NF in jeder Zelle nur ein Wert
2NF PK in Tabellen
3NF

PK: Aufgabe  ref Integrität  Bedingungen: eindeutige Werte
Datentypen

NF dienen dazu Redundanz zu vermeiden
Redundanz ist aber schnell

ref Integrität: PK-FK  1:N
verhindert dass PK Datensätze gelöscht werden, wenn noch in anderen Tabellen FK Werte vorhanden sind


SHOP

Kunde 1MIO
PK KdNr
Name
PLZ 
Ort 
Strasse
Land

Artikel
PK ArtNr
Bez
Preis

Bestellung 2MIO
PK BNr
BDatum
Lieferkosten
KdNr
RSumme


Bestellposition 4MIO
PK BPNr
Bnr
ArtNr
Anzahl
Preis

Datentypen

'otto'

Char(50)...    'otto                       ' 50
varchar(50)... 'otto'   4
nchar(50)...   'otto                       ' 50 Unicode *2 = 100
nvarchar(50).. 'otto'   4        * 2 ... 8
text() ..nicht mehr nehmen... ist seit SQL 2005 auf Abschussliste

fixe Längen char
varchar bei flexiblen Längen

Regel: alles, was in MB auf dem Datenträger liegt, kommt 1:1 in RAM!!!!!!!


DATUM

date   nur Datum
smalldatetime ..auf Sek 
datetime .. auf ms... Intervall von 2 bis 3 ms
datetime2... auf ns 
datetimeoffset ..mit Zeitzone auf ns


Ganze Zahlen
int +- 2,1 mrd
smallint +- 32000
tinyint +255
bigint +-

real, float, numeric, decimal, money (8 Nachkommastelle)
decimal(10,2) 10 stellen lang, davon 2 Nachkommastellen (18,0)


