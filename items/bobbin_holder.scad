d = 21.1;   // bobbin diameter
w = 9.3;    // bobbin width
r = 6;      // number of rows
minW = 1.2;

module spule(){
translate([0, 0, d/2]) rotate([90, 0, 0]) cylinder(w, d/2, d/2, true);
cube([d/2, w, d], true);
};

module spulen()
for(x = [d/2, -d/2], y = [0:r+1]) 
    translate([x, y * (w + minW) + minW + w/2]) spule();

module cylind()
rotate([-90, 0, 0]) cylinder(r * (w+minW) + minW, d/4, d/4);
    
difference(){
    hull(){
        translate([d*0.75, 0, d/4]) cylind();
        translate([-d*0.75, 0, d/4]) cylind();
    };
    spulen();
}

