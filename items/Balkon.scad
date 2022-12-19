// Variablen
// Ungefähr die Seitenlängen der geraden Stücke der Béziere-Kurven
fs = 0.4;
s = 0.5;   // Scale

// Höhen und Breiten eines Balustraden-Töpfchens
distance = 27*s; // Abstand zwischen Säulen
lower_block = 21.7;
higher_block = 20.2;
h1 = 7.2;
w1 = 64.2/PI;
h2 = 12.7;
w2 = 50.9/PI;
h3 = 14.7;
w3 = 34/PI;
h4 = 19.8;
w4 = 42/PI;
h5 = 21.5;
w5 = 68.2/PI;
h6 = 56.4;
w6 = 36.5/PI;
h7 = 57.8;
w7 = 39.8/PI;
w8 = 48/PI;
h9 = 59.7;
w9 = 36.2/PI;
h10 = 63.1;
w10 = 46.3/PI;
h11 = 64.8;
w12 = 60.6/PI;
h12 = 69;
h13 = 76;

// Béziere-Kurven-Punkte
p1 = [w1/2, h1];
p2 = [w1/2, 10.5];
p3 = [w1/2, 11.8];
p4 = [w2/2, h2];
p5 = [w2/2, h3];
p6 = [5, 16];
p7 = [4.5, 18];
p8 = [w4/2, h4];
p9 = [w4/2, h5];
p10 = [16.3, 28];
p11 = [6, 37];
p12 = [w6/2, h6];
p13 = [6.4, 56.6];
p14 = [w7/2, h7];
p15 = [8, 58];
p16 = [8.4, h9];
p17 = [w9/2, h9];
p18 = [5.65, 61.8];
p19 = [w10/2, h10];
p20 = [w10/2, h11];
p21 = [9.5, 65];
p22 = [9.7, 66];
p23 = [w12/2, h12];

// Relief der eckigen Säulen
a1=5;
a2=8;
a3=11;
ti=3;
tii=-0.1;

// Bézier Code
function add(v) = [for(p=v) 1]*v;   // from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks#Add_all_values_in_a_list
function fn(a, b) = round(sqrt(pow(a[0]-b[0],2) + pow(a[1]-b[1], 2))/fs);
function fn_all(pts) = 
    add(
        [for(i=[0:len(pts)-2]) 
            fn(pts[i], pts[i+1]), fn(pts[0], pts[len(pts)-1])*5])
    /6;
        
function b_pts(pts, n, idx) =
    len(pts)>2 ? 
        b_pts([for(i=[0:len(pts)-2])pts[i]], n, idx) * n*idx 
            + b_pts([for(i=[1:len(pts)-1])pts[i]], n, idx) * (1-n*idx)
        : pts[0] * n*idx 
            + pts[1] * (1-n*idx);

function b_curv(pts) =
    let (fn=fn_all(pts))
    [for (i= [0:fn]) concat(b_pts(pts, 1/fn, i))];
    
bezier_points_higher =  concat(    
    [[0, h12]],
    b_curv([p20, p21, p22, p23]),
    [[0, h12-1]]
    );
bezier_points_lower =  concat(    
    [[0, h12-1]],
    b_curv([p19, p20]),
    b_curv([p17, p18, p19]),
    b_curv([p14, p15, p16, p17]),
    b_curv([p12, p13, p14]),
    b_curv([p9, p10, p11, p12]),
    b_curv([p8, p9]),
    b_curv([p5, p6, p7, p8]),
    b_curv([p4, p5]),
    b_curv([p1, p2, p3, p4]),
    [[0, 0]]
    );

// Oberer und unterer Säulen-Teil
module 1topf_higher()scale(s)
    {rotate_extrude($fn = 50)polygon(points = bezier_points_higher);
    translate([0, 0, h13/2+h12/2])cube([higher_block, higher_block, h13-h12], true);
    }
  
module 1topf_lower()scale(s)
    {translate([0, 0, h1/2])cube([lower_block, lower_block, h1], true); 
    rotate_extrude($fn = 50)polygon(points = bezier_points_lower);}

topf_placements=[for (i= [-5.5:-1.5]) [i*distance, 0, 0],
    for (i= [1.5:5.5]) [i*distance, 0, 0],
    for (i= [0:2], j=[-5.5*distance - lower_block/sqrt(2), 5.5*distance + lower_block/sqrt(2)]) [j, i*distance + lower_block/sqrt(2), 0]];

// Relief 
module full_relief(b) polyhedron(points=[
[-b/2+a3, tii, h13/2-a3],
[-b/2+a1, tii, -h13/2+a1],[-b/2+a2, ti, -h13/2+a2],[-b/2+a3, tii, -h13/2+a3],
[b/2-a1, tii, -h13/2+a1],[b/2-a2, ti, -h13/2+a2],[b/2-a3, tii, -h13/2+a3],
[b/2-a1, tii, h13/2-a1],[b/2-a2, ti, h13/2-a2],[b/2-a3, tii, h13/2-a3],
[-b/2+a1, tii, h13/2-a1],[-b/2+a2, ti, h13/2-a2]
	], faces=[
[1,4,6,3],[4,7,9,6],[7,10,0,9],[10,1,3,0],
[1,2,5,4],[4,5,8,7],[7,8,11,10],[10,11,2,1],
[2,3,6,5],[5,6,9,8],[8,9,0,11],[11,0,3,2]
	]);

module corner_cube(b=40, t=50) 
    scale(s) translate([0, 0, h13/2]) difference(){
        cube([b, t, h13], center=true);
        union(){
            for (i=[0, 180]) rotate([0,0, i]) translate([0, -t/2]) full_relief(b);
            for (i=[90, 270]) rotate([0,0, i]) translate([0, -b/2]) full_relief(t);
        };
    };

// Balustrade
for (i=topf_placements) translate (i) 1topf_lower();
//for (i=topf_placements) translate (i) 1topf_higher();

// Ecken-Blöcke
corner_cube(b=2*distance+lower_block, t=lower_block*sqrt(2));
translate([5.5*distance + lower_block/sqrt(2), 0, 0])
    corner_cube(b=lower_block*sqrt(2), t=lower_block*sqrt(2));
translate([-5.5*distance - lower_block/sqrt(2), 0, 0])
    corner_cube(b=lower_block*sqrt(2), t=lower_block*sqrt(2));
difference(){
    translate([-5.5*distance -lower_block/2, 3.5*distance + lower_block/2, 0])
        corner_cube(b=2*distance+lower_block, t=lower_block*sqrt(2));
    translate([-6*distance, 0, 54*s])rotate([-90, 0, 0])
        {cylinder(200*2, 2.5, 2.5, center=false, $fn=30);
        cylinder(120*s, 5, 5, center=false, $fn=40);};}
difference() {
    translate([5.5*distance +lower_block/2, 3.5*distance + lower_block/2, 0])
        corner_cube(b=2*distance+lower_block, t=lower_block*sqrt(2));
    translate([6*distance, 0, 54*s])rotate([-90, 0, 0])
        {cylinder(200*2, 2.5, 2.5, center=false, $fn=30);
        cylinder(120*s, 5, 5, center=false, $fn=40);};}
/*
// Geländer    
translate([0, 0, h13*s-0.01])linear_extrude(5*s) polygon(points = [
    [-197.5*s, 131.6*s],
    [-197.5*s, 98*s],
    [-193*s, 98*s],
    [-193*s, 18*s],
    [-197.5*s, 18*s],
    [-197.5*s, -18*s],
    [-161*s, -18*s],
    [-161*s, -13.5*s],
    [-27*s, -13.5*s],
    [-27*s, -18*s],
    [27*s, -18*s],
    [27*s, -13.5*s],
    [161*s, -13.5*s],
    [161*s, -18*s],
    [197.5*s, -18*s],
    [197.5*s, 18*s],
    [193*s, 18*s],
    [193*s, 98*s],
    [197.5*s, 98*s],
    [197.5*s, 131.6*s],
    [143.5*s, 131.6*s],
    [143.5*s, 98*s],
    [165*s, 98*s],
    [165*s, 18*s],
    [161*s, 18*s],
    [161*s, 13.5*s],
    [27*s, 13.5*s],
    [27*s, 18*s],
    [-27*s, 18*s],
    [-27*s, 13.5*s],
    [-161*s, 13.5*s],
    [-161*s, 18*s],
    [-165*s, 18*s],
    [-165*s, 98*s],
    [-143.5*s, 98*s],
    [-143.5*s, 131.6*s]]);
*/
// Boden 
translate([0, 0, -7*s])linear_extrude(7*s+0.05) polygon(points = [
    [-197.5*s, 131.6*s],
    [-197.5*s, 98*s],
    [-193*s, 98*s],
    [-193*s, 18*s],
    [-197.5*s, 18*s],
    [-197.5*s, -18*s],
    [-161*s, -18*s],
    [-161*s, -13.5*s],
    [-27*s, -13.5*s],
    [-27*s, -18*s],
    [27*s, -18*s],
    [27*s, -13.5*s],
    [161*s, -13.5*s],
    [161*s, -18*s],
    [197.5*s, -18*s],
    [197.5*s, 18*s],
    [193*s, 18*s],
    [193*s, 98*s],
    [197.5*s, 98*s],
    [197.5*s, 131.6*s]
    ]);
