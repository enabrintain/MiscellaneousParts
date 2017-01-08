$fn = 90;

wallThickness = 5.4;
centerholeDiameter = 10;
screwDiameter = 2.75;
xWidth = 13;
yWidth = 11.6;
screwHoleOffset = 1;
heigth = 8.5;

difference(){
    //make the cross piece
    union(){
        cube([xWidth, yWidth+2*wallThickness, heigth]);
        translate([-wallThickness,wallThickness,0])
            rotate([0,0,-90])
                translate([-yWidth,0,0])
                    cube([yWidth, xWidth+2*wallThickness, heigth]);
    }
    //cut the center hole
    translate([xWidth/2,(yWidth+2*wallThickness)/2,-.5])
        cylinder(d = centerholeDiameter, h=heigth+1 );
    //cut the screw holes
translate([xWidth/2,(yWidth+2*wallThickness)/2-centerholeDiameter/2-screwDiameter/2-screwHoleOffset,-.5])
    cylinder(d = screwDiameter, h=heigth+1 );
translate([xWidth/2,(yWidth+2*wallThickness)/2+centerholeDiameter/2+screwDiameter/2+screwHoleOffset,-.5])
    cylinder(d = screwDiameter, h=heigth+1 );
translate([xWidth/2+centerholeDiameter/2+screwDiameter/2+screwHoleOffset,(yWidth+2*wallThickness)/2,-.5])
    cylinder(d = screwDiameter, h=heigth+1 );
translate([xWidth/2-centerholeDiameter/2-screwDiameter/2-screwHoleOffset,(yWidth+2*wallThickness)/2,-.5])
    cylinder(d = screwDiameter, h=heigth+1 );
}