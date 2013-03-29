--Určí počet uživatelů, kteří mají v daný čas již vytvořenou událost v rámci skupiny

select count(*) from udalost ud, udalosti_uzivatelu uz, skupiny_uzivatelu su
where su.idUzivatele = ud.idVlastnika
and ud.idUdalosti = uz.idUdalosti
and ud.zacatek > '10/10/2013' and ud.konec < '10/10/2015'
and su.idSkupiny = 154;

--select idskupiny, count(idUzivatele) as pocet from skupiny_uzivatelu group by idSkupiny order by pocet desc;

--Vypočte průměrný počet přípomínek uživatelů.


select distinct idVlastnika, count(idUdalosti) from Udalost;


--Určí počet připomínek na danou událost

select idUdalosti, count(*) as pocet_pripominek from udalosti_uzivatelu group by idUdalosti order by pocet_pripominek desc;

select * from udalosti_uzivatelu where idUdalosti = 998;


--Zjistí počet vedoucích skupin

select count(distinct idVedouciho) as pocet_vedoucich from skupina;


--Vyhledá nejvyýše čtyři posledni události pro každého uživatele.

select idVlastnika, count(idUdalosti) from udalost group by idVlastnika order by idVlastnika;

