//translate([-r, -r])cube([80,60,100]);

wt = 2; // wall thinckness
r = 10; // radium of outer curve
a = 14.5; // width of straight pieces
rm =1; // radius of cut hole hull pieces
hm = 20; // height of cut holes
h1 = 24; // heights of holes
h2 = 38;
h3 = 52;
h4 = 66;

rotate([0, 0, 180])corner();
translate([0, a*3])rotate([0, 0, 90])corner();
translate([a*4, 0])rotate([0, 0, 270])corner();
translate([a*4, a*3])corner();

cube([a*4, a*3, wt]);

for (i=[0:3]) translate([a*i, 0, 0]) side();
translate([0, a*3, 0])mirror([0, 1, 0])
    for (i=[0:3]) translate([a*i, 0, 0]) side();
for (i=[0:2]) translate([0,a*i, 0])        
    mirror([1, 0, 0])rotate([0, 0, 90])side();
for (i=[0:2]) translate([4*a,a*i, 0])     
    rotate([0, 0, 90])side();

module shape() {
    difference(){
        translate([r, r])circle(r, $fn=50);
        translate([r, r])circle(r-wt, $fn=50);
        square([r, r]);
        translate([0, r])square([2*r, r]);
    };
    translate([0, 0])square([r, wt]);
    translate([2*r-wt, r])square([wt, 80]);
    translate([2*r-wt/2, 80+r])circle(wt, $fn=30);
    polygon(points=[
        [2*r-wt*1.5, 80+r],
        [2*r+wt*0.5, 80+r],
        [2*r, 81],
        [2*r-wt, 81]]);
}

module cut() hull(){
    for (i=[
        [0, 0, hm/2], [0, 0, -hm/2], 
        [0, a/2-wt/2-rm, 0], [0, wt/2-a/2+rm, 0]])
    translate(i)rotate([0, 90, 0])cylinder (3*r, rm, rm, $fn = 20);}

module flatcut() rotate([0, 0, 180])
for (i = [
        [0, a, h1], [0, 0, h1],
        [0, a/2, h2], 
        [0, 0, h3], [0, a, h3],
        [0, a/2, h4]] )
    translate(i) cut();

module side() rotate([0, 0, 90]) difference() {
    mirror([1, 0, 0])rotate([90, 0, 0])linear_extrude(a)shape();
    flatcut();
    }
    
module round_cut() hull(){
    for (i=[
        [hm/2, 0], [-hm/2, 0], 
        [0,-15.5], [0, 15.5]])
    rotate([0,0, i[1]])translate([2*r-wt, 0, i[0]])
        rotate([0, 90, 0])cylinder (wt*2, rm, rm, $fn = 20);}
    
module corner() difference(){
    rotate_extrude(angle=90, $fn=100) shape();
    for (i = [
        [h1, 0], [h1, 45], [h1, 90],
        [h2, 22.5], [h2, 67.5],
        [h3, 0], [h3, 45], [h3, 90],
        [h4, 22.5], [h4, 67.5]] )
    rotate([0, 0, i[1]])translate([0, 0, i[0]]) round_cut();
    }