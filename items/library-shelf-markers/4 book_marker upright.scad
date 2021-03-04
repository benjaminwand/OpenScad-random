include <_extrudes.scad>

word_text = "Psychologie";
height = 63;        // adjust that after adjusting the text
thickness = 0.8;    // make it thick enough to print

union(){
    rotate([0, 0, 90]) translate ([ -12, -10, 0]) linear_extrude(thickness) text(word_text, size = 8);
    xy_extrude([[0, height -14],[0,  -14],[14,  -14],[14, height -14]], thickness);
    xz_extrude([[0, 0],[0, -50], [thickness, -50],[14, 0]], thickness, false);
    yz_extrude([[0, 0],[0, -50], [thickness, -50],[height -14, 0]], thickness, false);
};