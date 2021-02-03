$fn=60;
d=360/$fn; // like fn for 'upper part'

// lower part
translate([90, 0, 0])difference(){
    cylinder(12, 42, 42, false);
    translate([0, 0, 2]) cylinder(12, 40.5, 40.5, false);
    };
    
// decoration
translate([-70, 0, 0])
    for(i=[-24: 6: 24], j=[-24: 6: 24])
        {translate([i, 0, 0]) cube([0.5, 48.5, 0.3], true);
        translate([0, j, 0]) cube([48.5, 0.5, 0.3], true);}
        
// upper part
for (i = [1:d:360]) hull(){
    rotate([0, 0, i-45])translate([43.15, 0, 0])hull(){
        translate([0, 0, 0.75])cube(1.5, true); 
        translate([0, 0, sin(3*i)*5 + 6.5])sphere(0.75);
    };
    rotate([0, 0, (i+d)-45])translate([43.15, 0, 0])hull(){
        translate([0, 0, 0.75])cube(1.5, true); 
        translate([0, 0, sin(3*(i+d))*5 + 6.5])sphere(0.75);
    };
    
};
cylinder(1.5, 43.9, 43.9, false);

// upper part alternative    
translate([0, 90, 0])difference(){
    cylinder(12, 43.9, 43.9, false);
    translate([0, 0, 1.5]) cylinder(12, 42.4, 42.4, false);
    translate([0, 0, 2.01])rotate([90, 0, 0])
        linear_extrude(100, center = true)
            polygon(points = [for (i=[-44:44]) [i, sin(i*360/(PI*44))/4*i]]);
    };