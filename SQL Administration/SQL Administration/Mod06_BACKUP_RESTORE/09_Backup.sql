
/*
Backup Methoden


Vollständige

Differentielle Sicherung 
Transaktionsprotokollsicherung

! V 6:00
x	T
!	T
x	T
	
!	T
!	T
!	T
!		D
!	T
!	T
!	T 18:00


V: Checkpoint (wegschrieben der im RA veränderten Seiten auf HDD)
	Alle Dateien werden gesichert (Daten und Logfile) 
	Allerdings werden leere Seiten nicht gesichert
	Merkt sich Dateiname und Pfade

D:  Checkpoint
	sichert Seiten , die seit V geändert wurden


T: sichert Transaktionen (I U D). Es wird sich der Weg gemerkt


Was ist der schnellste Restore? 
wenn man nur das V bräuchte: je häufiger , desto schneller der Restore

Wie lange dauert der Restore einer T Sicherung?
Das T dauert beim Restore so lange wie Transaktionen selbst dauerten

--TIPP: ADR seit SQL 2019

Ist eine T sSicherung defekt, dann sind alle nachfolgenden sinnlos,
ausser man hat noch weitere D



Fälle:

1) HDD Crash für Log oder Daten  / Server hinüber..wir haben nur backup
	Server weg, aber HDD vorhanden
2) DB defekt --wir haben nur Backup
3) DB ok, aber Daten versemmelt
4) DB auf anderen Server übertragen (BackupRestore, Dateitransfer)
5) Wenn ich weiss, dass gleich was passieren kann..
6) Wenn BackupRestore zeitl nicht mehr aussreicht


Firmenregel:

Wie hoch darf der Datenverlust sein max in Zeit
Wie lange darf die DB ausfallen  in Zeit




Wiederhserstellungmodel:
USE [master]
GO
ALTER DATABASE [Northwind] SET RECOVERY SIMPLE WITH NO_WAIT
GO


Einfach
I U D werden aufgezeichnet. 
Bulk Befehle werden rudimentär aufgezeichnet
Wenn Tx commited wurden, dann verschwinden
die Tx aus dem Logfile
--> kein T Backup, rel schnell


Massenprotkolliert
I U D und Bulk rudimentär 
TX werden nicht gelöscht
--> Logfile wächst
---->Erst die Sicherung des T , werden commited TX aus dem Log entfernt, 
---->die in das Backup kommen
---> sicherer weil wir mit STOP AT arbeiten 
----> aber das geht nur wenn kein Bulk stattfand

Vollständig
I U D bulk umfangreich
auch IX ...
--> sicherer , weil genauer
--> man kann auf die Sekunden restore
--> wächst schneller, daher auch hier regelm Logfile Sicherung


? Wann ist DB : 
	Modell einfach: kaum oder keine Änderungen, TestDb
	Modell vollst : ProduktivDB

 Woher kommt es, dass alle DBs per default vollständig?
 Setting der model


 im Laufenden Betrieb läßt sich das Model ändern:
 Vollst--> einfach   --> verwirft viele tx (committed).
 ---Logfile wird geleert

 
Massenprotokolliert

Vollständig



V TTT D TTT D TTT

*/
--Voll
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak'
WITH NOFORMAT, NOINIT,  NAME = N'Voll',
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


--Diff
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  
NAME = N'Diff', SKIP, NOREWIND, 
NOUNLOAD,  STATS = 10
GO

--T
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'Tlog',
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Restore


--Fall 3: Daten wurden manipuliert , aber DB ist ok
--Idee: DB unter anderen Name restoren

USE [master]
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 1,  MOVE N'Northwind' TO N'D:\_SQLDB\MSSQL15.MSSQLSERVER\MSSQL\DATA\nxxvhwnd.mdf',  MOVE N'Northwind_log' TO N'D:\_SQLDB\MSSQL15.MSSQLSERVER\MSSQL\DATA\nxxvhwnd.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 12,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 13,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 14,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 15,  NOUNLOAD,  STATS = 5
GO

--Sonderfall

/*
V

D

T
T
T 11:25

11:45
11:51 jetzt Sicherung manuell

nächste Sicherung 12:00

IDEE mit geringstmöglichen Datenverlust.. am besten gar keinen

manuell Backup Log 11:51 (dauert 5 min)
Restore bis 11:45

Tx zw 11:45 und 11:51 sind nicht verloren
Ist ein Backup Online oder Offline?
Online
Verlust würde 5 min sein

User von DB runterwerfen
manuell Backup Log 11:51 (dauert 5 min)
Restore bis 11:45

*/
USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-06-15_12-05-41.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2021-06-15_12-05-41', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 12,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 13,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 14,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 15,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-06-15_12-00-15.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5,  STOPAT = N'2021-06-15T12:03:48'
ALTER DATABASE [Northwind] SET MULTI_USER







D:\_SQLDB\MSSQL15.MSSQLSERVER\MSSQL\DATA


GO

--Fall Server weg HDD da


*/
use [Northwind];
GO
use [master];
GO
USE [master]
GO
ALTER DATABASE [Northwind] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
EXEC master.dbo.sp_detach_db @dbname = N'Northwind'
GO

USE [master]
GO
CREATE DATABASE [Northwind] ON 
( FILENAME = N'D:\_HRDB\nortvvhwnd.mdf' ),
( FILENAME = N'D:\_HRDB\Northwind_log.ldf' ),
( FILENAME = N'D:\_HRDB\NwindHotData.ndf' )
 FOR ATTACH
GO


--Wenn wir wissen würden, dass etwasa passiert?!
--SP.. vorher Sicherung



--DB 100 GB Größe
--> Backup DB --> erscheint als weitere DB2.. Ist lesbar, aber nicht beschreibbar

--> Backup dauert nur sehr kurze Zeit

--> DB2 braucht wohl 100GB ..aber auf HDD nur 10GB frei... klappt!
--> DB2 braucht wohl 100GB ..aber auf HDD nur 1GB frei... klappt!
--> DB2 braucht wohl 100GB ..aber auf HDD nur 1MB frei... klappt! 128kb--Idee Referenz



--SNAPSHOT




--Was wenn die Zeit zum Restore nicht ausreicht (siehe max Ausfallzeit)
--HADR Hochverfügbarkeit
	--LogShipping
	--Spiegeln
	--Cluster
	--AlwysOnAVG
	--Replikation (bidirektional syncen)



--Plan für Sicherung

--Größe der DB: 200GB
--Arbeitszeiten: Mo bis Fr  7 -20 Uhr

--max Datenverlust in Zeit: 5min
--max Ausfallzeit in Zeit:  15min

--geringtmöglicher Datenverlust: vollständiges Wiederherstellungsmodel


--V: 1x pro Tag (mo bis Fr)... Uhrzeit: 23 Uhr
--T: alle 5min T (Mo bis Fr)   Uhrzeit:7:05 bis 20:05
--D: alle 15min

--best way.. Wartungsplan













