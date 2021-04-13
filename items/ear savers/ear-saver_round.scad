t = 1.6;
d = 140;

difference(){
    cylinder (t, d/2, d/2, false, $fn = 100);
    cylinder (t*3, d/2-3, d/2-3, true, $fn = 100);
}
handle();
mirror([1 ,0, 0])handle();

module handle(){
    translate([d/2 +5, 0, t/2])cube([4, 40, t], true);
    translate([d/2, 0, t/2])cube([6, 20, t], true);
    translate([d/2+3, 20, 0])cylinder(2*t, 4, 4, false, $fn = 25);
    translate([d/2+3, -20, 0])cylinder(2*t, 4, 4, false, $fn = 25);
}