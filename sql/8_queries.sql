--UrÄŤĂ­ poÄŤet uĹľivatelĹŻ, kteĹ™Ă­ majĂ­ v danĂ˝ ÄŤas jiĹľ vytvoĹ™enou udĂˇlost v rĂˇmci skupiny

select count(*) from udalost ud, udalosti_uzivatelu uz, skupiny_uzivatelu su
where su.idUzivatele = ud.idVlastnika
and ud.idUdalosti = uz.idUdalosti
and ud.zacatek > '10/10/2013' and ud.konec < '10/10/2015'
and su.idSkupiny = 154;

--select idskupiny, count(idUzivatele) as pocet from skupiny_uzivatelu group by idSkupiny order by pocet desc;

--VypoÄŤte prĹŻmÄ›rnĂ˝ poÄŤet pĹ™Ă­pomĂ­nek uĹľivatelĹŻ.


select distinct idVlastnika, count(idUdalosti) from Udalost;


--UrÄŤĂ­ poÄŤet pĹ™ipomĂ­nek na danou udĂˇlost

select idUdalosti, count(*) as pocet_pripominek from udalosti_uzivatelu group by idUdalosti order by pocet_pripominek desc;

select * from udalosti_uzivatelu where idUdalosti = 998;


--ZjistĂ­ poÄŤet vedoucĂ­ch skupin

select count(distinct idVedouciho) as pocet_vedoucich from skupina;


--VyhledĂˇ nejvyĂ˝Ĺˇe ÄŤtyĹ™i posledni udĂˇlosti pro kaĹľdĂ©ho uĹľivatele.

select idVlastnika, count(idUdalosti) from udalost group by idVlastnika order by idVlastnika;

--vypise u kazdeho mesta pocet udalosti, ktere se tam konali

select mesto.nazevmesta, count(idUdalosti) as pocet_udalosti
from udalost, adresa, mesto
where adresa.idadresy = udalost.idmistakonani and mesto.psc = adresa.psc
group by mesto.nazevmesta
order by count(udalost.idudalosti) desc;

--pro kazde mesto secte vsechny zucastneni uzivatelu na udalosti poradane v danem meste

select mesto.nazevmesta, count(idUzivatele) as pocet_navstevniku
from udalost, adresa, mesto, udalosti_uzivatelu
where adresa.idadresy = udalost.idmistakonani and mesto.psc = adresa.psc and udalosti_uzivatelu.idudalosti = udalost.idudalosti
group by mesto.nazevmesta
order by count(udalost.idudalosti) desc;