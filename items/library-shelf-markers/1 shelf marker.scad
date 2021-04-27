include <_extrudes.scad>

word_text = "Prototyping";
width = 59;         // adjust that after adjusting the text
thickness = 0.8;    // make it thick enough to print

translate ([2, -10, 0]) linear_extrude(thickness) text(word_text, size = 8);
xy_extrude([[0, thickness],[0, -13.5],[width, -13.5],[width, thickness]], thickness);
xz_extrude([[0, 0],[0, -50], [thickness, -50],[width, 0]], thickness, false);
yz_extrude([[0, 0],[0, -50], [thickness, -50],[40, -35],[40, -15]], thickness, false);
