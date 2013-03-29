create type type_adresa as object
(

  idAdresy number(4),
  psc varchar(30),
  ulice varchar2(40),
  cisloPopisne number(4),
  mesto varchar2(40),
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
  idAdresy number(4),

 );



CREATE type type_skupina as object 

(

  idSkupiny number(4),
  nazev varchar2(30),
  hesloProPridani varchar2(30),
  idVedouciho number(4),
  popis varchar2(255)
  
);



CREATE type type_udalost as object
(
  idUdalosti number(4),
  nazev varchar2(30),
  idVlastnika number(4),
  idSkupiny number(4),
  zacatek date,
  konec date,
  verejna number(1),
  idMistaKonani number(10),
  popis varchar2(255)

);


CREATE type type_skupiny_uzivatelu as object 
(

  idSkupiny number(4),
  idUzivatele number(4)

);



CREATE type type_udalosti_uzivatelu as object (

  idUdalosti number(4),
  idUzivatele number(4),
  typ_pripominky number(4) ,
  casUpominky DATE,
  intervalOpakovani number(4) ,
  aktivni number(1)
 );
