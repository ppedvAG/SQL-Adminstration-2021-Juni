--SNAPSHOT

-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO


-- Create the database snapshot
CREATE DATABASE SN_NWIND_1400 ON --DBName des Snapshot
( NAME = Northwind, --logischer name der Datendatei
  FILENAME = 'D:\_SQLDB\SN_NWIND_1400.mdf' ) --DAtei des Snapshot
AS SNAPSHOT OF northwind; --DBName des Origignals
GO


--Kann man mehrere SNAPSHOTS haben?
--ja klar..

--Kann man einen Snapshot sichern?
--Nein

--kann man einen Snapshot restoren?
--Hast du lack gesoffen??

--Kann man die OrgDB noral backupen?
--Ja klar...

--Kann man die OrgDB aus backup restoren?
--Nö...SNAPSHOT passt hinten und vorne nict mehr
--geht aber, wenn man alle Snapshots löscht

--Keine Garantie wie lange der SNAPSHOT lebt!

--Man kann den Snapshot zum restoren verwenden?


--Bedingung: keiner darf auf SN DB oder OrgDB sein?
--Aktivitätsmonitor

select * from sysprocesses where dbid=db_id('northinwd')

select * from sysprocesses where dbid=db_id('SN_NWIND_1400')

kill 72

restore database northwind
from
database_snapshot = 'SN_NWIND_1400'

--Das kann ja viel sein..?










