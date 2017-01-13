use <8020.scad>

$fn=90;
in2mm=25.4;
moduleHeight = in2mm*72;


//aluminium8020(moduleHeight);

module kinectBase()
{
    //holes
    difference(){
        cube([87, 73,.5*in2mm]);
        translate([7.5+2.5/2,25+2.5/2,0])
            union(){
                translate([0,0,0])cylinder(d=2.5, h=100);
                translate([68.6,0,0])cylinder(d=2.5, h=100);
                translate([0,(.75*in2mm),0])cylinder(d=2.5, h=100);
                translate([68.6,(.75*in2mm),0])cylinder(d=2.5, h=100);
            }
    }
}

union(){
kinectBase();
translate([87-1.25*in2mm,73,0])linearBearing(3*in2mm);
}