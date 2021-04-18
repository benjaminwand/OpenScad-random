wt = 0.8;       // wall thickness
h = 100;        // height
w = 60;         // width

translate([-w, -h, 0])cube([w, h, wt], false);
translate([0, -wt, 0])
    xz_extrude([[0, 0], [-w, 0], [-w, wt], [-wt, h], [0, h]], wt, center = false);
intersection(){
    rotate([0, 90,0])cylinder(2*wt, h, h, center=true, $fn=100);
    translate([-h, -h, 0])cube([h, h, h], false);
};

module xy_extrude(points, height, center = true) {
    linear_extrude(height = height, center = center) 
        polygon(points = points); 
};

module xz_extrude(points, height, center = true){
    rotate([90, 0, 0])
        mirror([0, 0, 1])        
            xy_extrude(points, height, center);            
};
