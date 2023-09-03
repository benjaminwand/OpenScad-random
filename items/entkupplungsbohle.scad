laenge = 40;
laenge1 = 24;
hoehe1 = 2.5;
laenge2 = 19.2; // or 12
hoehe2 = 1.8;
breite = 7.5;
zylinderd = 4.5;
zylinderl = 5;
schraube = 1.5;
rille = 2.8;
$fn=20;

points = [[laenge/2, 0], [laenge1/2, hoehe1], [-laenge1/2, hoehe1], [-laenge/2, 0], [-laenge2/2, 0],[-laenge2/2, -hoehe2], [laenge2/2, -hoehe2], [laenge2/2, 0] ];

rotate([90, 0, 0])
difference(){
    union(){
        linear_extrude(breite, center=true) polygon(points);
        rotate([90, 0, 0]) cylinder(zylinderl + hoehe2, zylinderd/2, zylinderd/2, false);
    };
    translate([0, -hoehe2/2, 0]) rotate([90, 0, 0])
        cylinder(zylinderl + hoehe2, schraube/2, schraube/2, false);
    translate([0, 2, 0]) cube([laenge, 3, rille], center=true);   
}