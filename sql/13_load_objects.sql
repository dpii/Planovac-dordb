insert into obj_mesto select * from mesto;



insert into obj_adresa
select
	 idadresy
	,(select ref(obj) from obj_mesto obj where obj.psc = ad.psc)
	,ulice
	,cislopopisne
  ,mesto
  poznamka
from adresa ad;