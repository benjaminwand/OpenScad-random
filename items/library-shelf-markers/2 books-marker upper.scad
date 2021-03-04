include <_extrudes.scad>

word_text = "Psychologie";
width = 63;         // adjust that after adjusting the text
thickness = 0.8;    // make it thick enough to print

union(){
    translate ([2, 3.5, 0]) linear_extrude(thickness) text(word_text, size = 8);
    xy_extrude([[0, 14],[0, 0],[width, 0],[width, 14]], thickness);
    xz_extrude([[0, 0],[0, -50], [thickness, -50],[width, 0]], thickness, false);
    yz_extrude([[0, 0],[0, -50], [thickness, -50],[40, -35],[40, -15], [13, 0]], thickness, false);
};