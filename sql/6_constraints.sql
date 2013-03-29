--2.1.1

alter table Udalost
add constraint cas_check check (zacatek < konec);

--2.1.2 

ALTER TABLE Skupina
MODIFY (idVedouciho NUMBER(8,2) CONSTRAINT nn_IdVedoucihoS NOT NULL); 

--2.1.3

alter table Skupina 
add constraint skupina_heslo_kontrola check (length(heslopropridani) > 2);

--2.1.4

alter table Uzivatel add constraint  uzivatel_heslo_kontrola check (length(heslo) > 4);

--2.2.1 

CREATE OR REPLACE PROCEDURE kontrola_cas_pripominka  (id in number) AS
zacatek in date;
prip in date;
BEGIN
	
 SELECT u.zacatek INTO zac FROM udalost u WHERE u.id_pripominky = id;
 SELECT uz.casUpominky INTO prip FROM udalosti_uzivatele uz WHERE uz.idUdalosti = id;
 

 IF (prip > zac) then
  raise_application_error(-20000, 'Připomínka musí začít před začátkem události!');
 END IF;
END;


CREATE OR REPLACE TRIGGER kontrola_cas_pripominka
BEFORE insert or update 
ON udalosti_uzivatelu
FOR EACH ROW
  BEGIN
    kontrola_cas_pripominka(:new.idUdalosti);
  END;
  
--2.2.2 

CREATE OR REPLACE PROCEDURE kontrola_skupiny  (id in number) AS
pocet in number;
BEGIN
	
	
	SELECT count(*) INTO pocet FROM skupiny_uzivatelu WHERE idSkupiny = id GROUP BY idSkupiny; 

 IF (pocet > 150) then
  raise_application_error(-20000, 'Skupina nemůže mít více jak 150 členů!');
 END IF;
END;


CREATE OR REPLACE TRIGGER kontrola_skupiny
BEFORE insert or update 
ON skupiny_uzivatelu
FOR EACH ROW
  BEGIN
    kontrola_skupiny(:new.idSkupiny);
  END;