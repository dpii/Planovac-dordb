select count(*) from obj_udalost ud, obj_udalost_uzivatele uz, obj_skupina_uzivatele su
where su.uzivatel.iduzivatele = uz.uzivatel.iduzivatele
and ud.idudalosti = uz.udalost.idudalosti
and ud.zacatek > '10/10/2013' and ud.konec < '10/10/2015'
and su.skupina.idSkupiny = '154';

select avg(count(ud.udalost.idUdalosti)) as Prumery_pocet_pripominek_uziv from obj_udalost_uzivatele ud where ud.aktivni = '1' group by ud.uzivatel;

select ud.udalost.idUdalosti, count(*) as pocet_pripominek from obj_udalost_uzivatele ud where aktivni = '1' group by ud.udalost.idUdalosti order by pocet_pripominek desc;

SELECT ud.nazev, ud.zacatek, ud.konec, me.nazevmesta FROM obj_udalost_uzivatele uz, obj_udalost ud, obj_adresa ad, obj_mesto me where me.psc = ad.mesto.psc and ud.misto.idadresy = ad.idadresy and uz.udalost.idudalosti = ud.idudalosti and uz.uzivatel.iduzivatele = '674' and rownum < 5 order by ud.zacatek;

select me.nazevmesta, count(ud.idUdalosti) as pocet_udalosti
from obj_udalost ud, obj_adresa ad, obj_mesto me
where ad.idadresy = ud.misto.idadresy and me.psc = ad.mesto.psc
group by me.nazevmesta
order by count(ud.idudalosti) desc;

select me.nazevmesta, count(uz.uzivatel.idUzivatele) as pocet_navstevniku
from obj_udalost ud, obj_adresa ad, obj_mesto me, obj_udalost_uzivatele uz
where ad.idadresy = ud.misto.idadresy and me.psc = ad.mesto.psc and uz.udalost.idudalosti = ud.idudalosti
group by me.nazevmesta
order by count(ud.idudalosti) desc;