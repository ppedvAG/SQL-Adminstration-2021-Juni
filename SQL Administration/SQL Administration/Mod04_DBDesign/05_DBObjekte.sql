

Datenbankobjekte


Sichten gemerkte Abfrage und verhält sich wie ne Tabelle (INS UP DEL  SEL; RECHTE)
enthält keine Daten
*/

create view vdemo
as
select * from orders where freight < 10

select * from vdemo


select * from (select * from orders where freight < 10) sicht


--Prozeduren: wie Batchdateien unter Windows und können Parameter
--verwendet man gerne , um Businesslogik zu kapseln
--sie ist meist schneller....

create proc gpdemo @par int, @par2..
as
select * from orders where freight < @par
INS
UP
DEL
SEL


exec gpdemo 10



--F()..ist einfach langsam....aber sehr flexibel einsetzbar
--Nachteil.. nur eine CPU wird verwednet , und vorab nicht einschätzbar..
--Indizes werden meeist nicht korrekt eingsetzt

select * from tabelle where f(spalte)<10
select f(spalte) from f(werte) where f(spalte) < f(wert)


--Indizes!!
select * from customers where companyname like 'A%' --alle Kunde mit A beginnen

select * from customers where left(companyname,1) ='A'--alle Kunde mit A beginnen



*/
