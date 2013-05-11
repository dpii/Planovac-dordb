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

insert into obj_skupina
select
  idSkupiny
  ,nazev
  ,hesloProPridani
  ,(select ref(objuz) from obj_uzivatel objuz where objuz.idUzivatele = sk.idvedouciho)
  ,popis
from skupina sk;

-----------

insert into obj_udalost
select
  idUdalosti
  ,nazev
  ,(select ref(objuz) from obj_uzivatel objuz where objuz.idUzivatele = ud.idVlastnika)
  ,(select ref(objsk) from obj_skupina objsk where objsk.idSkupiny = ud.idSkupiny)
  ,zacatek
  ,konec
  ,verejna
  ,(select ref(objad) from obj_adresa objad where objad.idAdresy = ud.idMistaKonani)
  ,popis
from udalost ud;


-----------

insert into obj_udalost_uzivatele
select
   (select ref(obju) from obj_udalost obju where obju.idudalosti = uduz.idudalosti)
  ,(select ref(objuz) from obj_uzivatel objuz where objuz.idUzivatele = uduz.iduzivatele)
  ,typ_pripominky
  ,casUpominky
  ,intervalOpakovani
  ,aktivni
from udalosti_uzivatelu uduz;

-----------

insert into obj_skupina_uzivatele
select
   (select ref(objsk) from obj_skupina objsk where objsk.idSkupiny = skuz.idSkupiny)
  ,(select ref(objuz) from obj_uzivatel objuz where objuz.idUzivatele = skuz.iduzivatele)
from skupiny_uzivatelu skuz;