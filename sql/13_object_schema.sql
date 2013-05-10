create type type_mesto as object
(
  psc varchar(30),
  nazevMesta varchar2(40)
  
  
  
 );
 
 
 
 CREATE TABLE obj_mesto OF type_mesto(psc PRIMARY KEY);
 
 
 -------------------------
 

create type type_adresa as object
(

  idAdresy number(4),
  ulice varchar2(40),
  cisloPopisne number(4),
  mesto REF type_mesto,
  poznamka varchar2(255)

 );
 
 
 CREATE TABLE obj_adresa OF type_adresa
(FOREIGN KEY (mesto) REFERENCES obj_mesto);


--------------------------


create type type_uzivatel as object

(

  idUzivatele number(10),
  email varchar2(60),
  jmeno varchar2(30),
  prijmeni varchar2(30),
  heslo varchar2(30),
  povolen number(1),
  role varchar2(45),
  datumZalozeni DATE,
  datumPosledniPrihlaseni DATE,
  telefon varchar2(20),
  adresa REF type_adresa

 );
 
 
 
 CREATE TABLE obj_uzivatel OF type_uzivatel
(FOREIGN KEY (adresa) REFERENCES obj_adresa);

CREATE TYPE type_uzivatele AS TABLE OF type_uzivatel;

CREATE type type_skupina as object 

(

  idSkupiny number(4),
  nazev varchar2(30),
  hesloProPridani varchar2(30),
  vedouci REF type_uzivatel,
  popis varchar2(255)
);


CREATE TABLE obj_skupina OF type_skupina
(FOREIGN KEY (vedouci) REFERENCES obj_uzivatel);

-------------------

CREATE TYPE type_skupiny AS TABLE OF type_skupina;
\
ALTER TYPE type_uzivatel ADD attribute
skupiny REF type_skupiny cascade;


--------------------

CREATE type type_udalost as object
(
  idUdalosti number(4),
  nazev varchar2(30),
  vlastnik REF type_uzivatel,
  skupina REF type_skupina,
  zacatek date,
  konec date,
  verejna number(1),
  misto REF type_adresa,
  popis varchar2(255)
  
);



CREATE TABLE obj_udalost OF type_udalost
(FOREIGN KEY (misto) REFERENCES obj_adresa,
FOREIGN KEY (skupina) REFERENCES obj_skupina,
FOREIGN KEY (vlastnik) REFERENCES obj_uzivatel);

----------------

CREATE type type_udalost_uzivatele as object (

  udalost REF type_udalost,
  uzivatel REF type_uzivatel,
  typ_pripominky number(4) ,
  casUpominky DATE,
  intervalOpakovani number(4) ,
  aktivni number(1)
 );
 
 
  CREATE TYPE type_udalosti_uzivatelu AS TABLE OF type_udalost_uzivatele;
 
 
 CREATE TABLE obj_udalost_uzivatele OF type_udalost_uzivatele
(FOREIGN KEY (uzivatel) REFERENCES obj_uzivatel,
FOREIGN KEY (udalost) REFERENCES obj_udalost);

 
--\
--ALTER TYPE type_uzivatel ADD attribute
--udalosti REF type_udalosti_uzivatelu cascade;

--ALTER TYPE type_udalost ADD attribute
--ucastnici REF type_udalosti_uzivatelu cascade;













--




