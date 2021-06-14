/*
Mailserver
IIS 6

SMTP Zugangsdaten

IIS6--> Maildomäne: sql.local

DatenbankEmail
--> Profil mit SMTP Konto
--Öfftl Profil bedeutet : man muss Mitglied einer best Gruppe

		msdb...(Rolle) DatabaseMailUserRole

Operatoren anlegen: Alias für Emailadresse

Mails an Operatoren 



USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_id=N'3894dc24-195b-4320-9a16-36f10f1fda45', 
		@notify_level_email=3, 
		@notify_level_page=2, 
		@notify_email_operator_name=N'MrX'
GO



Automatischer Versand nur wenn Profil dem Agent Dienst zugeordnet
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1, 
		@databasemail_profile=N'SQLLOCAL'
GO

Neustart des Dienstes


--Seit 2016 SQL 
--Beim Einrichten der DBMail wurde dem Gast ein Recht zugewiesen...




*/