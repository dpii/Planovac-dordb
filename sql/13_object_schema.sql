create type type_mesto as object
(
  psc varchar(30),
  nazevMesta varchar2(40),
  
 );

create type type_adresa as object
(

  idAdresy number(4),
  ulice varchar2(40),
  cisloPopisne number(4),
  mesto type_mesto,
  poznamka varchar2(255)

 );


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
  idAdresy type_adresa

 );

CREATE TYPE type_uzivatele AS TABLE OF type_uzivatel;

CREATE type type_skupina as object 

(

  idSkupiny number(4),
  nazev varchar2(30),
  hesloProPridani varchar2(30),
  vedouciho type_uzivatel,
  popis varchar2(255),
  cleni type_uzivatele
);

CREATE TYPE type_skupiny AS TABLE OF type_skupina;
\
ALTER TYPE type_uzivatel ADD attribute
skupiny REF type_skupiny cascade;

CREATE type type_udalost as object
(
  idUdalosti number(4),
  nazev varchar2(30),
  vlastnik type_uzivatel,
  skupina type_skupina,
  zacatek date,
  konec date,
  verejna number(1),
  mistoKonani type_adresa,
  popis varchar2(255)
  
);

CREATE type type_udalost_uzivatele as object (

  udalost type_udalost,
  uzivatel type_uzivatel,
  typ_pripominky number(4) ,
  casUpominky DATE,
  intervalOpakovani number(4) ,
  aktivni number(1)
 );
 
CREATE TYPE type_udalosti_uzivatelu AS TABLE OF type_udalost_uzivatele;

\
ALTER TYPE type_uzivatel ADD attribute
udalosti REF type_udalosti_uzivatelu cascade;

ALTER TYPE type_udalost ADD attribute
ucastnici REF type_udalosti_uzivatelu cascade;


------------------------Tabulky--
--nejsem si jistý tím FOREIGN KEY ... IS ... - kdyžtak nahradit za SCOPE FOR ... REFERENCES ...

CREATE TABLE obj_mesto OF type_mesto;

CREATE TABLE obj_adresa OF type_adresa
(FOREIGN KEY (mesto) REFERENCES obj_mesto);

CREATE TABLE obj_uzivatel OF type_uzivatel
(FOREIGN KEY (adresa) REFERENCES obj_adresa);

CREATE TABLE obj_skupina OF type_skupina
(FOREIGN KEY (vedouci) REFERENCES obj_uzivatel);

CREATE TABLE obj_udalost OF type_udalost
(FOREIGN KEY (adresa) REFERENCES obj_adresa,
FOREIGN KEY (skupina) REFERENCES obj_skupina,
FOREIGN KEY (vlastnik) REFERENCES obj_uzivatel);

CREATE TABLE obj_udalost_uzivatele OF type_udalost_uzivatele
(FOREIGN KEY (uzivatel) REFERENCES obj_uzivatel,
FOREIGN KEY (udalost) REFERENCES obj_udalost);


