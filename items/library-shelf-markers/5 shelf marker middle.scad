include <_extrudes.scad>

word_text = "Piazzolla";
width = 48;         // adjust that after adjusting the text
thickness = 0.8;    // make it thick enough to print

translate ([2, -3, 0]) linear_extrude(thickness) text(word_text, size = 8);
xy_extrude([[0, thickness+7],[0, -7],[width, -7],[width, thickness+7]], thickness);
xz_extrude([[0, 0],[0, -50], [thickness, -50],[width, 0]], thickness, false);
yz_extrude([[7, 0],[0, 0],[0, -50], [thickness, -50],[40, -35],[40, -15]], thickness, false);
