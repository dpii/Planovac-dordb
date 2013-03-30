-- Pro každého uživatele ukáže, kolik času zbývá do nejblížší události

create or replace procedure vypocti_dobu(ide in number, zacat in date) as
pocet number;
begin

pocet := zacat - to_date(sysdate, 'DD.MM.YYYY HH24:MI:SS');
 
update udalosti_uzivatelu set od_vlozeni_zacne_za = pocet where idUdalosti = ide;
 
end;

create or replace trigger vypocet_doby
after insert or update
ON udalost
for each row  
BEGIN
  vypocti_dobu(:new.idUdalosti,:new.zacatek);
END;