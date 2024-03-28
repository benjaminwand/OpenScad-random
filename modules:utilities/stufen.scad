module stairs_simple(h, t, b) 
    let(
        anzahl = round(h/180), 
        stufentiefe = min(300, t/anzahl), 
        stufenhoehe = h/anzahl, 
        stufe_unten = [for (i=[0:anzahl]) [i*stufentiefe,stufenhoehe*i]], 
        stufe_oben = [for (i=[0:anzahl]) [i*stufentiefe, stufenhoehe*(i+1)]] 
    ) 

    linear_extrude(b) 
        polygon(points = [
            for (i= [0:(len(stufe_unten) + len(stufe_oben)-2)]) 
                (i % 2 == 0) ? stufe_unten[i/2] : stufe_oben[i/2],
            [anzahl*stufentiefe,(anzahl-1)*stufenhoehe],
            [stufentiefe, 0],
        ]);

stairs_simple(h=2000, t=5000, b=1000);
