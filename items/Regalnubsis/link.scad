linear_extrude(1.5) 
text(text="github.com/benjaminwand/Regalnubsis", size=8);

hull(){
translate([0, 4, 0])
cylinder(0.5,10,10,false);
translate([188, 4, 0])
cylinder(0.5,10,10,false);
}