/* 
As it is, this file is unfinished. 
It can be used as a basis for a puzzle 
with different solutions on both sides.
*/

p_x = 19;   // side length of puzzle piece
p_y = 19;   // side length of puzzle piece
p_z = 2;    // height of puzzle piece
d = 0.3;    // distance between puzzle pieces
h_s = 0.35;  // knob size
h_d = 0.13;  // knob distance
amount = [10, 10]; // how many pieces one wants
//$fn = 50;

// random number generating variables
//vector = [ for (i = [0 : 99]) 0 ]; // a vector of zeros to be filled with random numbers
vector = [];
i = 0; // counter variable


module smalldot() 
resize([p_x * h_s -d, p_y * h_s - d]) cylinder(p_z, 10, 10);

module bigdot()
resize([p_x * h_s +d, p_y * h_s +d]) cylinder(p_z*3, 10, 10, true);

module puzzle() 

for (x= [0 : amount[0]-1], y = [0 : amount[1]-1])  {
//translate([-x * p_x, -y * p_y, (x * 10 + y) * p_z])
translate([x * p_x, y * p_y])
{
    // i = i+1
    difference(){
        union(){
            cube([p_x -d, p_y -d, p_z]); 
            color("blue") linear_extrude(p_z *2) text(str(vector[x*10 + y]));
        };
        if(x>-1 && y>0) translate([p_x * 0.5, p_y * h_d]) bigdot();
        if(x>0 && y>-1) translate([p_x * h_d, p_y * 0.5]) bigdot();
    };
    if(x<amount[0]-1) translate([p_x * (h_d + 1), p_y * 0.5]) smalldot();
    if(y<amount[1]-1) translate([p_x * 0.5, p_y * (h_d + 1)]) smalldot();  
}
}


function unique(list,pos=0,soFar=true) =
    !soFar || pos >=len(list) ? soFar :
    unique(list,pos=pos+1,soFar = pos==0 || len(search(list[pos],[for (i=[0:pos-1]) list[i]]))==0);

function lesserCount(limit,list,pos,soFar=0) =
    pos == 0 ? soFar :
    lesserCount(limit,list,pos=pos-1,soFar=
        list[pos-1]<limit ? 1+soFar :
        soFar);

function tryPermute(n) =
    let(r=rands(0,1,n))
    [for (i=[0:n-1]) lesserCount(r[i],r,n)];

function permute(n) = 
    let(try=tryPermute(n))
        unique(try) ? try : permute(n);
    
vector = permute(100);
echo(vector);

    
puzzle();
