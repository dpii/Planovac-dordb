--Urci pocet uzivatelu v konkrétní skupine, kteri maji nějakou udalost v zadanem rozmezi

select count(*) from udalost ud, udalosti_uzivatelu uz, skupiny_uzivatelu su
where su.idUzivatele = uz.iduzivatele
and ud.idUdalosti = uz.idUdalosti
and ud.zacatek > '10/10/2013' and ud.konec < '10/10/2015'
and su.idSkupiny = '154';

--Vypocte prumerny pocet pripominek na uzivatele

select avg(count(*)) as Prumery_pocet_pripominek_uziv from udalosti_uzivatelu uu where uu.aktivni = '1'  group by uu.iduzivatele;


--Urci kolik lidi ma nastavenou pripominku na urcite udalosti

select idUdalosti, count(*) as pocet_pripominek from udalosti_uzivatelu where aktivni = '1' group by idUdalosti order by pocet_pripominek desc;


--Vyhleda 4 nejblizsi udalosti pro konkrétního uživatele

SELECT ud.nazev, ud.zacatek, ud.konec, me.nazevmesta FROM udalosti_uzivatelu uz, udalost ud, adresa ad, mesto me where me.psc = ad.psc and ud.idmistakonani = ad.idadresy and uz.idudalosti = ud.idudalosti and uz.iduzivatele = '674' and rownum < 5 order by ud.zacatek;

--Vypise u kazdeho mesta pocet udalosti, ktere se tam konali

select mesto.nazevmesta, count(idUdalosti) as pocet_udalosti
from udalost, adresa, mesto
where adresa.idadresy = udalost.idmistakonani and mesto.psc = adresa.psc
group by mesto.nazevmesta
order by count(udalost.idudalosti) desc;

--Pro kazde mesto secte vsechny zucastneni uzivatelu na udalosti poradane v danem meste

select mesto.nazevmesta, count(idUzivatele) as pocet_navstevniku
from udalost, adresa, mesto, udalosti_uzivatelu
where adresa.idadresy = udalost.idmistakonani and mesto.psc = adresa.psc and udalosti_uzivatelu.idudalosti = udalost.idudalosti
group by mesto.nazevmesta
order by count(udalost.idudalosti) desc;