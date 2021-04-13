
module M4_spacer() {
    union(){
        cylinder(  5, 4, 4.2, false, $fn = 6);
        translate([0, 0, -4.9])cylinder(  10, 2.1, 2.1, true, $fn = 15);
    };
}

/*
difference(){
    cube([10,10,7],true);
    M4_spacer ();
}
*/

//M4_spacer();