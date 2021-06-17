--Backup

--Security:
Besitzverkettung

Jedes Objekt gehört zu einem Schema.. und Shcemas haben einen besitzer..

--Restore..

--wieso sehe ich keine Sicherungsdatei beim Restore?
--andere Endung ausser bak trn log etc
--man sieht immer nur die LW des SQL Servers mit dem man verbunden ist
--Rechte.. welche Rechte denn..bzw wer?
--es greift immer der Dienst zu.. per Zeitplan = Agent
--                               ohne Zeitplan = SQL Server


select 1600/65
select 550/65 ...8MB/sek

select 525/6   87MB/sek
select 1100/6   183MB/Sek

--wir wollen nicht viele Ts haben.. und schon gar nicht mit einem Zeitumfang

--Seit SQL 2019.. Tx Rollback und Restore (Tlog) deutlich schneller)
Alter Database Northwind set accelerated_Database_recovery=ON

--Meldung sp_conbfigure-- Eigenschaft des Server
EXEC sys.sp_configure N'max server memory (MB)', N'7500'
GO
RECONFIGURE WITH OVERRIDE
GO


--Contained DB
--auf Server;

RECONFIGURE WITH OVERRIDE

EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO


--Wieso ist eine Db nicht eigenständig?
--master Logins
--msdb Jobs
--tempd #tab

--die Eigenst kann pro DB entschieden werden

USE [master]
GO
ALTER DATABASE [restoremeDB] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO


--Teilweise:
--Login an der Db
--Jobs: nö
--temp Tabelle: immer noch in tempDb, aber mit Sprachsortierung der QuellDb
USE [ContDB]
GO
CREATE USER [Peter] WITH PASSWORD=N'ppedv2020!'
GO


--verwaiste User durch Backup restore auf 2ten Server

--Pragmatischer Ansatz
--JBond löschen--JBond neu anlegen und in die Rollen reintun

sp_help_revlogin


select * from sysusers
--pro Db

sp_change_users_login 'Report' --Liste der verwaisten User

--bei fehlenden Login
sp_change_users_login 'Auto_fix', 'JamesBond', NULL, 'ppedv2020!'


--bei bestehenden Login
sp_change_users_login 'Update_one', 'JamesBond', 'JamesBond'


USE [master]

GO

CREATE SERVER ROLE [FLSRolle] AUTHORIZATION [sa]

GO

ALTER SERVER ROLE [FLSRolle] ADD MEMBER [Max]

GO

use [master]

GO

GRANT CONTROL ON LOGIN::[JamesBond] TO [FLSRolle]


--Tag der Gehaltserhöhung
GO
USE [whoamiDB]
GO
CREATE APPLICATION ROLE [Gehaltsrolle] WITH PASSWORD = N'ppedv2020!'
GO


use master

use whoamiDB

sp_setapprole 'Gehaltsrolle', 'ppedv2020!'

use master










