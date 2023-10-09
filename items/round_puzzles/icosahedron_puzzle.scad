/*
Round Truncated Icosahedron puzzle
https://en.wikipedia.org/wiki/Truncated_icosahedron

Inspired by an idea of Kerry Williams, who wants to make large objects 3d-printable by making them into puzzles. This was a more mainstreamy version of the first prototype of this project.

Thanks to Lukas Süss aka mechadense for typing the math into an OpenSCAD file!
https://www.printables.com/de/model/430670-truncated-icosahedron-rounded-soccer-form

The optional text inside the pieces is from Johann Wolfgang von Goethes Versuch einer Witterungslehre, 1825
*/

// parameters
s = 69;                 // basic edge length, shall be 101 for 50 cm ball
w = s/6;                // max width of dovetail
gap = 0.3;              // gap between puzzle pieces
shell = 10;             // shell thickness 
letter_depth = 1 + s * 0.01;    // letter relief depth/height
rim = s * 0.02;         // to keep the last piece from falling inside

// design options
interval = [0:31];       // which pieces do you want? [0:31] for all of them
round_in = 0;           // do you want it curved inside ?
engraving = 1;          // do you want a sentence inside ?
outside_numbers = 1;    // do you want the pieces numbered on the outside ?
braille_numbers = 1;    // do you want braille numbering inside ?

gaps_only = 0;          // only the gaps, development option
gray = 0.3;             // brightness for (soccer ball) pentagons


// maths

//enclosing sphere of truncated icosahedron 
sph_diam = (s*3)*1/6*sqrt(29/2+9/2*sqrt(5)); 
echo(str("Whole diameter is ", round(sph_diam*2), " mm"));

rhex = s;
rpent = (s/2)/cos(54);

rpent1 = s*0.5/tan(36);
rhex1 = sqrt(3)*s/2;

hhex =  sqrt(pow(sph_diam,2)-pow(rhex,2)); 
hpent = sqrt(pow(sph_diam,2)-pow(rpent,2));
hexhex = acos(-1/3*sqrt(5)); 

// angel hex-center to hex-center from body-center
hh = (180-90-hexhex/2)*2; 
// angel hex-center to pent-center from body center
hp = atan(rhex*cos(30)/hhex)+atan(rpent*cos(72/2)/hpent); 
// angel pent-center to pent-center from body center
pp = 2*atan(rpent/hpent) + 2*atan((s/2)/(hhex/cos(hh/2))); 

// words
// in English: "Just as restlessly, the water wants to pull the earth, which it reluctantly left, back into its abyss, the air, which should kindly envelop and animate us, suddenly rushes along as a storm"
encoding = ["eben", "so", "unruhig", "möchte", "das", "Wasser", "die (1)", "Erde", "die (2)", "es", "ungern", "verließ", "wieder", "in", "seinen", "Abgrund", "reißen", "die (3)", "Luft", "die (4)", "uns", "freundlich", "umhüllen", "und", "beleben", "sollte", "rast", "auf", "einmal", "als", "Sturm", "daher"];

// spheres
module small_sphere() sphere(r=sph_diam - shell, $fa=4, $fs=0.1);
module outer_sphere() sphere(r=sph_diam, $fa=4, $fs=0.1);

// dovetail pattern
side_straight = [[-s/2, 0],[-s/2, -w*1.2],[s/2, -w*1.2]];

dovetail5 =[[-s/2, 0],[-s*0.2, -w*0.3],[-s/4, w*0.75], [-s*0.085, w], [s*0.05, w*0.45],[-s*0.05, -w*0.45], [s*0.085, -w], [s/4, -w*0.75], [s*0.2, w*0.3], [s/2, 0]];
dovetail6 =[[-s/2, 0],[-s*0.2, -w*0.3],[-s/4, w*0.75], [s*0.05, w*0.45],[-s*0.05, -w*0.45], [s/4, -w*0.75], [s*0.2, w*0.3], [s/2, 0]]; 
    
function dovetest(z, mode) = 
    mode == 0 ? side_straight : z==5 ? dovetail5 : dovetail6;
    
function move(z, mode) =
    [for (i=dovetest(z,mode)) i+[0, z==5 ? -rpent1 : -rhex1]];

function turn(v, a) = 
    [v[0]*cos(a) - v[1]*sin(a), v[0]*sin(a) + v[1]*cos(a)]; 
    
function turnall(z, mode, a) =
    [for (v=move(z, mode)) turn(v, a)];

// text modules
module braillestamptext(text, size)
    difference(){
        translate([0, size])square([len(text)*size *1.35, size *2], true);
        translate([size*0.3, 0])text(text, font="braille_deutsch", size=size, halign="center");
    } 
 
module braille_stamp(z, txt, size, y_translate=0) 
let (movedown = z==5 ? hpent : hhex)
if (round_in)
    intersection(){
        translate([0,0,movedown]) 
            difference(){
                sphere(r=sph_diam - shell + letter_depth, $fa=4, $fs=0.1);
                sphere(r=sph_diam - shell - letter_depth, $fa=4, $fs=0.1);
            };
        translate([0, y_translate])linear_extrude(2*shell, center=true) 
            braillestamptext(txt, size);
    }
else
    translate([0, y_translate, shell - rim]) 
        linear_extrude(2 * letter_depth, center=true) braillestamptext(txt, size);   
               
module inside_text(z, txt, size, valign, halign, font, y_translate=0) 
let (movedown = z==5 ? hpent : hhex)
if (round_in)
    intersection(){
        translate([0,0,movedown]) difference(){
            sphere(r=sph_diam - shell + letter_depth, $fa=4, $fs=0.1);
            sphere(r=sph_diam - shell - letter_depth, $fa=4, $fs=0.1);
        };
        translate([0, y_translate])linear_extrude(2*shell, center=true) 
            text(str(txt), size=size, valign=valign, halign=halign, font=font);
    }
else
    translate([0, y_translate, shell - rim]) linear_extrude(2 * letter_depth, center=true) 
        text(str(txt), size=size, valign=valign, halign=halign, font=font);

// main module
module piece(z, n, m, gap=0, round_out=false) // 5/6, number, modes, gap, round_out
let (movedown = z==5 ? hpent : hhex) color( z==5 ? [gray, gray, gray] : "white") 
intersection(){
    if (round_out==true) outer_sphere();
    translate([0,0,-movedown]) {
        difference(){
            translate([0,0,-s*0.24 -rim +gap]) linear_extrude(shell + s*0.24, center=false) 
                offset(gap, $fn=8) 
                    polygon( [ for (i=[0:z-1], v=move(z, m[i])) turn(v, 360/z*i)]);
            #if (engraving) inside_text(z, encoding[n-1], s/5, valign="bottom", halign="center");
            #if (outside_numbers) translate([0,0,z==5 ? -s*0.15 : -s*0.21]) linear_extrude(5) 
                mirror([1,0,0]) text(str(n), size=s/2, valign="center", halign="center");
            if (round_in && round_out) translate([0,0,movedown]) small_sphere();
            if (braille_numbers && !round_in) braille_stamp(z=z,txt=(str("#", n)), 
                size= 5+s*0.01, y_translate = -s/3);
        };
        if (braille_numbers && round_in) inside_text(movedown,txt=(str("#", n)), 
            size= 5+s*0.01, "top", "center", font="braille_deutsch", y_translate = -s/5);
    }
};

// flow control 
module whole_ball() {
    // gaps
    if (gaps_only) for (i = interval)
        difference() {
            let($gap = gap, $round_out=false) children(i);
            let($gap = 0, $round_out=false) children(i);
            if (round_in) small_sphere();
        }
    // pieces
    else for (i = interval) {
        difference(){
            let($gap = 0, $round_out=true) children(i);
            if (i > 0) for (k = [0:i-1]) let($gap = gap, $round_out=false) children(k);
        };
        echo(encoding[31-i]);
    }
}

// data
whole_ball() {
    rotate([hp,0,60]) piece(5, 32, [1, 1, 1, 1, 1], $gap, $round_out);
    piece(6, 31, [1, 1, 1, 1, 0, 1], $gap, $round_out);
    rotate([hh,0,0]) piece(6, 30, [0, 1, 1, 1, 1, 0], $gap, $round_out);
    rotate([hh,0,0]) rotate([hh,0,60]) piece(6, 29, [0, 1, 1, 1, 1, 0, 1], $gap, $round_out);
    rotate([hp+pp,180,0]) rotate([0,0,180]) piece(5, 28, [0, 1, 1, 1, 0], $gap, $round_out);
    rotate([hh,0,0]) rotate([hh,0,-60]) piece(6, 27, [0, 1, 1, 1, 1, 0], $gap, $round_out);
    rotate([hp,0,-60]) piece(5, 26, [0, 1, 1, 0, 0], $gap, $round_out);
    rotate([hh,0,-120]) piece(6, 25, [0, 1, 1, 1, 1, 0], $gap, $round_out);
    rotate([hp,0,180]) piece(5, 24, [0, 1, 1, 1, 0], $gap, $round_out);
    rotate([hh,0,120]) piece(6, 23, [0, 0, 1, 1, 1, 0], $gap, $round_out);
    rotate([hh,0,120]) rotate([hh,0,-60]) piece(6, 22, [0, 0, 0, 1, 1, 1], $gap, $round_out);
    rotate([hp+pp,0,60]) rotate([0,0,180]) piece(5, 21, [1, 1, 0, 0, 1], $gap, $round_out);
    rotate([hh,0,-120]) rotate([hh,180,240]) piece(6, 20, [1, 1, 1, 1, 0, 0], $gap, $round_out);
    rotate([hp+pp,180,120]) rotate([0,0,180]) piece(5, 19, [0, 0, 0, 1, 1], $gap, $round_out);
    rotate([hh,0,120]) rotate([hh,0,60]) piece(6, 18, [0, 0, 1, 1, 1, 0], $gap, $round_out);
    rotate([hh,0,-120]) rotate([hh,0,-60]) piece(6, 17, [0, 0, 0, 1, 1, 1], $gap, $round_out);
    rotate([hp+pp,180,-120]) rotate([0,0,180]) piece(5, 16, [0, 0, 1, 1, 1], $gap, $round_out);
    rotate([hh,0,-120]) rotate([hh,0,60]) piece(6, 15, [0, 0, 1, 1, 0, 0], $gap, $round_out);
    rotate([hp+pp,0,-60]) rotate([0,0,180]) piece(5, 14, [1, 1, 0, 0, 1], $gap, $round_out);
    rotate([hh,0,120]) rotate([hh,180,120]) piece(6, 13, [1, 0, 0, 0, 1, 1], $gap, $round_out);
    rotate([hh,0,0]) rotate([hh,180,240]) piece(6, 12, [1, 1, 0, 0, 0, 1], $gap, $round_out);
    rotate([hp+pp,0,180]) rotate([0,0,180]) piece(5, 11, [1, 0, 0, 0, 1], $gap, $round_out);
    rotate([hh,0,0]) rotate([hh,180,120]) piece(6, 10, [1, 0, 0, 0, 0, 1], $gap, $round_out);
    rotate([hp,180,120]) piece(5, 9, [1, 1, 0, 0, 1], $gap, $round_out);
    rotate([hh,180,60]) piece(6, 8, [1, 0, 0, 0, 1, 1], $gap, $round_out);
    rotate([hh,0,-120]) rotate([hh,180,120]) piece(6, 7, [0, 0, 0, 0, 1, 1], $gap, $round_out);
    rotate([hh,0,120]) rotate([hh,180,240]) piece(6, 6, [1, 1, 0, 0, 0, 0], $gap, $round_out);
    rotate([hp,180,0]) piece(5, 5, [1, 0, 0, 0, 1], $gap, $round_out);
    rotate([180,0,0]) piece(6, 4, [0, 1, 1, 1, 0, 0], $gap, $round_out);
    rotate([hh,180,180]) piece(6, 3, [0, 1, 0, 0, 0, 0], $gap, $round_out);
    rotate([hp,180,-120]) piece(5, 2, [0, 1, 0, 0, 0], $gap, $round_out);
    rotate([hh,180,-60]) piece(6, 1, [0, 0, 0, 0, 0, 0], $gap, $round_out);
}
