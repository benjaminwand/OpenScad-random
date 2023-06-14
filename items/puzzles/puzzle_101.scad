// variales to adjust
p_z = 2.5;      // height of puzzle piece
h_s = 0.35;     // knob sizes
h_d = 0.13;     // knob distance
d = 0.3;        // distance between puzzle pieces
dc = 0.6;       // depth of carving
fs = 3.5;       // roughly the size of straight party of curves
$fn = 50;

// constant
p_x = 19;           // side length of puzzle piece
p_y = 19;           // side length of puzzle piece
sl = 20;            // leave size
amount = [10, 10];  // how many pieces one wants
shuffle = [02,49,76,93,79,82,7,50,69,54,81,57,23,92,71,88,17,01,18,77,97,90,89,60,83,04,42,70,86,84,55,62,12,09,99,10,98,45,29,40,37,33,38,28,68,95,78,58,75,15,53,87,06,48,64,32,34,74,66,63,31,41,00,14,35,46,11,27,91,30,85,03,26,52,13,08,72,21,73,25,20,39,16,19,61,96,56,43,05,67,44,36,47,59,65,24,22,80,51,94];

{       // penrose puzzle modules
module smalldot() 
resize([p_x * h_s -d, p_y * h_s - d]) cylinder(p_z, 10, 10);

module bigdot()
resize([p_x * h_s +d, p_y * h_s +d]) cylinder(p_z*3, 10, 10, true);

module piece(){
    difference(){
        translate([d/2, d/2]) cube([p_x -d, p_y -d, p_z]);
        translate([p_x * h_d, p_y * 0.5]) bigdot();
        translate([p_x * 0.5, p_y * h_d]) bigdot();
    }
    translate([p_x * (h_d + 1), p_y * 0.5]) smalldot();
    translate([p_x * 0.5, p_y * (h_d + 1)]) smalldot();   
}

module penrose_tiles()
translate([87, 87, p_z - dc]) resize([380, 380]) rotate([0, 0, 180])
    import("Penrose.stl");
    // from https://www.printables.com/de/model/99841-penrose-scadvent-no-21

module puzzle() 
for (x= [0 : amount[0]-1], y = [0 : amount[1]-1]) 
    translate(          // shuffel around
        [shuffle[x*10+y]%10*p_x, 
        floor(shuffle[x*10+y]/10)*p_y])                   
translate([-x * p_x, -y * p_y])     // bring back to 0/0
    difference(){
        translate([x * p_x, y * p_y]) piece(); 
        penrose_tiles();
    }
}

{       // bezier curve modules
function fn(a, b) = round(sqrt(pow(a[0]-b[0],2) + (pow(a[1]-b[1], 2)))/fs);
    
module shape() cylinder(2 * dc, 1, 1, true);

function b_pts(pts, n, idx) =
    len(pts)>2 ? 
        b_pts([for(i=[0:len(pts)-2])pts[i]], n, idx) * n*idx 
            + b_pts([for(i=[1:len(pts)-1])pts[i]], n, idx) * (1-n*idx)
        : pts[0] * n*idx 
            + pts[1] * (1-n*idx);
    
module b_curve(pts) 
    let (idx=fn(pts[0], pts[len(pts)-1]), n = 1/idx){
        for (i= [0:idx-1]) {
            hull(){ 
               translate(b_pts(pts, n, i)) shape();
               translate(b_pts(pts, n, i+1)) shape();          
            };
        }
    };
};

module flower1(){   
p1 = [18, 12];
p2 = [15, 4.5];
p3 = [8, 10];
p4 = [17.8, 28.2];
p5 = [28, 5];
p7 = [32, 24];
p8 = [37, 20];
p9 = [28, 12];
p10 = [40, 30];
p11 = [28, 32];
p12 = [25, 42];
p13 = [35, 45];
p14 = [20, 50];
p15 = [16, 45];
p16 = [8, 38];
p17 = [9, 47];
p18 = [-5, 38];
p19 = [5, 27];
p20 = [-5, 25];
p21 = [3, 21];
p22 = [3, 10];

b_curve([p1, p2, p3, p4]);
b_curve([p1, p5, p9, p4]);
b_curve([p7, p8, p9, p4]);
b_curve([p7, p10, p11, p4]);
b_curve([p12, p13, p11, p4]);
b_curve([p12, p14, p15, p4]);
b_curve([p16, p17, p15, p4]);
b_curve([p16, p18, p19, p4]);
b_curve([p21, p20, p19, p4]);
b_curve([p21, p22, p3, p4]);  
};

module flower2(){ 
fcenter2 = [110, 20];
hm21 = [100,5];    
hm22 = [92, 27];
hm23 = [110, 40];
hm24 = [130,28];
hm25 = [125, 5];
a21 = [97, 17];
a22 = [101, 35];
a23 = [120, 34];
a24 = [126, 18];
a25 = [112, 5];
ov211 = [103, -7];
ov212 = [85, 5];
ov221 = [80, 20];
ov222 = [85, 38];
ov231 = [98, 54];
ov232 = [121, 55];
ov241 = [131, 42];
ov242 = [140, 20];
ov251 = [138, 7];
ov252 = [120, -6];

b_curve([fcenter2, a25, ov211, hm21]);
b_curve([fcenter2, a21, ov212, hm21]);
b_curve([fcenter2, a21, ov221, hm22]);
b_curve([fcenter2, a22, ov222, hm22]);
b_curve([fcenter2, a22, ov231, hm23]);
b_curve([fcenter2, a23, ov232, hm23]);
b_curve([fcenter2, a23, ov241, hm24]);
b_curve([fcenter2, a24, ov242, hm24]);
b_curve([fcenter2, a24, ov251, hm25]);
b_curve([fcenter2, a25, ov252, hm25]);
};

module flower3(){
fcenter3 = [150, 110];
hm31 = [140.546, 93.4127];    
hm32 = [133.927, 115.274];
hm33 = [148.773, 130.241];
hm34 = [168.94, 118.061];
hm35 = [163.787, 93.6315];
a31 = [136.147, 105.651];
a32 = [140.948, 125.467];
a33 = [158.188, 125.634];
a34 = [166.733, 107.834];
a35 = [150.505, 95.6093];
ov311 = [143.572, 82.2312];
ov312 = [124.275, 96.5687];
ov321 = [121.547, 108.83];
ov322 = [124.595, 129.988];
ov331 = [137.213, 144.507];
ov332 = [161.979, 146.761];
ov341 = [171.274, 130.878];
ov342 = [178.26, 111.149];
ov351 = [178.435, 96.4894];
ov352 = [161.641, 85.3791];

b_curve([fcenter3, a35, ov311, hm31]);
b_curve([fcenter3, a31, ov312, hm31]);
b_curve([fcenter3, a31, ov321, hm32]);
b_curve([fcenter3, a32, ov322, hm32]);
b_curve([fcenter3, a32, ov331, hm33]);
b_curve([fcenter3, a33, ov332, hm33]);
b_curve([fcenter3, a33, ov341, hm34]);
b_curve([fcenter3, a34, ov342, hm34]);
b_curve([fcenter3, a34, ov351, hm35]);
b_curve([fcenter3, a35, ov352, hm35]);
};

module flower4(){  
fcenter4 = [70, 103];
hm41 = [64, 90];    
hm42 = [57.4141, 106];
hm43 = [69.4606, 119.079];
hm44 = [83, 110];
hm45 = [79, 94];
a41 = [60, 97];
a42 = [62, 115];
a43 = [78, 118];
a44 = [80, 102];
a45 = [73, 91];
ov411 = [68, 75];
ov412 = [52, 85];
ov421 = [45, 100];
ov422 = [50, 120];
ov431 = [60, 128];
ov432 = [78, 127];
ov441 = [88, 119];
ov442 = [94, 104];
ov451 = [94, 95];
ov452 = [82, 78];

b_curve([fcenter4, a45, ov411, hm41]);
b_curve([fcenter4, a41, ov412, hm41]);
b_curve([fcenter4, a41, ov421, hm42]);
b_curve([fcenter4, a42, ov422, hm42]);
b_curve([fcenter4, a42, ov431, hm43]);
b_curve([fcenter4, a43, ov432, hm43]);
b_curve([fcenter4, a43, ov441, hm44]);
b_curve([fcenter4, a44, ov442, hm44]);
b_curve([fcenter4, a44, ov451, hm45]);
b_curve([fcenter4, a45, ov452, hm45]);
};

module branches(){
s11 = [33, 29];
s12 = [80, 55];
s130 = [-30, 100];
s13 = [30, 180];
s14 = [100, 180];
s15 = [140, 180];
s151 = [150, 120];
s16 = [80, 160];
s17 = [72, 121];
s18 = [155, 180];
s19 = [150, 133];
b_curve([s11, s12, s130, s13, s14]);
b_curve([s14, s15, s151, s16, s17]);
b_curve([s14, s18, s19]);

s21 = [101, 18];
s22 = [70, 12];
s23 = [70, 60];
s24 = [110, 60];
s25 = [250, 60];
s26 = [220, 249];
s27 = [120, 250];
b_curve([s21, s22, s23, s24]);
b_curve([s24, s25, s26, s27]);

s31 = [158, 12];
s32 = [185, -10];
s33 = [183, -60];
b_curve([s31, s32, s33]);

s41 = [112, 103];
s42 = [115, 80];
s42b = [60, 70];
s43 = [50, 50];
b_curve([s41, s42, s42b, s43]);
};

module leaf() {
b_curve([[0, 0], [sl/2.8, sl/2], [0, sl]]);
mirror([1, 0, 0]) b_curve([[0, 0], [sl/3, sl/2], [0, sl]]); 
}
module littleflower() 
for (i = [0:72:350]) rotate([0, 0, i]){
    b_curve([[0, 0], [sl*0.28, sl*0.3], [0, sl*0.6]]);
    mirror([1, 0, 0]) b_curve([[0, 0], [sl*0.28, sl*0.3], [0, sl*0.6]]);
}

module leaves_and_littleflowers(){
translate([88, 19]) rotate([0, 0, 100]) leaf();
translate([78, 37]) rotate([0, 0, 30]) leaf();
translate([98, 59]) rotate([0, 0, -40]) leaf();
translate([135, 62]) rotate([0, 0, -25]) leaf();
translate([145, 55]) rotate([0, 0, -145]) leaf();
translate([160, 48]) rotate([0, 0, -85]) leaf();
translate([175, 35]) rotate([0, 0, -170]) leaf();
translate([194, 5]) rotate([0, 0, -180]) leaf();
translate([12, 180]) rotate([0, 0, -150]) leaf();
translate([14, 160]) rotate([0, 0, -195]) leaf();
translate([12, 125]) rotate([0, 0, 145]) leaf();
translate([3, 100]) rotate([0, 0, 190]) leaf();
translate([-14, 80]) rotate([0, 0, 210]) leaf();
        
translate([37.5, 32]) rotate([0, 0, -90]) leaf();
translate([43, 43]) rotate([0, 0, 60]) leaf();
translate([42, 57]) rotate([0, 0, -30]) leaf();
translate([35, 73]) rotate([0, 0, 80]) leaf();
translate([30, 87]) rotate([0, 0, -30]) leaf();
translate([25, 120]) rotate([0, 0, -50]) leaf();
translate([39, 152]) rotate([0, 0, -85]) leaf();
translate([30, 140]) rotate([0, 0, 5]) leaf();
translate([50, 165]) rotate([0, 0, -15]) leaf();
translate([68, 173]) rotate([0, 0, -110]) leaf();
translate([78, 178]) rotate([0, 0, -35]) leaf();
translate([98, 180]) rotate([0, 0, -130]) leaf();
translate([120, 178]) rotate([0, 0, -55]) leaf();
translate([141, 167]) rotate([0, 0, 180]) leaf();
translate([148, 158]) rotate([0, 0, -130]) leaf();
translate([118, 147]) rotate([0, 0, 70]) leaf();
translate([100, 141]) rotate([0, 0, 150]) leaf();
translate([85, 137]) rotate([0, 0, 85]) leaf();

translate([38, 2]) rotate([0, 0, 20]) littleflower();
translate([110, 110]) rotate([0, 0, 20]) littleflower();
translate([152, 16]) rotate([0, 0, 40]) littleflower();

translate([57, 60]) rotate([0, 0, -25]) leaf();
translate([75, 69]) rotate([0, 0, -105]) leaf();
translate([90, 79]) rotate([0, 0, -15]) leaf();
translate([107, 89]) rotate([0, 0, -85]) leaf();

translate([183, 153]) rotate([0, 0, -15]) leaf();
translate([178, 170]) rotate([0, 0, 65]) leaf();
translate([174, 184]) rotate([0, 0, -25]) leaf();
};

// flow control
difference(){
    puzzle();
    for (x=[-p_x*amount[0], 0, p_x*amount[0]], y = [- p_y*amount[1],0,  p_y*amount[1]])
        translate([x, y]){
            flower1();
            flower2();
            flower3();
            flower4();
            branches();
            leaves_and_littleflowers();
        }
}
