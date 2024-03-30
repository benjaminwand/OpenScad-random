module stairs_simple(h, t, b, floor_height) 
    let(
        anzahl = round(h/180), 
        stufentiefe = min(300, t/anzahl), 
        stufenhoehe = h/anzahl,
        versatz = max(0, t - anzahl*stufentiefe)/2,
        stufe_unten = [for (i=[0:anzahl]) [i*stufentiefe + versatz,stufenhoehe*i]], 
        stufe_oben = [for (i=[0:anzahl]) [i*stufentiefe + versatz, stufenhoehe*(i+1)]]
    ) 

    rotate([90, 0, 0]) linear_extrude(b, center = true) 
        polygon(points = [
            for (i= [0:(len(stufe_unten) + len(stufe_oben)-2)]) 
                (i % 2 == 0) ? stufe_unten[i/2] : stufe_oben[i/2],
            [t,anzahl*stufenhoehe],
            [t,anzahl*stufenhoehe-floor_height],
            [t-versatz,anzahl*stufenhoehe-floor_height],
            [versatz, -floor_height],
            [0, -floor_height],
            [0, 0],
        ]);

stairs_simple(h=2000, t=5000, b=1000, floor_height = 200);
%cube([5000, 1000, 2000]);