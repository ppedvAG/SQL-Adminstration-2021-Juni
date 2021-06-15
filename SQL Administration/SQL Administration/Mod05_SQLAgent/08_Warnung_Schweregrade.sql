/*

EBENE 15 und 16
EBENE 9 Infos
EBENE 14 Sicherheit
EBENE 17
EBENE 20
EBENE 22
EBENE 23
EBENE 24 lastminuteportal: Urlaub 
EBENE 25: sei bloﬂ weit weg

IDEE: bei best Fehler od Schwereregrad (Ebene) Mail an Operator senden

USE [msdb]
GO
EXEC msdb.dbo.sp_add_alert @name=N'DAAUERROR', 
		@message_id=0, 
		@severity=15, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@database_name=N'Northwind', 
		@notification_message=N'..superdaau.. vorsicht schwieriger KOllege', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DAAUERROR', @operator_name=N'MrX', @notification_method = 1
GO



*/

select *   customers

Meldung 102, Ebene 15, Status 1, Zeile 1

select * from kunden

Meldung 208, Ebene 16, Status 1, Zeile 5

select * from sysmessages where msglangid=1031

select * customers
GO 1000

