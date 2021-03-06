// this file is to test fonts at certain sizes on the slicer,
// so you can see whether it is actually readable
//
// rendering fonts is very slow, don't do too many at a time,
// for example only show the ones you are currently considering
//
// how to add fonts into here: drag and drop them from the font list
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Text#Using_Fonts_&_Styles

size = 5;
extrude = 0.3;
spacing = 1;
// you might copy your words into here
text = "The quick brown fox jumps over the lazy dog."; 

fonts = [
    //"Apple Symbols:style=Regular",
    "American Typewriter:style=Condensed Bold",
    //"Andale Mono:style=Regular",
    "Arial Rounded MT Bold:style=Regular",
    //"Avenir:style=Medium",
    //"Big Caslon:style=中黑",
    //"BitterSweet:style=BitterSweet",
    "Brush Script MT:style=Italic",
    //"Chalkboard:style=Regular",
    "Courier:style=Regular",
    //"Expo:style=Regular",
    //"Fette UNZ Fraktur:style=Regular",
    //"Impact:style=Regular",
    //"Lato:style=Regular",
    "Luminari:style=Regular",
    "Noteworthy :style=Light",
    //"Old London Alternate:style=Regular",
    //"Phosphate:style=Inline",
    //"Playbill:style=Regular",
    //"Rockwell:style=Regular",
    //"SignPainter:style=HouseScript",
    //"Skia:style=Regular",
    "Tahoma:style=Regular",
    //"Thunderbird:style=Regular",
    "ZCOOL QingKe HuangYou:style=Regular",
    ];

for (i = [0:len(fonts)-1])
    translate([0, -i * 3.5 * size, 0])
        linear_extrude(extrude) union(){
            text(fonts[i], size = size, font = fonts[i], halign = "center", spacing = spacing);
            translate([0, -size * 1.6, 0])
                text(text, size = size, font = fonts[i], halign = "center", spacing = spacing);
        };