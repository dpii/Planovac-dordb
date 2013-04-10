-- Po pridani uzivatele do skupiny, nastavni hodnotu ve Skupina - pocet_clenu

-- pridani sloupce pro odvozenou hodnotu

alter table skupina add
(

pocet_clenu number

);


--  trigger, heavy stuff!

create or replace 
trigger sectiSkupinu
after insert or delete 
ON skupiny_uzivatelu
declare
temp number;
  BEGIN
   
update skupina set pocet_clenu = sectiCleny(idSkupiny);

  END;
  
 -- funkce
  
create or replace 
function sectiCleny(id_skupiny number) 
return number

is

pocet number;
begin

select count(*) into pocet  from skupiny_uzivatelu where idSkupiny = id_skupiny;

return pocet;

end;      
  


 --     test qrs
  
  --insert into skupiny_uzivatelu (idSkupiny, idUzivatele) Values(2, 632);
  --select * from skupiny_uzivatelu where idSkupiny = 2;
  --select * from skupina where idSkupiny = 2;