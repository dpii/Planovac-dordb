-- Pro každého uživatele ukáže, kolik času zbývá do nejblížší události

select u.idUdalosti, u.nazev, u.idVlastnika, u.idskupiny,
		u.zacatek-to_date(sysdate, 'DD.MM.YYYY HH24:MI:SS') as zacina_za_x_dni_od_vlozeni from udalost u, dual;