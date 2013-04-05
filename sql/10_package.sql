--def package
create or replace
package planovac_api as
procedure nastavUpo(idUda number, casUpominky date, intervalOpakovani number);
function zjistiDostupnost (idskup number, zac date, kon date) return number;

end planovac_api;

--logika package
create or replace
package body planovac_api as
casU date;
casPred date;
pocet number;

procedure nastavUpo (idUda number, casUpominky date, intervalOpakovani number) IS

BEGIN
	
  select casUpominky into casU from udalost where idUdalosti = idUda;
  
  casPred := casU - 1;
  
  update udalosti_uzivatelu set casUpominky = casPred, intervalOpakovani = 1 where idUdalosti = idUda;
  
END nastavUpo;


function zjistiDostupnost (idskup number, zac date, kon date) return number IS

BEGIN
	
	SELECT count(uu.idUzivatele) as pocet_kolizi into pocet from udalost ud, udalosti_uzivatelu uu where ud.idSkupiny = idskup and ud.zacatek > zac and ud.konec < kon and ud.idUdalosti = uu.idUzivatele;
 
  return pocet;
  
END zjistiDostupnost;

end planovac_api;