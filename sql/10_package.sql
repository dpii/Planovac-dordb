--def package
create or replace
package planovac_api as
procedure nastavUpo(idUda number, predstih number, opakovani number);
function zjistiDostupnost (idskup number, zac date, kon date) return number;

end planovac_api;
/
--logika package
create or replace
package body planovac_api as
casU date;
casPred date;
pocet number;

procedure nastavUpo (idUda number, predstih number, opakovani number) IS

BEGIN
	
  select zacatek into casU from udalost where idUdalosti = idUda;
  
  casPred := casU - predstih;
  
  update udalosti_uzivatelu set casUpominky = casPred, intervalOpakovani = opakovani where idUdalosti = idUda;
  
END nastavUpo;


function zjistiDostupnost (idskup number, zac date, kon date) return number IS

BEGIN
	
	SELECT count(uu.idUzivatele) as pocet_kolizi into pocet from udalost ud, udalosti_uzivatelu uu where ud.idSkupiny = idskup and ud.zacatek > zac and ud.konec < kon and ud.idUdalosti = uu.idUzivatele;
 
  return pocet;
  
END zjistiDostupnost;

end planovac_api;