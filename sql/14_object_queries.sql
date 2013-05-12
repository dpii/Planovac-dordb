select count(*) from obj_udalost ud, obj_udalost_uzivatele uz, obj_skupina_uzivatele su
where su.uzivatel.iduzivatele = uz.uzivatel.iduzivatele
and ud.idudalosti = uz.udalost.idudalosti
and ud.zacatek > '10/10/2013' and ud.konec < '10/10/2015'
and su.skupina.idSkupiny = '154';



Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
  COUNT(*)
----------
         4 

Plan hash value: 1220233909
 
-------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name                  | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                       |     1 |   163 |    33   (7)| 00:00:01 |
|   1 |  SORT AGGREGATE                     |                       |     1 |   163 |            |          |
|*  2 |   HASH JOIN                         |                       |     2 |   326 |    33   (7)| 00:00:01 |
|   3 |    NESTED LOOPS                     |                       |       |       |            |          |
|   4 |     NESTED LOOPS                    |                       |     2 |   264 |    27   (4)| 00:00:01 |
|*  5 |      FILTER                         |                       |       |       |            |          |
|*  6 |       HASH JOIN RIGHT OUTER         |                       |     2 |   218 |    25   (4)| 00:00:01 |
|   7 |        TABLE ACCESS FULL            | OBJ_UZIVATEL          |   500 | 11500 |     5   (0)| 00:00:01 |
|   8 |        MERGE JOIN CARTESIAN         |                       |   821 | 70606 |    20   (5)| 00:00:01 |
|   9 |         NESTED LOOPS                |                       |       |       |            |          |
|  10 |          NESTED LOOPS               |                       |     2 |   132 |    11  (10)| 00:00:01 |
|* 11 |           HASH JOIN                 |                       |     2 |    86 |     9  (12)| 00:00:01 |
|* 12 |            TABLE ACCESS FULL        | OBJ_SKUPINA           |     1 |    23 |     5   (0)| 00:00:01 |
|  13 |            TABLE ACCESS FULL        | OBJ_SKUPINA_UZIVATELE |   500 | 10000 |     3   (0)| 00:00:01 |
|* 14 |           INDEX UNIQUE SCAN         | SYS_C0057255          |     1 |       |     0   (0)| 00:00:01 |
|  15 |          TABLE ACCESS BY INDEX ROWID| OBJ_UZIVATEL          |     1 |    23 |     1   (0)| 00:00:01 |
|  16 |         BUFFER SORT                 |                       |   499 |  9980 |    19   (6)| 00:00:01 |
|  17 |          TABLE ACCESS FULL          | OBJ_UDALOST_UZIVATELE |   499 |  9980 |     5   (0)| 00:00:01 |
|* 18 |      INDEX UNIQUE SCAN              | SYS_C0057259          |     1 |       |     0   (0)| 00:00:01 |
|  19 |     TABLE ACCESS BY INDEX ROWID     | OBJ_UDALOST           |     1 |    23 |     1   (0)| 00:00:01 |
|* 20 |    TABLE ACCESS FULL                | OBJ_UDALOST           |   500 | 15500 |     5   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("UD"."IDUDALOSTI"="IDUDALOSTI")
   5 - filter("IDUZIVATELE"="IDUZIVATELE")
   6 - access("P000011$"."SYS_NC_OID$"(+)="UZ"."UZIVATEL")
  11 - access("P000005$"."SYS_NC_OID$"="SU"."SKUPINA")
  12 - filter("IDSKUPINY"=154)
  14 - access("P000009$"."SYS_NC_OID$"="SU"."UZIVATEL")
  18 - access("P000007$"."SYS_NC_OID$"="UZ"."UDALOST")
  20 - filter("UD"."ZACATEK">TO_DATE(' 2013-10-10 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND 
              "UD"."KONEC"<TO_DATE(' 2015-10-10 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))


              -------------
              
              
select avg(count(ud.udalost.idUdalosti)) as Prumery_pocet_pripominek_uziv from obj_udalost_uzivatele ud where ud.aktivni = '1' group by ud.uzivatel;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
PRUMERY_POCET_PRIPOMINEK_UZIV
-----------------------------
                  1.574132492 

Plan hash value: 1150664195
 
----------------------------------------------------------------------------------------------
| Id  | Operation            | Name                  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |                       |     1 |    56 |    12  (17)| 00:00:01 |
|   1 |  SORT AGGREGATE      |                       |     1 |    56 |    12  (17)| 00:00:01 |
|   2 |   SORT GROUP BY      |                       |     1 |    56 |    12  (17)| 00:00:01 |
|*  3 |    HASH JOIN OUTER   |                       |   499 | 27944 |    11  (10)| 00:00:01 |
|*  4 |     TABLE ACCESS FULL| OBJ_UDALOST_UZIVATELE |   499 | 16467 |     5   (0)| 00:00:01 |
|   5 |     TABLE ACCESS FULL| OBJ_UDALOST           |   500 | 11500 |     5   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("P000003$"."SYS_NC_OID$"(+)="UD"."UDALOST")
   4 - filter("UD"."AKTIVNI"=1)
   
   
   --------

select ud.udalost.idUdalosti, count(*) as pocet_pripominek from obj_udalost_uzivatele ud where aktivni = '1' and ud.udalost.idUdalosti = 849 group by ud.udalost.idUdalosti order by pocet_pripominek desc;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
UDALOST.IDUDALOSTI POCET_PRIPOMINEK
------------------ ----------------
               849                5 

Plan hash value: 1440074333
 
----------------------------------------------------------------------------------------------
| Id  | Operation            | Name                  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |                       |     2 |    92 |    12  (17)| 00:00:01 |
|   1 |  SORT ORDER BY       |                       |     2 |    92 |    12  (17)| 00:00:01 |
|   2 |   HASH GROUP BY      |                       |     2 |    92 |    12  (17)| 00:00:01 |
|*  3 |    HASH JOIN         |                       |     2 |    92 |    11  (10)| 00:00:01 |
|*  4 |     TABLE ACCESS FULL| OBJ_UDALOST           |     1 |    23 |     5   (0)| 00:00:01 |
|*  5 |     TABLE ACCESS FULL| OBJ_UDALOST_UZIVATELE |   499 | 11477 |     5   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("P000003$"."SYS_NC_OID$"="UD"."UDALOST")
   4 - filter("IDUDALOSTI"=849)
   5 - filter("AKTIVNI"=1)


-----
   
SELECT ud.nazev, ud.zacatek, ud.konec, me.nazevmesta FROM obj_udalost_uzivatele uz, obj_udalost ud, obj_adresa ad, obj_mesto me where me.psc = ad.mesto.psc and ud.misto.idadresy = ad.idadresy and uz.udalost.idudalosti = ud.idudalosti and uz.uzivatel.iduzivatele = '674' and rownum < 5 order by ud.zacatek;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
NAZEV                          ZACATEK  KONEC    NAZEVMESTA                             
------------------------------ -------- -------- ----------------------------------------
Pellentesque                   29.03.14 29.03.14 Sandy Springs                            
dolor.                         12.04.14 12.04.14 Grand Forks                              
gravida.                       13.04.14 13.04.14 Oneida                                   
at                             16.04.14 16.04.14 Melrose                                  

Plan hash value: 1711922977
 
---------------------------------------------------------------------------------------------------------------
| Id  | Operation                             | Name                  | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                      |                       |     2 |   472 |    31  (10)| 00:00:01 |
|   1 |  SORT ORDER BY                        |                       |     2 |   472 |    31  (10)| 00:00:01 |
|*  2 |   COUNT STOPKEY                       |                       |       |       |            |          |
|   3 |    NESTED LOOPS                       |                       |       |       |            |          |
|   4 |     NESTED LOOPS                      |                       |     2 |   472 |    30   (7)| 00:00:01 |
|   5 |      NESTED LOOPS                     |                       |     2 |   394 |    28   (8)| 00:00:01 |
|*  6 |       HASH JOIN                       |                       |     2 |   340 |    26   (8)| 00:00:01 |
|   7 |        NESTED LOOPS                   |                       |       |       |            |          |
|   8 |         NESTED LOOPS                  |                       |     2 |   294 |    20   (5)| 00:00:01 |
|*  9 |          HASH JOIN                    |                       |     2 |   248 |    18   (6)| 00:00:01 |
|  10 |           NESTED LOOPS                |                       |       |       |            |          |
|  11 |            NESTED LOOPS               |                       |     2 |   132 |    13   (8)| 00:00:01 |
|* 12 |             HASH JOIN                 |                       |     2 |    86 |    11  (10)| 00:00:01 |
|* 13 |              TABLE ACCESS FULL        | OBJ_UZIVATEL          |     1 |    23 |     5   (0)| 00:00:01 |
|  14 |              TABLE ACCESS FULL        | OBJ_UDALOST_UZIVATELE |   499 |  9980 |     5   (0)| 00:00:01 |
|* 15 |             INDEX UNIQUE SCAN         | SYS_C0057259          |     1 |       |     0   (0)| 00:00:01 |
|  16 |            TABLE ACCESS BY INDEX ROWID| OBJ_UDALOST           |     1 |    23 |     1   (0)| 00:00:01 |
|  17 |           TABLE ACCESS FULL           | OBJ_UDALOST           |   500 | 29000 |     5   (0)| 00:00:01 |
|* 18 |          INDEX UNIQUE SCAN            | SYS_C0057253          |     1 |       |     0   (0)| 00:00:01 |
|  19 |         TABLE ACCESS BY INDEX ROWID   | OBJ_ADRESA            |     1 |    23 |     1   (0)| 00:00:01 |
|  20 |        TABLE ACCESS FULL              | OBJ_ADRESA            |   515 | 11845 |     5   (0)| 00:00:01 |
|  21 |       TABLE ACCESS BY INDEX ROWID     | OBJ_MESTO             |     1 |    27 |     1   (0)| 00:00:01 |
|* 22 |        INDEX UNIQUE SCAN              | SYS_C0057252          |     1 |       |     0   (0)| 00:00:01 |
|* 23 |      INDEX UNIQUE SCAN                | SYS_C0057251          |     1 |       |     0   (0)| 00:00:01 |
|  24 |     TABLE ACCESS BY INDEX ROWID       | OBJ_MESTO             |     1 |    39 |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - filter(ROWNUM<5)
   6 - access("AD"."IDADRESY"="IDADRESY")
   9 - access("UD"."IDUDALOSTI"="IDUDALOSTI")
  12 - access("P000006$"."SYS_NC_OID$"="UZ"."UZIVATEL")
  13 - filter("IDUZIVATELE"=674)
  15 - access("P000008$"."SYS_NC_OID$"="UZ"."UDALOST")
  18 - access("P000010$"."SYS_NC_OID$"="UD"."MISTO")
  22 - access("P000012$"."SYS_NC_OID$"="AD"."MESTO")
  23 - access("ME"."PSC"="PSC")
 
Note
-----
   - dynamic sampling used for this statement (level=2)

   --------

select me.nazevmesta, count(ud.idUdalosti) as pocet_udalosti
from obj_udalost ud, obj_adresa ad, obj_mesto me
where ad.idadresy = ud.misto.idadresy and me.psc = ad.mesto.psc
group by me.nazevmesta
order by count(ud.idudalosti) desc;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
NAZEVMESTA                               POCET_UDALOSTI
---------------------------------------- --------------
Port Washington                                      19 
Binghamton                                           19 
Ogdensburg                                           16 
Effingham                                            15 
Minnetonka                                           15 
Sitka                                                14 
Atlanta                                              13 
Winooski                                             12 
Sandy Springs                                        11 
Lynchburg                                            11 
Enfield                                              10 
Lawndale                                             10 
Oneida                                               10 
Plainfield                                           10 
West Springfield                                      9 
Sturgis                                               9 
Melrose                                               9 
Fitchburg                                             9 
Nenana                                                8 
San Francisco                                         8 
Newport News                                          7 
Chico                                                 7 
Glen Cove                                             7 
Simi Valley                                           7 
Uniontown                                             7 
Rehoboth Beach                                        7 
Fairbanks                                             7 
Dodge City                                            6 
Olean                                                 6 
Joliet                                                6 
San Antonio                                           6 
Lynn                                                  6 
Texarkana                                             5 
Fallon                                                5 
Monterey                                              5 
Davis                                                 5 
Agat                                                  5 
Easthampton                                           5 
Athens                                                5 
La Cañada Flintridge                                  5 
El Paso                                               5 
Valparaiso                                            5 
North Adams                                           5 
Frisco                                                4 
New Castle                                            4 
Medford                                               4 
Fredericksburg                                        4 
Alameda                                               4 
Ventura                                               4 
La Habra Heights                                      4 
Marietta                                              4 
Aberdeen                                              4 
Holyoke                                               4 
Irwindale                                             4 
Grand Forks                                           4 
Sonoma                                                3 
Wisconsin Rapids                                      3 
Niagara Falls                                         3 
Guánica                                               3 
Jeffersontown                                         3 
Charlotte Amalie                                      3 
Raleigh                                               3 
Idaho Springs                                         3 
Bentonville                                           3 
Concord                                               3 
Warwick                                               3 
Shreveport                                            3 
Christiansted                                         3 
Lomita                                                3 
Kenosha                                               3 
Miami Gardens                                         3 
Montpelier                                            3 
Hayward                                               2 
DeKalb                                                2 
Bartlesville                                          2 
Hermitage                                             2 
Twin Falls                                            2 
Gulfport                                              2 
Columbus                                              2 
Ketchikan                                             2 
Wheeling                                              2 
Chandler                                              2 
Phoenix                                               2 
Harrisburg                                            2 
Macon                                                 2 
Missoula                                              1 
Crown Point                                           1 
Wichita                                               1 
Idabel                                                1 

 89 rows selected 

Plan hash value: 2601982191
 
---------------------------------------------------------------------------------------
| Id  | Operation               | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT        |             |   500 | 67500 |    25  (16)| 00:00:01 |
|   1 |  SORT ORDER BY          |             |   500 | 67500 |    25  (16)| 00:00:01 |
|   2 |   HASH GROUP BY         |             |   500 | 67500 |    25  (16)| 00:00:01 |
|*  3 |    HASH JOIN            |             |   500 | 67500 |    23   (9)| 00:00:01 |
|   4 |     TABLE ACCESS FULL   | OBJ_UDALOST |   500 | 11500 |     5   (0)| 00:00:01 |
|*  5 |     HASH JOIN           |             |   515 | 57680 |    18  (12)| 00:00:01 |
|   6 |      TABLE ACCESS FULL  | OBJ_ADRESA  |   515 | 11845 |     5   (0)| 00:00:01 |
|*  7 |      HASH JOIN          |             |   515 | 45835 |    12   (9)| 00:00:01 |
|*  8 |       HASH JOIN         |             |   102 |  6732 |     7  (15)| 00:00:01 |
|   9 |        TABLE ACCESS FULL| OBJ_MESTO   |   102 |  2754 |     3   (0)| 00:00:01 |
|  10 |        TABLE ACCESS FULL| OBJ_MESTO   |   102 |  3978 |     3   (0)| 00:00:01 |
|  11 |       TABLE ACCESS FULL | OBJ_ADRESA  |   515 | 11845 |     5   (0)| 00:00:01 |
---------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("P000007$"."SYS_NC_OID$"="UD"."MISTO")
   5 - access("AD"."IDADRESY"="IDADRESY")
   7 - access("P000005$"."SYS_NC_OID$"="AD"."MESTO")
   8 - access("ME"."PSC"="PSC")
 
Note
-----
   - dynamic sampling used for this statement (level=2)

   -------------------
   
   
select me.nazevmesta, count(uz.uzivatel.idUzivatele) as pocet_navstevniku
from obj_udalost ud, obj_adresa ad, obj_mesto me, obj_udalost_uzivatele uz
where ad.idadresy = ud.misto.idadresy and me.psc = ad.mesto.psc and uz.udalost.idudalosti = ud.idudalosti
group by me.nazevmesta
order by count(ud.idudalosti) desc;


Autotrace Enabled
Shows the execution plan as well as statistics of the statement.
NAZEVMESTA                               POCET_NAVSTEVNIKU
---------------------------------------- -----------------
Sitka                                                   20 
Port Washington                                         19 
Binghamton                                              19 
Ogdensburg                                              18 
Lynchburg                                               18 
Minnetonka                                              18 
Sandy Springs                                           15 
Atlanta                                                 15 
Winooski                                                15 
Lawndale                                                13 
Nenana                                                  13 
Effingham                                               12 
Oneida                                                  12 
Sturgis                                                 10 
Fairbanks                                               10 
San Antonio                                             10 
Jeffersontown                                            9 
Melrose                                                  9 
Marietta                                                 9 
Fitchburg                                                9 
Agat                                                     9 
Uniontown                                                8 
Monterey                                                 8 
Newport News                                             7 
Athens                                                   7 
West Springfield                                         7 
Enfield                                                  7 
Plainfield                                               7 
La Cañada Flintridge                                     6 
Simi Valley                                              6 
San Francisco                                            6 
Lynn                                                     6 
Glen Cove                                                6 
El Paso                                                  6 
Chico                                                    6 
Irwindale                                                5 
Aberdeen                                                 5 
Sonoma                                                   5 
Concord                                                  5 
Dodge City                                               5 
Easthampton                                              5 
Frisco                                                   4 
Rehoboth Beach                                           4 
Christiansted                                            4 
Holyoke                                                  4 
Medford                                                  4 
New Castle                                               4 
North Adams                                              3 
Twin Falls                                               3 
Fredericksburg                                           3 
Lomita                                                   3 
Ventura                                                  3 
Texarkana                                                3 
La Habra Heights                                         3 
Grand Forks                                              3 
Hayward                                                  2 
Bartlesville                                             2 
Hermitage                                                2 
Fallon                                                   2 
Guánica                                                  2 
Charlotte Amalie                                         2 
Olean                                                    2 
Raleigh                                                  2 
Idaho Springs                                            2 
Bentonville                                              2 
Davis                                                    2 
Chandler                                                 2 
Warwick                                                  2 
Shreveport                                               2 
Joliet                                                   2 
Macon                                                    2 
Valparaiso                                               2 
Ketchikan                                                2 
Kenosha                                                  2 
Wisconsin Rapids                                         1 
Idabel                                                   1 
Alameda                                                  1 
Miami Gardens                                            1 
Phoenix                                                  1 
Gulfport                                                 1 
Columbus                                                 1 
Missoula                                                 1 

 82 rows selected 

Plan hash value: 3308389884
 
----------------------------------------------------------------------------------------------------
| Id  | Operation                  | Name                  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT           |                       |   499 |    97K|    42  (15)| 00:00:01 |
|   1 |  SORT ORDER BY             |                       |   499 |    97K|    42  (15)| 00:00:01 |
|   2 |   HASH GROUP BY            |                       |   499 |    97K|    42  (15)| 00:00:01 |
|*  3 |    HASH JOIN RIGHT OUTER   |                       |   499 |    97K|    40  (10)| 00:00:01 |
|   4 |     TABLE ACCESS FULL      | OBJ_UZIVATEL          |   500 | 11500 |     5   (0)| 00:00:01 |
|*  5 |     HASH JOIN              |                       |   499 | 88822 |    34   (9)| 00:00:01 |
|   6 |      TABLE ACCESS FULL     | OBJ_UDALOST_UZIVATELE |   499 |  9980 |     5   (0)| 00:00:01 |
|*  7 |      HASH JOIN             |                       |   500 | 79000 |    29  (11)| 00:00:01 |
|   8 |       TABLE ACCESS FULL    | OBJ_UDALOST           |   500 | 11500 |     5   (0)| 00:00:01 |
|*  9 |       HASH JOIN            |                       |   500 | 67500 |    23   (9)| 00:00:01 |
|  10 |        TABLE ACCESS FULL   | OBJ_UDALOST           |   500 | 11500 |     5   (0)| 00:00:01 |
|* 11 |        HASH JOIN           |                       |   515 | 57680 |    18  (12)| 00:00:01 |
|  12 |         TABLE ACCESS FULL  | OBJ_ADRESA            |   515 | 11845 |     5   (0)| 00:00:01 |
|* 13 |         HASH JOIN          |                       |   515 | 45835 |    12   (9)| 00:00:01 |
|* 14 |          HASH JOIN         |                       |   102 |  6732 |     7  (15)| 00:00:01 |
|  15 |           TABLE ACCESS FULL| OBJ_MESTO             |   102 |  2754 |     3   (0)| 00:00:01 |
|  16 |           TABLE ACCESS FULL| OBJ_MESTO             |   102 |  3978 |     3   (0)| 00:00:01 |
|  17 |          TABLE ACCESS FULL | OBJ_ADRESA            |   515 | 11845 |     5   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("P000006$"."SYS_NC_OID$"(+)="UZ"."UZIVATEL")
   5 - access("P000008$"."SYS_NC_OID$"="UZ"."UDALOST")
   7 - access("UD"."IDUDALOSTI"="IDUDALOSTI")
   9 - access("P000012$"."SYS_NC_OID$"="UD"."MISTO")
  11 - access("AD"."IDADRESY"="IDADRESY")
  13 - access("P000010$"."SYS_NC_OID$"="AD"."MESTO")
  14 - access("ME"."PSC"="PSC")
 