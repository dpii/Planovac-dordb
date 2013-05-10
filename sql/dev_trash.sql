--
drop table skupiny_uzivatelu;
drop table udalosti_uzivatelu;
drop table pripominky;

ALTER TABLE skupina DROP CONSTRAINT fk_idVedouciho;

alter table udalost drop constraint fk_idSkupinyUD;
alter table udalost drop constraint fk_idVlastnikaUD;

drop table skupina;
drop table uzivatele;
drop table udalost;
drop table adresa;

drop sequence "SEQ_ADRESA";
drop sequence "SEQ_SKUPINA";
drop sequence "SEQ_UDALOST";
drop sequence "SEQ_UZIVATEL";
drop trigger ADRESA;
drop trigger SKUPINA;
drop trigger UDALOST;
drop trigger UZIVATEL;

-- !! triggery a sekvence - zustanou

--test insert uzivatele
--insert into uzivatele (login, email, heslo_hash, povolen, role) VALUES ('asd', 'asd@asd.com', '123', '1', 'user');

--poruseni integritniho omezeni not null na role
--insert into uzivatele (login, email, heslo_hash, povolen) VALUES ('asd', 'asd@asd.com', '123', '1');


alter table udalost add CONSTRAINT fk_idVlastnikaUD foreign key (idVlastnika) REFERENCES uzivatel(idUzivatele);
alter table udalost add CONSTRAINT fk_idSkupinyUD foreign key (idSkupiny) REFERENCES skupina(idSkupiny);

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