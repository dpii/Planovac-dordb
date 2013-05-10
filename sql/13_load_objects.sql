insert into obj_mesto select * from mesto;

--------------

insert into obj_adresa
select
	 idadresy
	,(select ref(obj) from obj_mesto obj where obj.psc = ad.psc)
	,ulice
	,cislopopisne
  ,mesto
  poznamka
from adresa ad;


-----------

insert into obj_uzivatel
select
   iduzivatele
  ,email
  ,jmeno
  ,prijmeni
  ,heslo
  ,povolen
  ,role
  ,datumzalozeni
  ,datumposledniprihlaseni
  ,telefon
  ,(select ref(obj) from obj_adresa obj where obj.idAdresy = uz.idAdresy)
from uzivatel uz;


-----------

