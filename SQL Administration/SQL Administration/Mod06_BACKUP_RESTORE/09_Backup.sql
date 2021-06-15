
/*
Backup Methoden


Vollst�ndige

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


V: Checkpoint (wegschrieben der im RA ver�nderten Seiten auf HDD)
	Alle Dateien werden gesichert (Daten und Logfile) 
	Allerdings werden leere Seiten nicht gesichert
	Merkt sich Dateiname und Pfade

D:  Checkpoint
	sichert Seiten , die seit V ge�ndert wurden


T: sichert Transaktionen (I U D). Es wird sich der Weg gemerkt


Was ist der schnellste Restore? 
wenn man nur das V br�uchte: je h�ufiger , desto schneller der Restore

Wie lange dauert der Restore einer T Sicherung?
Das T dauert beim Restore so lange wie Transaktionen selbst dauerten

--TIPP: ADR seit SQL 2019

Ist eine T sSicherung defekt, dann sind alle nachfolgenden sinnlos,
ausser man hat noch weitere D



F�lle:

1) HDD Crash f�r Log oder Daten  / Server hin�ber
2) DB defekt
3) DB ok, aber Daten versemmelt
4) DB auf anderen Server �bertragen (BackupRestore, Dateitransfer)
5) Wenn ich weiss, dass gleich was passieren kann..
6) Wenn BackupRestore zeitl nicht mehr aussreicht


Firmenregel:

Wie hoch darf der Datenverlust sein max in Zeit
Wie lange darf die DB ausfallen  in Zeit








*/