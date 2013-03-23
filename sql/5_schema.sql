--
drop table skupiny_uzivatelu;
drop table udalosti_uzivatelu;
drop table pripominky;

ALTER TABLE skupiny DROP CONSTRAINT fk_idVedouciho;

alter table udalosti drop constraint fk_idVlastnikaSK;
alter table udalosti drop constraint fk_idVlastnikaUz;

drop table skupiny;
drop table uzivatele;
drop table udalosti;

-- nezapomenout na triggery a sekvence - zustanou


--drop table UZIVATELE;
create table uzivatele (
  idUzivatele number(10) CONSTRAINT pk_idUzivatele primary key CONSTRAINT nn_idUzivatele not null,
  email varchar2(40) CONSTRAINT nn_email NOT NULL,
  jmeno varchar2(30),
  prijmeni varchar2(30),
  heslo varchar2(30) CONSTRAINT nn_heslo  NOT NULL,
  povolen number(1) CONSTRAINT nn_povolen NOT NULL,
  role varchar2(45) CONSTRAINT nn_role NOT NULL,
  datumZalozeni DATE,
  datumPosledniPrihlaseni DATE,
  adresa varchar2(30),
  mesto varchar2(30),
  telefon varchar2(20)
);


--zmena typu/delky sloupce
alter table uzivatele modify (
  email varchar2(40) 
  );


--test insert uzivatele
--insert into uzivatele (login, email, heslo_hash, povolen, role) VALUES ('asd', 'asd@asd.com', '123', '1', 'user');

--poruseni integritniho omezeni not null na role
--insert into uzivatele (login, email, heslo_hash, povolen) VALUES ('asd', 'asd@asd.com', '123', '1');


--autoincrement uzivatele.idUzivatele
CREATE SEQUENCE seq_uzivatele
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER uzivatele
BEFORE INSERT ON uzivatele
FOR EACH ROW
begin
  select seq_uzivatele.nextval into :new.idUzivatele from dual;
end;


--drop table skupiny;
CREATE TABLE SKUPINY (
  idSkupiny number(4) CONSTRAINT nn_idSkupiny NOT NULL CONSTRAINT pk_idSkupiny PRIMARY KEY,
  nazev varchar2(30),
  idVedouciho number(4) CONSTRAINT nn_idVedouciho  NOT NULL,
  popis varchar2(255),
  verejna number(1),
  CONSTRAINT fk_idVedouciho FOREIGN KEY (idVedouciho) REFERENCES uzivatele(idUzivatele)
);

--autoincrement skupiny.idSkupiny
CREATE SEQUENCE seq_skupiny
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER skupiny
BEFORE INSERT ON skupiny
FOR EACH ROW
begin
  select seq_skupiny.nextval into :new.idSkupiny from dual;
end;

--drop table udalosti;
CREATE TABLE  UDALOSTI (
  idUdalosti number(4) CONSTRAINT nn_idUdalosti NOT NULL CONSTRAINT pk_idUdalosti PRIMARY KEY,
  nazev varchar2(30),
  verejna number(1),
  idVlastnikaSk number(4) ,
  idVlastnikaUz number(4) ,
  obrazek varchar2(30),
  zacatek date,
  konec date,
  popis varchar2(255),
  CONSTRAINT fk_idVlastnikaSK foreign key (idVlastnikaSk) REFERENCES skupiny(idSkupiny),
  CONSTRAINT fk_idVlastnikaUz foreign key (idVlastnikaUz) REFERENCES uzivatele(idUzivatele)
);

--autoincrement udalosti.idUdalosti
CREATE SEQUENCE seq_udalosti
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER udalosti
BEFORE INSERT ON udalosti
FOR EACH ROW
begin
  select seq_udalosti.nextval into :new.idUdalosti from dual;
end;

--drop table skupiny_uzivatelu;
CREATE TABLE SKUPINY_UZIVATELU (
  idSkupiny number(4) CONSTRAINT nn_idSkupinyUz NOT NULL,
   idUzivatele number(4) CONSTRAINT nn_idUzivateleSk NOT NULL,
   CONSTRAINT fk_idskupiny FOREIGN KEY (idSkupiny) REFERENCES SKUPINY(idSkupiny),
  CONSTRAINT fk_idUzivatele FOREIGN KEY (idUzivatele) REFERENCES UZIVATELE(idUzivatele),
  CONSTRAINT uc_SkupinyUzivatele UNIQUE (idSkupiny,idUzivatele)
);

--drop table udalosti_uzivatelu;
CREATE TABLE UDALOSTI_UZIVATELU (
  idUdalosti number(4)  CONSTRAINT nn_idUdalostiUU NOT NULL,
  idUzivatele number(4) CONSTRAINT nn_idUzivateleUU NOT NULL,
  CONSTRAINT fk_UdalostiUU FOREIGN KEY (idUdalosti) REFERENCES UDALOSTI(idUdalosti),
  CONSTRAINT fk_UzivateleUU FOREIGN KEY (idUzivatele) REFERENCES UZIVATELE(idUzivatele),
  CONSTRAINT uc_UdalUziv UNIQUE (idUdalosti,idUzivatele)
);

--drop table pripominky
CREATE TABLE PRIPOMINKY (
  idPripominky number(4) CONSTRAINT nn_idPripominky NOT NULL CONSTRAINT pk_idPripominky PRIMARY KEY,
  idUdalosti number(4) CONSTRAINT nn_idUdalostiP NOT NULL,
  idUzivatele number(4) CONSTRAINT nn_idUdzivateleP NOT NULL,
  typ_pripominky number(4) ,
  cas_pred_udalosti DATE,
  opakovani_po_intervalu number(4) ,
  aktivni number(1),
  CONSTRAINT fk_idUdalostiP FOREIGN KEY (idUdalosti) REFERENCES UDALOSTI(idUdalosti),
  CONSTRAINT fk_idUzivateleP FOREIGN KEY (idUzivatele) REFERENCES UZIVATELE(idUzivatele)
);

--autoincrement pripominky.idPripominky
CREATE SEQUENCE seq_pripominky
INCREMENT BY 1
START WITH 1
NOMAXVALUE
MINVALUE 0;
 
CREATE TRIGGER pripominky
BEFORE INSERT ON pripominky
FOR EACH ROW
begin
  select seq_pripominky.nextval into :new.idPripominky from dual;
end;


grant all on uzivatele to nachato1;
grant all on skupiny to nachato1;
grant all on udalosti to nachato1;
grant all on skupiny_uzivatelu to nachato1;
grant all on udalosti_uzivatelu to nachato1;
grant all on pripominky to nachato1;
