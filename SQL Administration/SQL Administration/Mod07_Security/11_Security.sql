USE [master]
GO
CREATE LOGIN [Max] WITH PASSWORD=N'123',
DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE [master]
GO
CREATE LOGIN [Susi] WITH PASSWORD=N'123', 
DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


USE [Northwind]
GO
CREATE USER [Susi] FOR LOGIN [Susi]
GO
CREATE USER [Max] FOR LOGIN [Max]
GO

select * from syslogins


USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO


USE [Northwind]
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO

create table it.kst(itkst int)
create table it.personl(itperso int)

create table ma.kst(makst int)
create table ma.personl(maperso int)


use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Max]
GO

GRANT SELECT ON SCHEMA::[MA] TO [SUSI]
GO


USE [Northwind]
GO
ALTER USER [Max] WITH DEFAULT_SCHEMA=[IT]
GO

USE [Northwind]
GO
ALTER USER [SUSI] WITH DEFAULT_SCHEMA=[MA]
GO


use [Northwind]
GO
GRANT SELECT ON [MA].[kst] TO [Max]
GO


USE [Northwind]
GO
CREATE ROLE [ITRolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Max]
GO


select * from kst --das gibts nicht.. jeder User hat ein Std Schema (default dbo)

select * from it.kst




USE [master]
GO
CREATE LOGIN [Peter] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Peter] FOR LOGIN [Peter]
GO
USE [Northwind]
GO
ALTER USER [Peter] WITH DEFAULT_SCHEMA=[IT]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Peter]
GO
