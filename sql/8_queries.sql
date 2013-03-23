--Určí počet uživatelů, kteří mají v daný čas již vytvořenou událost v rámci skupiny


select count(*) from (select id_uzivatele from udalosti where zacatek > '10/10/2009' and konec < '10/10/2010') where    ;


select * from (select distinct idUzivatele from UzivatelSkupina where idSkupiny = 9);

--Vypočte průměrný počet přípomínek uživatelů.
select distinct idVlastnika, count(idUdalosti) from Udalost;


--Určí počet připomínek na danou událost



--Zjistí počet vedoucích skupin
select 


--Vyhledá nejvyýše čtyři posledni události pro každého uživatele.
select uz.uzivatel, ud.id from uzivatel uz, 