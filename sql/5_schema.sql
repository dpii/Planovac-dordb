create table Mesto
(
	psc number(5) CONSTRAINT nn_pscA NOT NULL CONSTRAINT pk_pscA PRIMARY KEY,
	nazevMesta varchar2(30)
);

create table Adresa
(
  idAdresy number(4) CONSTRAINT nn_idAdresyA NOT NULL CONSTRAINT pk_idAdresyA PRIMARY KEY,
  psc number(5),
  ulice varchar2(40),
  cisloPopisne number(4),
  mesto varchar2(40),
  poznamka varchar2(255),

  CONSTRAINT fk_pscUD foreign key (psc) REFERENCES mesto(psc)
 );

CREATE SEQUENCE seq_adresa
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
create or replace 
trigger adresa
BEFORE INSERT ON adresa
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.idAdresy is null then
        select SEQ_ADRESA.nextval into :new.idAdresy from dual;
    else
        select greatest(nvl(max(idAdresy),0), :new.idAdresy) into max_id from adresa;
        select SEQ_ADRESA.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select SEQ_ADRESA.nextval into cur_seq from dual;
        end loop;
    end if;
end;


---------------------------


create table uzivatel (

  idUzivatele number(10) CONSTRAINT pk_idUzivatele primary key CONSTRAINT nn_idUzivatele not null,
  email varchar2(60) CONSTRAINT nn_email NOT NULL,
  jmeno varchar2(30),
  prijmeni varchar2(30),
  heslo varchar2(30) CONSTRAINT nn_heslo  NOT NULL,
  povolen number(1) CONSTRAINT nn_povolen NOT NULL,
  role varchar2(45) CONSTRAINT nn_role NOT NULL,
  datumZalozeni DATE,
  datumPosledniPrihlaseni DATE,
  telefon varchar2(20),
  idAdresy number(4),
  CONSTRAINT fk_idAdresy FOREIGN KEY (idAdresy) REFERENCES Adresa(idAdresy)

 );

CREATE SEQUENCE seq_uzivatel
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
create or replace 
trigger uzivatel
BEFORE INSERT ON uzivatel
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.idUzivatele is null then
        select SEQ_UZIVATEL.nextval into :new.idUzivatele from dual;
    else
        select greatest(nvl(max(idUzivatele),0), :new.idUzivatele) into max_id from Uzivatel;
        select SEQ_UZIVATEL.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select SEQ_UZIVATEL.nextval into cur_seq from dual;
        end loop;
    end if;
end;

---------------------------




CREATE TABLE skupina (

  idSkupiny number(4) CONSTRAINT nn_idSkupiny NOT NULL CONSTRAINT pk_idSkupiny PRIMARY KEY,
  nazev varchar2(30),
  hesloProPridani varchar2(30),
  idVedouciho number(4) CONSTRAINT nn_idVedouciho  NOT NULL,
  popis varchar2(255),
  CONSTRAINT fk_idVedouciho FOREIGN KEY (idVedouciho) REFERENCES uzivatel(idUzivatele)
  
);


CREATE SEQUENCE seq_skupina
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
create or replace 
trigger skupina
BEFORE INSERT ON skupina
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.idSkupiny is null then
        select seq_skupina.nextval into :new.idSkupiny from dual;
    else
        select greatest(nvl(max(idSkupiny),0), :new.idSkupiny) into max_id from skupina;
        select seq_skupina.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_skupina.nextval into cur_seq from dual;
        end loop;
    end if;
end;

---------------------------


CREATE TABLE  UDALOST (
  idUdalosti number(4) CONSTRAINT nn_idUdalosti NOT NULL CONSTRAINT pk_idUdalosti PRIMARY KEY,
  nazev varchar2(30),
  idVlastnika number(4) ,
  idSkupiny number(4) ,
  zacatek date,
  konec date,
  verejna number(1),
  idMistaKonani number(10),
  
  popis varchar2(255),

  CONSTRAINT fk_idVlastnikaUD foreign key (idVlastnika) REFERENCES uzivatel(idUzivatele),
  CONSTRAINT fk_idSkupinyUD foreign key (idSkupiny) REFERENCES skupina(idSkupiny),
  CONSTRAINT fk_idMistaKonaniUD foreign key (idMistaKonani) REFERENCES Adresa(idAdresy));


CREATE SEQUENCE seq_udalost
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
create or replace 
trigger UDALOST
BEFORE INSERT ON UDALOST
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.idUdalosti is null then
        select seq_udalost.nextval into :new.idUdalosti from dual;
    else
        select greatest(nvl(max(idUdalosti),0), :new.idUdalosti) into max_id from UDALOST;
        select seq_udalost.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_udalost.nextval into cur_seq from dual;
        end loop;
    end if;
end;


---------------------------


CREATE TABLE skupiny_uzivatelu (

  idSkupiny number(4) CONSTRAINT nn_idSkupinyUz NOT NULL,
   idUzivatele number(4) CONSTRAINT nn_idUzivateleSk NOT NULL,
   CONSTRAINT fk_idskupiny FOREIGN KEY (idSkupiny) REFERENCES SKUPINA(idSkupiny),
  CONSTRAINT fk_idUzivatele FOREIGN KEY (idUzivatele) REFERENCES UZIVATEL(idUzivatele),
  CONSTRAINT uc_SkupinyUzivatele UNIQUE (idSkupiny,idUzivatele)

);


---------------------------


CREATE TABLE udalosti_uzivatelu (

  idUdalosti number(4)  CONSTRAINT nn_idUdalostiUU NOT NULL,
  idUzivatele number(4) CONSTRAINT nn_idUzivateleUU NOT NULL,
  typ_pripominky number(4) ,
  casUpominky DATE,
  intervalOpakovani number(4) ,
  aktivni number(1),
  CONSTRAINT fk_UdalostiUU FOREIGN KEY (idUdalosti) REFERENCES UDALOST(idUdalosti),
  CONSTRAINT fk_UzivateleUU FOREIGN KEY (idUzivatele) REFERENCES UZIVATEL(idUzivatele),
  CONSTRAINT uc_UdalUziv UNIQUE (idUdalosti,idUzivatele)

  );