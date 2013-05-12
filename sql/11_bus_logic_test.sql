-- zjisti  pocet konfliktu (kolik udalosti) se nachazi v zadanem casovem rozsahu v dane skupine uzivatelu


select planovac_api.zjistiDostupnost (2, '10-10-1990','10-10-2017') from dual;

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
PLANOVAC_API.ZJISTIDOSTUPNOST(2,'10-10-1990','10-10-2017')
----------------------------------------------------------
                                                         3 

Plan hash value: 1388734953
 
-----------------------------------------------------------------
| Id  | Operation        | Name | Rows  | Cost (%CPU)| Time     |
-----------------------------------------------------------------
|   0 | SELECT STATEMENT |      |     1 |     2   (0)| 00:00:01 |
|   1 |  FAST DUAL       |      |     1 |     2   (0)| 00:00:01 |
-----------------------------------------------------------------


-- testovaci query, vyhledej udalosti uzivatelu v dane skupine, v danem casovem rozsahu

SELECT * from udalost ud, udalosti_uzivatelu uu where ud.idSkupiny = 2 and ud.zacatek > '10-10-2009' and ud.konec < '10-10-2017' and ud.idUdalosti = uu.idUzivatele;

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
IDUDALOSTI NAZEV                          IDVLASTNIKA  IDSKUPINY ZACATEK  KONEC       VEREJNA IDMISTAKONANI POPIS                                                                                                                                                                                                                                                           IDUDALOSTI IDUZIVATELE TYP_PRIPOMINKY CASUPOMINKY INTERVALOPAKOVANI    AKTIVNI
---------- ------------------------------ ----------- ---------- -------- -------- ---------- ------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------- ----------- -------------- ----------- ----------------- ----------
       794 vulputate,                             948          2 16.04.14 16.04.14          1          1445                                                                                                                                                                                                                                                                        578         794              3 23.03.14                   61          1 
       794 vulputate,                             948          2 16.04.14 16.04.14          1          1445                                                                                                                                                                                                                                                                        526         794              2 15.04.14                   35          1 
       794 vulputate,                             948          2 16.04.14 16.04.14          1          1445                                                                                                                                                                                                                                                                        533         794              1 10.04.14                   21          1 

Plan hash value: 3368857852
 
-----------------------------------------------------------------------------------------
| Id  | Operation          | Name               | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |                    |     2 |   134 |     7  (15)| 00:00:01 |
|*  1 |  HASH JOIN         |                    |     2 |   134 |     7  (15)| 00:00:01 |
|*  2 |   TABLE ACCESS FULL| UDALOST            |     2 |    84 |     3   (0)| 00:00:01 |
|   3 |   TABLE ACCESS FULL| UDALOSTI_UZIVATELU |   499 | 12475 |     3   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("UD"."IDUDALOSTI"="UU"."IDUZIVATELE")
   2 - filter("UD"."IDSKUPINY"=2 AND "UD"."ZACATEK">TO_DATE(' 2009-10-10 
              00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND "UD"."KONEC"<TO_DATE(' 2017-10-10 
              00:00:00', 'syyyy-mm-dd hh24:mi:ss'))

              
              

-- nastavi upominky k dane udalosti pro vsechny uzivatele (idudalosti, s jakym predstihem, jak casto se bude opakovat)

begin
planovac_api.nastavUpo (998, 3, 2);
end;


--vypis z tabulky udalosti_uzivatelu nastaveny cas upominky, nastaveny intervalopakovani dle id udalosti 998

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
IDUDALOSTI IDUZIVATELE TYP_PRIPOMINKY CASUPOMINKY INTERVALOPAKOVANI    AKTIVNI
---------- ----------- -------------- ----------- ----------------- ----------
       998         724              4 16.04.14                    2          1 
       998         848              3 16.04.14                    2          1 
       998         905              4 16.04.14                    2          1 
       998         939              3 16.04.14                    2          1 
       998        1089              1 16.04.14                    2          1 
       998        1095              4 16.04.14                    2          1 

 6 rows selected 

Plan hash value: 218578627
 
--------------------------------------------------------------------------------------------------
| Id  | Operation                   | Name               | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                    |     2 |    50 |     3   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| UDALOSTI_UZIVATELU |     2 |    50 |     3   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | UC_UDALUZIV        |     2 |       |     2   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("IDUDALOSTI"=998)

              
Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
Unable to gather statistics please unsure user has correct access.
The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
IDUDALOSTI NAZEV                          IDVLASTNIKA  IDSKUPINY ZACATEK  KONEC       VEREJNA IDMISTAKONANI POPIS                                                                                                                                                                                                                                                         
---------- ------------------------------ ----------- ---------- -------- -------- ---------- ------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
       998 aliquet                                855        346 19.04.14 19.04.14          1          1293                                                                                                                                                                                                                                                                 

Plan hash value: 3285111761
 
---------------------------------------------------------------------------------------------
| Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |               |     1 |    42 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| UDALOST       |     1 |    42 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_IDUDALOSTI |     1 |       |     0   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("IDUDALOSTI"=998)
              
              






