step = 0.4;   // height of steps, should be at least two layers in 3d print
size = 10;  // width of squares
base = 1;   // 0/1 for off/on

colors = ["black", "white", [0.647, 0.282, 0.965], "grey"];

file =              // this is the image you create
[[0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0],   // '0' for 'empty/none'
[0, 0, 0, 0, 0, 1, 3, 3, 3, 1, 0, 0, 0, 0, 0],
[0, 1, 1, 1, 1, 1, 3, 3, 3, 1, 1, 1, 1, 1, 0],
[1, 2, 2, 1, 2, 1, 3, 3, 3, 1, 2, 2, 2, 2, 1],
[1, 2, 2, 1, 2, 2, 1, 1, 1, 2, 2, 2, 2, 1, 1],
[1, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 4, 1],
[1, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 4, 4, 4, 1],
[1, 2, 2, 2, 1, 2, 2, 1, 1, 4, 4, 4, 4, 1, 1],
[1, 2, 2, 2, 2, 1, 1, 4, 4, 4, 4, 1, 1, 2, 1],
[1, 2, 2, 2, 2, 1, 4, 4, 4, 1, 1, 2, 2, 2, 1],
[0, 1, 2, 2, 2, 1, 4, 1, 1, 2, 2, 2, 2, 2, 1],
[0, 0, 1, 2, 2, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1],
[0, 0, 0, 1, 2, 1, 2, 2, 2, 2, 1, 1, 0, 0, 0],
[0, 0, 0, 0, 1, 1, 2, 2, 1, 1, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]];

translate([-len(file[0])*size/2, len(file)*size/2])
for (i = [0 :len(file)-1], j = [0 : len(file[0])-1])
    translate([j, -i-1, 0]*size) 
        color(colors[ (file[i][j] -1) %len(colors) ]) 
            cube([size, size, step * file[i][j]], false);

if (base == 1) 
    translate([0, 0, -step/2]) 
cube([(len(file[0])+1)*size, (len(file)+1)*size, step], true);