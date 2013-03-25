--Určí počet uživatelů, kteří mají v daný čas již vytvořenou událost v rámci skupiny


select count(*) from uzivatele uz, udalosti ud, pripominky pr, skupiny_uzivatelu us, skupiny sk
where pr.iduzivatele = ud.idVlastnikaUz
and uz.idUzivatele = ud.idVlastnikaUz
and	us.idUzivatele = ud.idVlastnikaUz
and ud.zacatek > '10/10/2009' and ud.konec < '10/10/2015'
and sk.idSkupiny = 9;

--Vypočte průměrný počet přípomínek uživatelů.
select distinct idVlastnika, count(idUdalosti) from Udalost;


--Určí počet připomínek na danou událost





--Zjistí počet vedoucích skupin
select count(distinct idVedouciho) from skupiny;


--Vyhledá nejvyýše čtyři posledni události pro každého uživatele.
select uz.uzivatel, ud.id from uzivatel uz, 