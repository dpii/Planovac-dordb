--Urci pocet udalosti v dane skupine uzivatelu a danem casovem rozmezi

select count(*) from udalost ud, udalosti_uzivatelu uz, skupiny_uzivatelu su
where su.idUzivatele = uz.iduzivatele
and ud.idUdalosti = uz.idUdalosti
and ud.zacatek > '10/10/2013' and ud.konec < '10/10/2015'
and su.idSkupiny = '154';

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
  COUNT(*)
----------
         4 

Plan hash value: 545166358
 
-----------------------------------------------------------------------------------------------------
| Id  | Operation                     | Name                | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |                     |     1 |    36 |     5   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE               |                     |     1 |    36 |            |          |
|   2 |   NESTED LOOPS                |                     |       |       |            |          |
|   3 |    NESTED LOOPS               |                     |     3 |   108 |     5   (0)| 00:00:01 |
|   4 |     NESTED LOOPS              |                     |     3 |    48 |     2   (0)| 00:00:01 |
|   5 |      INDEX FAST FULL SCAN     | UC_UDALUZIV         |   499 |  3992 |     2   (0)| 00:00:01 |
|*  6 |      INDEX UNIQUE SCAN        | UC_SKUPINYUZIVATELE |     1 |     8 |     0   (0)| 00:00:01 |
|*  7 |     INDEX UNIQUE SCAN         | PK_IDUDALOSTI       |     1 |       |     0   (0)| 00:00:01 |
|*  8 |    TABLE ACCESS BY INDEX ROWID| UDALOST             |     1 |    20 |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   6 - access("SU"."IDSKUPINY"=154 AND "SU"."IDUZIVATELE"="UZ"."IDUZIVATELE")
   7 - access("UD"."IDUDALOSTI"="UZ"."IDUDALOSTI")
   8 - filter("UD"."ZACATEK">TO_DATE(' 2013-10-10 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND 
              "UD"."KONEC"<TO_DATE(' 2015-10-10 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))


--Vypocte prumerny pocet pripominek na uzivatele

select avg(count(*)) as Prumery_pocet_pripominek_uziv from udalosti_uzivatelu uu where uu.aktivni = '1'  group by uu.iduzivatele;

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
PRUMERY_POCET_PRIPOMINEK_UZIV
-----------------------------
                  1.574132492 

Plan hash value: 2999448446
 
------------------------------------------------------------------------------------------
| Id  | Operation           | Name               | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |                    |     1 |     7 |     4  (25)| 00:00:01 |
|   1 |  SORT AGGREGATE     |                    |     1 |     7 |     4  (25)| 00:00:01 |
|   2 |   HASH GROUP BY     |                    |     1 |     7 |     4  (25)| 00:00:01 |
|*  3 |    TABLE ACCESS FULL| UDALOSTI_UZIVATELU |   499 |  3493 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - filter("UU"."AKTIVNI"=1)


--Urci kolik lidi ma nastavenou pripominku na urcitou udalost

select idUdalosti, count(*) as pocet_pripominek from udalosti_uzivatelu where aktivni = '1' and idUdalosti = 849 group by idUdalosti order by pocet_pripominek desc;

Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
IDUDALOSTI POCET_PRIPOMINEK
---------- ----------------
       849                5 

Plan hash value: 3149387499
 
----------------------------------------------------------------------------------------------------
| Id  | Operation                     | Name               | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |                    |     1 |     7 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY                |                    |     1 |     7 |     4  (25)| 00:00:01 |
|   2 |   SORT GROUP BY NOSORT        |                    |     1 |     7 |     4  (25)| 00:00:01 |
|*  3 |    TABLE ACCESS BY INDEX ROWID| UDALOSTI_UZIVATELU |     2 |    14 |     3   (0)| 00:00:01 |
|*  4 |     INDEX RANGE SCAN          | UC_UDALUZIV        |     2 |       |     2   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - filter("AKTIVNI"=1)
   4 - access("IDUDALOSTI"=849)



--Vyhleda 4 nejblizsi udalosti pro konkretniho uzivatele

SELECT ud.nazev, ud.zacatek, ud.konec, me.nazevmesta FROM udalosti_uzivatelu uz, udalost ud, adresa ad, mesto me where me.psc = ad.psc and ud.idmistakonani = ad.idadresy and uz.idudalosti = ud.idudalosti and uz.iduzivatele = '674' and rownum < 5 order by ud.zacatek;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
NAZEV                          ZACATEK  KONEC    NAZEVMESTA                   
------------------------------ -------- -------- ------------------------------
Pellentesque                   29.03.14 29.03.14 Sandy Springs                  
dolor.                         12.04.14 12.04.14 Grand Forks                    
gravida.                       13.04.14 13.04.14 Oneida                         
at                             16.04.14 16.04.14 Melrose                        

Plan hash value: 144155093
 
-------------------------------------------------------------------------------------------------
| Id  | Operation                        | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                 |              |     2 |   126 |     8  (13)| 00:00:01 |
|   1 |  SORT ORDER BY                   |              |     2 |   126 |     8  (13)| 00:00:01 |
|*  2 |   COUNT STOPKEY                  |              |       |       |            |          |
|   3 |    NESTED LOOPS                  |              |       |       |            |          |
|   4 |     NESTED LOOPS                 |              |     2 |   126 |     7   (0)| 00:00:01 |
|   5 |      NESTED LOOPS                |              |     2 |    96 |     5   (0)| 00:00:01 |
|   6 |       NESTED LOOPS               |              |     2 |    78 |     3   (0)| 00:00:01 |
|   7 |        TABLE ACCESS FULL         | UDALOST      |   500 | 15500 |     3   (0)| 00:00:01 |
|*  8 |        INDEX UNIQUE SCAN         | UC_UDALUZIV  |     1 |     8 |     0   (0)| 00:00:01 |
|   9 |       TABLE ACCESS BY INDEX ROWID| ADRESA       |     1 |     9 |     1   (0)| 00:00:01 |
|* 10 |        INDEX UNIQUE SCAN         | PK_IDADRESYA |     1 |       |     0   (0)| 00:00:01 |
|* 11 |      INDEX UNIQUE SCAN           | PK_PSCA      |     1 |       |     0   (0)| 00:00:01 |
|  12 |     TABLE ACCESS BY INDEX ROWID  | MESTO        |     1 |    15 |     1   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - filter(ROWNUM<5)
   8 - access("UZ"."IDUDALOSTI"="UD"."IDUDALOSTI" AND "UZ"."IDUZIVATELE"=674)
  10 - access("UD"."IDMISTAKONANI"="AD"."IDADRESY")
  11 - access("ME"."PSC"="AD"."PSC")



--Vypise u kazdeho mesta pocet udalosti, ktere se tam konaly

select mesto.nazevmesta, count(idUdalosti) as pocet_udalosti
from udalost, adresa, mesto
where adresa.idadresy = udalost.idmistakonani and mesto.psc = adresa.psc
group by mesto.nazevmesta
order by count(udalost.idudalosti) desc;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
NAZEVMESTA                     POCET_UDALOSTI
------------------------------ --------------
Port Washington                            19 
Ogdensburg                                 16 
Effingham                                  15 
Sitka                                      14 
Atlanta                                    13 
Winooski                                   12 
Lynchburg                                  11 
Sandy Springs                              11 
Binghamton                                 10 
Oneida                                     10 
Plainfield                                 10 
Lawndale                                   10 
New Binghamton                              9 
Sturgis                                     9 
Melrose                                     9 
Fitchburg                                   9 
West Springfield                            9 
San Francisco                               8 
Nenana                                      8 
New Minnetonka                              8 
Newport News                                7 
Fairbanks                                   7 
Uniontown                                   7 
Rehoboth Beach                              7 
Glen Cove                                   7 
Simi Valley                                 7 
Lynn                                        6 
Olean                                       6 
San Antonio                                 6 
Joliet                                      6 
Dodge City                                  6 
Minnetonka                                  6 
Enfield                                     5 
La Ca?ada Flintridge                        5 
North Adams                                 5 
Fallon                                      5 
Monterey                                    5 
Athens                                      5 
New Enfield                                 5 
Davis                                       5 
Easthampton                                 5 
Texarkana                                   5 
Chico                                       5 
Valparaiso                                  5 
El Paso                                     5 
Agat                                        5 
Medford                                     4 
New Castle                                  4 
La Habra Heights                            4 
Alameda                                     4 
Holyoke                                     4 
Frisco                                      4 
Ventura                                     4 
Grand Forks                                 4 
Marietta                                    4 
Aberdeen                                    4 
Fredericksburg                              4 
Irwindale                                   4 
Wisconsin Rapids                            3 
Montpelier                                  3 
Niagara Falls                               3 
Guánica                                     3 
Raleigh                                     3 
Charlotte Amalie                            3 
Jeffersontown                               3 
Idaho Springs                               3 
Bentonville                                 3 
Warwick                                     3 
Concord                                     3 
Shreveport                                  3 
Kenosha                                     3 
Christiansted                               3 
Lomita                                      3 
Miami Gardens                               3 
Sonoma                                      3 
Hayward                                     2 
Twin Falls                                  2 
Bartlesville                                2 
Hermitage                                   2 
Chandler                                    2 
Wheeling                                    2 
DeKalb                                      2 
Phoenix                                     2 
Macon                                       2 
Harrisburg                                  2 
Gulfport                                    2 
Columbus                                    2 
Ketchikan                                   2 
New Chico                                   2 
Idabel                                      1 
Missoula                                    1 
Crown Point                                 1 
Old Minnetonka                              1 
Wichita                                     1 

 94 rows selected 

Plan hash value: 1339327940
 
-------------------------------------------------------------------------------------------------
| Id  | Operation                        | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                 |              |     1 |    69 |     5  (40)| 00:00:01 |
|   1 |  SORT ORDER BY                   |              |     1 |    69 |     5  (40)| 00:00:01 |
|   2 |   HASH GROUP BY                  |              |     1 |    69 |     5  (40)| 00:00:01 |
|   3 |    NESTED LOOPS                  |              |       |       |            |          |
|   4 |     NESTED LOOPS                 |              |     1 |    69 |     3   (0)| 00:00:01 |
|   5 |      NESTED LOOPS                |              |     1 |    39 |     3   (0)| 00:00:01 |
|   6 |       TABLE ACCESS FULL          | UDALOST      |     1 |    13 |     3   (0)| 00:00:01 |
|   7 |       TABLE ACCESS BY INDEX ROWID| ADRESA       |     1 |    26 |     0   (0)| 00:00:01 |
|*  8 |        INDEX UNIQUE SCAN         | PK_IDADRESYA |     1 |       |     0   (0)| 00:00:01 |
|*  9 |      INDEX UNIQUE SCAN           | PK_PSCA      |     1 |       |     0   (0)| 00:00:01 |
|  10 |     TABLE ACCESS BY INDEX ROWID  | MESTO        |     1 |    30 |     0   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   8 - access("ADRESA"."IDADRESY"="UDALOST"."IDMISTAKONANI")
   9 - access("MESTO"."PSC"="ADRESA"."PSC")

--Pro kazde mesto secte vsechny zucastneni uzivatelu na udalosti poradane v danem meste

select mesto.nazevmesta, count(idUzivatele) as pocet_navstevniku
from udalost, adresa, mesto, udalosti_uzivatelu
where adresa.idadresy = udalost.idmistakonani and mesto.psc = adresa.psc and udalosti_uzivatelu.idudalosti = udalost.idudalosti
group by mesto.nazevmesta
order by count(udalost.idudalosti) desc;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
NAZEVMESTA                     POCET_NAVSTEVNIKU
------------------------------ -----------------
Sitka                                         20 
Port Washington                               19 
Ogdensburg                                    18 
Lynchburg                                     18 
Sandy Springs                                 15 
Atlanta                                       15 
Winooski                                      15 
Nenana                                        13 
Lawndale                                      13 
New Minnetonka                                12 
Oneida                                        12 
Effingham                                     12 
New Binghamton                                10 
Sturgis                                       10 
Fairbanks                                     10 
San Antonio                                   10 
Binghamton                                     9 
Jeffersontown                                  9 
Marietta                                       9 
Fitchburg                                      9 
Melrose                                        9 
Agat                                           9 
Uniontown                                      8 
Monterey                                       8 
West Springfield                               7 
Plainfield                                     7 
Athens                                         7 
Newport News                                   7 
La Ca?ada Flintridge                           6 
Lynn                                           6 
San Francisco                                  6 
El Paso                                        6 
Simi Valley                                    6 
Chico                                          6 
Glen Cove                                      6 
Minnetonka                                     6 
Sonoma                                         5 
Easthampton                                    5 
Aberdeen                                       5 
Irwindale                                      5 
Dodge City                                     5 
Concord                                        5 
Medford                                        4 
New Castle                                     4 
Rehoboth Beach                                 4 
New Enfield                                    4 
Christiansted                                  4 
Frisco                                         4 
Holyoke                                        4 
Enfield                                        3 
Twin Falls                                     3 
North Adams                                    3 
La Habra Heights                               3 
Fredericksburg                                 3 
Texarkana                                      3 
Grand Forks                                    3 
Lomita                                         3 
Ventura                                        3 
Hayward                                        2 
Valparaiso                                     2 
Fallon                                         2 
Guánica                                        2 
Hermitage                                      2 
Raleigh                                        2 
Charlotte Amalie                               2 
Olean                                          2 
Chandler                                       2 
Davis                                          2 
Idaho Springs                                  2 
Bentonville                                    2 
Warwick                                        2 
Joliet                                         2 
Macon                                          2 
Shreveport                                     2 
Kenosha                                        2 
Ketchikan                                      2 
Bartlesville                                   2 
Wisconsin Rapids                               1 
Idabel                                         1 
Missoula                                       1 
Miami Gardens                                  1 
Phoenix                                        1 
Gulfport                                       1 
Columbus                                       1 
Alameda                                        1 

 85 rows selected 

Plan hash value: 1705187958
 
------------------------------------------------------------------------------------------------
| Id  | Operation                        | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                 |             |    96 |  3456 |    16  (25)| 00:00:01 |
|   1 |  SORT ORDER BY                   |             |    96 |  3456 |    16  (25)| 00:00:01 |
|   2 |   HASH GROUP BY                  |             |    96 |  3456 |    16  (25)| 00:00:01 |
|*  3 |    HASH JOIN                     |             |   499 | 17964 |    14  (15)| 00:00:01 |
|   4 |     INDEX FAST FULL SCAN         | UC_UDALUZIV |   499 |  1996 |     2   (0)| 00:00:01 |
|*  5 |     HASH JOIN                    |             |   500 | 16000 |    12  (17)| 00:00:01 |
|   6 |      TABLE ACCESS FULL           | UDALOST     |   500 |  4000 |     3   (0)| 00:00:01 |
|   7 |      MERGE JOIN                  |             |   515 | 12360 |     8  (13)| 00:00:01 |
|   8 |       TABLE ACCESS BY INDEX ROWID| MESTO       |   102 |  1530 |     2   (0)| 00:00:01 |
|   9 |        INDEX FULL SCAN           | PK_PSCA     |   102 |       |     1   (0)| 00:00:01 |
|* 10 |       SORT JOIN                  |             |   515 |  4635 |     6  (17)| 00:00:01 |
|  11 |        TABLE ACCESS FULL         | ADRESA      |   515 |  4635 |     5   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("UDALOSTI_UZIVATELU"."IDUDALOSTI"="UDALOST"."IDUDALOSTI")
   5 - access("ADRESA"."IDADRESY"="UDALOST"."IDMISTAKONANI")
  10 - access("MESTO"."PSC"="ADRESA"."PSC")
       filter("MESTO"."PSC"="ADRESA"."PSC")