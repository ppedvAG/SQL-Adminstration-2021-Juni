/*
Instanzfeatures
SQL Server (STD INSTANZ, benannte Instanzt)
	DB Modul
		Replikation (Daten syncen)
		Volltext Semantik


freigegebene Features
nur einmal pro Server 


Authentifizierung

NT Auth
gemischte Auth (NT + SQL Auth)
					   ! --> Konto: SA (SysAdmin. Vollzugriff)
					    --> komplexes Kennwort: 14stellig


Pfade
Binärkram... ex com bat dll.. egal

DB (.mdf master data file (Daten) + .ldf (log data file) Transaktionsprotokoll
Pfad für Daten und Pfad für Log
	Grund: unterschdl LW aus PerfGründen

Pfad  Backup

best DB: Tempdb eig Pfade (eig LW)


Dienstkonto
SQL Server (DB Modul)        NT Service\MSSQLSERVER (lok virt Konten).. kein Kennwort
SQL Agent  (Jobs/Zeitplan)   NT Service\SQLAGENT   (Netzwerkzugriff per Computerkonto)
auch DOM-Userkonto.. braucht beim Setup keine Rechte
schulung\svcSQL    ppedv2019!
schulung\sqlAgent  ppedv2019!


SQL Browser pro Server 1x
?


Volltextsuche


seit SQL 2016 SP1 viele Ent Funktion auch SSEX oder STD
Availability Groups sehr abgespeckt
Part 
Kompr
Columnst



Wieso Instanzen?
Instanz eine vollwertige Installation
eine Instanz interss. nicht für andere Instanzen auf gleichen Rechner

Software... braucht zb SQL 2016 Sp1
			man hat aber schon SQL 2019

Security: ...


STDINST: "PC" (1433)
benannt Instanz: "PC\Instanzname" (????) random Port

Client denkt immer 1433-- Browser(UDP 1434)

















*/