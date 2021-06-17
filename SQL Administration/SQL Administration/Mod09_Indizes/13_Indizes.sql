/*
gruppierter IX
= Tabelle in sortierter
gibts nur 1 mal
where gut bei = ID PK
		auch gut bei Bereichsabfragen >  < BETWEEN
--> Leute müssen sortiert Wohnen



nicht gr Index
= Kopien best Spaltenwerte in sortierter Form
ca 1000mal pro Tabelle
gut geeignet bei : rel wenigen Ergebniszeilen... ca. 1% 10% 20% 70%
where =  PK ID 

--> TELEFONBUCH

SCAN Suche von A bis Z
SEEK zielgerichtetes Suchen

*/
set statistics io, time on
select * from t1 where id = 10 
--56912 Seiten  CPU-Zeit = 421 ms, verstrichene Zeit = 69 ms.
--1:1 56912 Seiten in RAM
--mit Index , CPU-Zeit = 0 ms, verstrichene Zeit = 19 ms.   4 Seiten


begin tran
update t1 set city ='BGH' where id = 1
select * from t1 where id < 10
rollback

--andere Session:
select * from t1 where id = 20-- wartet

--Sperren werden besser..

--Wir lesen mehr Seiten als tabelle scheinbar hat
--Was wenn jemand Tabellen ändert: Spalten hinzufügen.

--wir müssen abundzu Tab in eine schöne physik. Form


dbcc showcontig('t1')



--Indizes können fragmentieren
1 2 3 4 5  126 127 6 7 8 369 9 10 
1             1           1    1
--IX müssen defragmentiert werden
--wir brauchen dir richtigen IX
--überflüssige IX finden


INDIZES müssen gewartet werden


über 30 % dann Rebuild --kompletter Baum wird verdichtet 
über 10 % dann wird Reorg -- nur der Teil mit den Sprungadressen wird verdichtet
unter 10% nichts tun 

--Tool für Wartung: Wartungsplan.. aber erst ab SQL 2016 brauchbar

----Unter SQL 2016: Tipp Ola Hallengren mal suchen
--- Maintenance Plan.. Script zur Wartung von DBs
---sehr einfach im Umgang



--Tools:
--Perfmon, Profiler, DTA


--Wartung der Indizes

--Fragmentierung
-- > 30% Rebuild
-- >5/10% Reorg
-- STAT aktuell..20%+500+Abfrage

--Statistiken werden bnötigt um den geeigneten IX zu finden
--wenige Ergebniszeilen--> N CL IX zb
--oder SCAN statt SEEK bzw SEEK statt SCAN



select * from ku where city = 'LONDON'
