--
drop table skupiny_uzivatelu;
drop table udalosti_uzivatelu;
drop table pripominky;

ALTER TABLE skupina DROP CONSTRAINT fk_idVedouciho;

alter table udalosti drop constraint fk_idVlastnikaSK;
alter table udalosti drop constraint fk_idVlastnikaUz;

drop table skupina;
drop table uzivatele;
drop table udalost;
drop table adresa;

-- !! triggery a sekvence - zustanou


--------------------------------------------S
--drop table adresa
create table Adresa (
  idAdresy number(4) CONSTRAINT nn_idAdresyA NOT NULL CONSTRAINT pk_idAdresyA PRIMARY KEY,
  psc number(5),
  ulice varchar2(40),
  cisloPopisne number(4),
  mesto varchar2(40),
  poznamka varchar2(30)
);

--autoincrement Adresa.idAdresy
CREATE SEQUENCE seq_adresa
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER adresa
BEFORE INSERT ON adresa
FOR EACH ROW
begin
  select seq_adresa.nextval into :new.idAdresy from dual;
end;
--------------------------------------------E

-------------------------------------------S

--drop table UZIVATEL;
create table uzivatel (
  idUzivatele number(10) CONSTRAINT pk_idUzivatele primary key CONSTRAINT nn_idUzivatele not null,
  email varchar2(40) CONSTRAINT nn_email NOT NULL,
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


--zmena typu/delky sloupce
alter table uzivatele modify (
  email varchar2(40) 
  );


--test insert uzivatele
--insert into uzivatele (login, email, heslo_hash, povolen, role) VALUES ('asd', 'asd@asd.com', '123', '1', 'user');

--poruseni integritniho omezeni not null na role
--insert into uzivatele (login, email, heslo_hash, povolen) VALUES ('asd', 'asd@asd.com', '123', '1');


--autoincrement uzivatel.idUzivatele
CREATE SEQUENCE seq_uzivatel
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER uzivatel
BEFORE INSERT ON uzivatel
FOR EACH ROW
begin
  select seq_uzivatel.nextval into :new.idUzivatele from dual;
end;

-------------------------------------------E


-------------------------------------------S

--drop table skupiny;
CREATE TABLE Skupina (
  idSkupiny number(4) CONSTRAINT nn_idSkupiny NOT NULL CONSTRAINT pk_idSkupiny PRIMARY KEY,
  nazev varchar2(30),
  hesloProPridani varchar2(30),
  idVedouciho number(4) CONSTRAINT nn_idVedouciho  NOT NULL,
  popis varchar2(255),
  CONSTRAINT fk_idVedouciho FOREIGN KEY (idVedouciho) REFERENCES uzivatel(idUzivatele)
);

--autoincrement skupiny.idSkupiny
CREATE SEQUENCE seq_skupina
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER skupina
BEFORE INSERT ON Skupina
FOR EACH ROW
begin
  select seq_skupina.nextval into :new.idSkupiny from dual;
end;

-------------------------------------------E

-------------------------------------------S
--drop table udalosti;
CREATE TABLE  UDALOST (
  idUdalosti number(4) CONSTRAINT nn_idUdalosti NOT NULL CONSTRAINT pk_idUdalosti PRIMARY KEY,
  nazev varchar2(30),
  idVlastnikaSk number(4) ,
  idVlastnikaUz number(4) ,
  zacatek date,
  konec date,
  verejna number(1),
  idMistaKonani number(10),
  
  popis varchar2(255),
  CONSTRAINT fk_idVlastnikaSK foreign key (idVlastnikaSk) REFERENCES skupina(idSkupiny),
  CONSTRAINT fk_idVlastnikaUz foreign key (idVlastnikaUz) REFERENCES uzivatel(idUzivatele),
  CONSTRAINT fk_idMistaKonani foreign key (idMistaKonani) REFERENCES Adresa(idAdresy)
);


--autoincrement udalost.idUdalosti
CREATE SEQUENCE seq_udalost
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER udalost
BEFORE INSERT ON udalost
FOR EACH ROW
begin
  select seq_udalost.nextval into :new.idUdalosti from dual;
end;
-------------------------------------------E

-------------------------------------------S
--drop table skupiny_uzivatelu;
CREATE TABLE SKUPINY_UZIVATELU (
  idSkupiny number(4) CONSTRAINT nn_idSkupinyUz NOT NULL,
   idUzivatele number(4) CONSTRAINT nn_idUzivateleSk NOT NULL,
   CONSTRAINT fk_idskupiny FOREIGN KEY (idSkupiny) REFERENCES SKUPINA(idSkupiny),
  CONSTRAINT fk_idUzivatele FOREIGN KEY (idUzivatele) REFERENCES UZIVATEL(idUzivatele),
  CONSTRAINT uc_SkupinyUzivatele UNIQUE (idSkupiny,idUzivatele)
);
-------------------------------------------E

-------------------------------------------S
--drop table udalosti_uzivatelu;
CREATE TABLE UDALOSTI_UZIVATELU (
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
--------------------------------------------E



-- tomatova nachazelofka

grant all on uzivatel to nachato1;
grant all on skupina to nachato1;
grant all on udalost to nachato1;
grant all on skupiny_uzivatelu to nachato1;
grant all on udalosti_uzivatelu to nachato1;
grant all on adresa to nachato1;

revoke all on uzivatel from nachato1;
revoke all on skupina from nachato1;
revoke all on udalost from nachato1;
revoke all on skupiny_uzivatelu from nachato1;
revoke all on udalosti_uzivatelu from nachato1;
revoke all on adresa from nachato1;