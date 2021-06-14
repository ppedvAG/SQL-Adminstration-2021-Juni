/*
Job haben in der Regel Zeitpläne

Job kann einen od mehrere Schritte haben

Reihenfolge der Schritte editierbar
Was ist ein Fehler?
Schritt klappt überhaupt nicht

Es lohnt sich einen Einmalzeitplan zu machen
Kann aber jederzeit aktiviert werden

Wenn ein JOb etwas ausserhalb von SQL Server erledigen soll
dann kann man ein Proxykonto definieren
"Ausführen als.." (Konto und Kennwort)

--Sicherheit--Anmeldeinformationen

USE [master]
GO
CREATE CREDENTIAL [Kairoadmin] WITH IDENTITY = N'KAIRO\Administrator',
SECRET = N'ppedv2020!'
GO

--dann als Proxy eintragen

USE [msdb]
GO
EXEC msdb.dbo.sp_add_proxy @proxy_name=N'ProxykairoAdmin',
	@credential_name=N'Kairoadmin', 
		@enabled=1
GO
EXEC msdb.dbo.sp_grant_proxy_to_subsystem 
	@proxy_name=N'ProxykairoAdmin', @subsystem_id=3
GO


_Am Ende des Jobs muss Email raus..



*/