/*

Installation

Dienstkonten
NT SERVICE\
lokale Konten, Passwords automatisch, Computerkonto (für Netzzugriff)

Browser: UDP 1434 ..gibt Port bekannt , Waschweib, peer default deaktiviert
..braucht man, wenn man benannnt Instanzen hat: PC\INSTNAME

Dienstkonten ändern nur in SSCM


Agent--> Backup--> Proxy Konto--\\
          TSQL Code--kein Proxy	   


Authentifizierung
NT oder gemischt (NT + SQL)



Instanzfeature
	DB Engine (Replikation, Volltext)


Freigegebene Funktionen
	Klientconnectiv...

SSMS muss sep installiert (download)..letzte Version

Pfadeangaben

DB (.mdf + .ldf): Trenne ..versch Laufwerke BenutzerDBs

TempDb
	soviele Dateien wie Kerne
	verschd LW für mdf und ldf

RAM
	schlägt den Max  Wert des Datenpuffers, um dem OS etwas Luft zu verschaffen
	2 bis 4 GB auf jeden Fall

IOPS...50000

Regel: reduziere IO--> weniger RAM--->weniger CPUs
       je mehr HDDs desto einfacher die Skalierung
	   -->eine Tabelle kann auf 15000 Hdds verteilt werden


f(117)-2

INT ------100----------------200-------------------------
     1             2				3

scheme   2= E: ndf
         1=D:  mdf (Systemtabellen)
		 3=F:  ndf


Agent

Operatoren: braucht man für JobMails

DBMail (SMTP Konto Zugangsdaten=PROFIL)

Falls der Job Email verschiecken soll, dann muss:
- Agent Warnungssystem aktivieren und Profil zuweisen
- Neu starten

--vor SQL 2016 
Rechte in msdb für Agent vergeben...
Agent muss in einer best Rolle sein (DatabaseMailuserRole)
Seit SQL 2016 wird guest aktiviert..


*/

use msdb

exec sp_send_dbmail

