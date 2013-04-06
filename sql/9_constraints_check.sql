--1.1

SET AUTOTRACE ON

spool c:\temp\planovac.txt

Insert into DUPALPE1.UDALOST (NAZEV,IDVLASTNIKA,IDSKUPINY,ZACATEK,KONEC,VEREJNA,IDMISTAKONANI,POPIS) values ('nisl','1115','82',to_date('29.03.2014 04:05:28','DD.MM.YYYY HH24:MI:SS'),to_date('28.03.2014 06:00:40','DD.MM.YYYY HH24:MI:SS'),'1','1294',null);


spool off
--vypis

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
Error starting at line 6 in command:
Insert into DUPALPE1.UDALOST (NAZEV,IDVLASTNIKA,IDSKUPINY,ZACATEK,KONEC,VEREJNA,IDMISTAKONANI,POPIS) values ('nisl','1115','82',to_date('29.03.2014 04:05:28','DD.MM.YYYY HH24:MI:SS'),to_date('28.03.2014 06:00:40','DD.MM.YYYY HH24:MI:SS'),'1','1294',null)
Error report:
SQL Error: ORA-02290: kontrolní omezení (DUPALPE1.CAS_CHECK) porušeno
02290. 00000 -  "check constraint (%s.%s) violated"
*Cause:    The values being inserted do not satisfy the named check
           
*Action:   do not insert values that violate the constraint.
 
------------------------------------------------------------------------------------
| Id  | Operation                | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------
|   0 | INSERT STATEMENT         |         |     1 |    43 |     1   (0)| 00:00:01 |
|   1 |  LOAD TABLE CONVENTIONAL | UDALOST |       |       |            |          |
------------------------------------------------------------------------------------

Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.


--1.2



Insert into DUPALPE1.SKUPINA (NAZEV,HESLOPROPRIDANI,POPIS) values ('interdum','Nulla','sodales purus, in molestie tortor');


-- vypis 

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Error starting at line 8 in command:
Insert into DUPALPE1.SKUPINA (NAZEV,HESLOPROPRIDANI,POPIS) values ('interdum','Nulla','sodales purus, in molestie tortor')
Error report:
SQL Error: ORA-01400: do ("DUPALPE1"."SKUPINA"."IDVEDOUCIHO") nelze vložit hodnotu NULL
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    
*Action:
 
------------------------------------------------------------------------------------
| Id  | Operation                | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------
|   0 | INSERT STATEMENT         |         |     1 |    58 |     1   (0)| 00:00:01 |
|   1 |  LOAD TABLE CONVENTIONAL | SKUPINA |       |       |            |          |
------------------------------------------------------------------------------------

Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.

-- 1.3


Insert into DUPALPE1.SKUPINA (NAZEV,HESLOPROPRIDANI,IDVEDOUCIHO,POPIS) values ('interdum','Nu','839','sodales purus, in molestie tortor');


-- vypis 

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Error starting at line 10 in command:
Insert into DUPALPE1.SKUPINA (NAZEV,HESLOPROPRIDANI,IDVEDOUCIHO,POPIS) values ('interdum','Nu','839','sodales purus, in molestie tortor')
Error report:
SQL Error: ORA-02290: kontrolní omezení (DUPALPE1.SKUPINA_HESLO_KONTROLA) porušeno
02290. 00000 -  "check constraint (%s.%s) violated"
*Cause:    The values being inserted do not satisfy the named check
           
*Action:   do not insert values that violate the constraint.
 
------------------------------------------------------------------------------------
| Id  | Operation                | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------
|   0 | INSERT STATEMENT         |         |     1 |    58 |     1   (0)| 00:00:01 |
|   1 |  LOAD TABLE CONVENTIONAL | SKUPINA |       |       |            |          |
------------------------------------------------------------------------------------

Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.

-- 1.4


Insert into DUPALPE1.UZIVATEL (EMAIL,JMENO,PRIJMENI,HESLO,POVOLEN,ROLE,DATUMZALOZENI,DATUMPOSLEDNIPRIHLASENI,TELEFON,IDADRESY) values ('nec.diam.Duis@Duiselementum.co.uk','Jackson','Nelson','tur','1','user',null,null,'1-363-451-3017','1247');

-- vypis

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Error starting at line 14 in command:
Insert into DUPALPE1.UZIVATEL (EMAIL,JMENO,PRIJMENI,HESLO,POVOLEN,ROLE,DATUMZALOZENI,DATUMPOSLEDNIPRIHLASENI,TELEFON,IDADRESY) values ('nec.diam.Duis@Duiselementum.co.uk','Jackson','Nelson','tur','1','user',null,null,'1-363-451-3017','1247')
Error report:
SQL Error: ORA-02290: kontrolní omezení (DUPALPE1.UZIVATEL_HESLO_KONTROLA) porušeno
02290. 00000 -  "check constraint (%s.%s) violated"
*Cause:    The values being inserted do not satisfy the named check
           
*Action:   do not insert values that violate the constraint.
 
-------------------------------------------------------------------------------------
| Id  | Operation                | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------
|   0 | INSERT STATEMENT         |          |     1 |    84 |     1   (0)| 00:00:01 |
|   1 |  LOAD TABLE CONVENTIONAL | UZIVATEL |       |       |            |          |
-------------------------------------------------------------------------------------

Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.

-- 2.1

update udalosti_uzivatelu set casupominky = '10.10.2019' where idudalosti = 945 and iduzivatele = 1110;

-- vypis

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
Error starting at line 13 in command:
update udalosti_uzivatelu set casupominky = '10.10.2019' where idudalosti = 945 and iduzivatele = 1110
Error report:
SQL Error: ORA-20000: Připomínka musí začít před začátkem události!
ORA-06512: na "DUPALPE1.KONTROLA_CAS_PRIPOMINKA", line 8
ORA-06512: na "DUPALPE1.KONTROLA_CAS_PRIPOMINKA", line 2
ORA-04088: chyba během provádění triggeru 'DUPALPE1.KONTROLA_CAS_PRIPOMINKA'
20000. 00000 -  "%s"
*Cause:    The stored procedure 'raise_application_error'
           was called which causes this error to be generated.
*Action:   Correct the problem as described in the error message or contact
           the application administrator or DBA for more information.
Plan hash value: 3674993880
 
---------------------------------------------------------------------------------------------------
| Id  | Operation                    | Name               | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------------
|   0 | UPDATE STATEMENT             |                    |     1 |    25 |     2   (0)| 00:00:01 |
|   1 |  UPDATE                      | UDALOSTI_UZIVATELU |       |       |            |          |
|   2 |   TABLE ACCESS BY INDEX ROWID| UDALOSTI_UZIVATELU |     1 |    25 |     2   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN         | UC_UDALUZIV        |     1 |       |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("IDUDALOSTI"=945 AND "IDUZIVATELE"=1110)

Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.

-- 2.2

declare 
ide number;

begin

   for i in 101..200 loop
ide:=i+625;
insert into DUPALPE1.SKUPINY_UZIVATELU (IDSKUPINY,IDUZIVATELE) values ('355',ide);

  end loop;
end;

-- vypis


Error starting at line 22 in command:
declare 
ide number;

begin

   for i in 101..200 loop
ide:=i+625;
insert into DUPALPE1.SKUPINY_UZIVATELU (IDSKUPINY,IDUZIVATELE) values ('355',ide);

  end loop;
end;
Error report:
ORA-20000: Skupina nemůže mít více jak 150 členů!
ORA-06512: na "DUPALPE1.KONTROLA_SKUPINY", line 9
ORA-06512: na "DUPALPE1.KONTROLA_SKUPINY", line 2
ORA-04088: chyba během provádění triggeru 'DUPALPE1.KONTROLA_SKUPINY'
ORA-06512: na line 8
20000. 00000 -  "%s"
*Cause:    The stored procedure 'raise_application_error'
           was called which causes this error to be generated.
*Action:   Correct the problem as described in the error message or contact
           the application administrator or DBA for more information.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.