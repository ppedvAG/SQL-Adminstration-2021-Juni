/*
master
Logins (Zutritt zum SQL Server)
Datenbanken
Konfiguration

muss man master sichern: auf jeden Fall



model
Vorlage für neue DBs
create database testdb.. Kopie der model
Änderungen an der model haben Auswirkung auf neue DBs

muss man die model DB sichern...bei Änderungen
Tipp: nö...  lieber Script erfassen..
USE [master]
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modeldev', SIZE = 10240KB )
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modellog', SIZE = 10240KB )
GO


msdb--zeitl größter Aufwand bei Verlust
DB für den AGENT
Jobs, Zeitpläne, Wartungspläne, SSIS Pakete, EMAIL
muss man die sichern: ja auf jeden Fall


tempdb
#tempTabellen ##tabelle temporäre Tabellen
Zeilenversionierung
Sortierarbeiten
Indizes
Auslagerungen


Wartungsplan!!!

muss man die tempdb sichern: nö geht gar nicht, will nur schnell sein.


*/