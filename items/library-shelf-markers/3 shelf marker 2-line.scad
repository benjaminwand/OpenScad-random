include <_extrudes.scad>

word_text1 = "Beruf und";
word_text2 = "Neurodiversität";
width = 78;         // adjust that after adjusting the text
thickness = 0.8;    // make it thick enough to print

translate ([2, 0, 0]) linear_extrude(thickness) text(word_text1, size = 8);
translate ([2, -11, 0]) linear_extrude(thickness) text(word_text2, size = 8);
xy_extrude([[0, thickness + 10],[0, -14],[width, -14],[width, thickness + 10]], thickness);
xz_extrude([[0, 0],[0, -50], [thickness, -50],[width, 0]], thickness, false);
yz_extrude([[0, 0],[0, -50], [thickness, -50],[40, -35],[40, -15], [10, 0]], thickness, false);
