use <8020.scad>

$fn=90;
in2mm=25.4;
moduleHeight = in2mm*72;
holeDiameter = 3;
baseThickness = 10;
baseWidth = 87; //measured from kinect
baseDepth = 73; //measured from kinect
bearingHeight = 3*in2mm;
8020width = 1.25*in2mm;

module kinectBase()
{
    //holes
    difference(){
        cube([baseWidth, baseDepth, baseThickness]);
        translate([7.5+2.5/2,25+2.5/2,0])
            union(){
                translate([0,0,-.5])cylinder(d=holeDiameter, h=baseThickness+1);
                translate([68.6,0,-.5])cylinder(d=holeDiameter, h=baseThickness+1);
                translate([0,(.75*in2mm),-.5])cylinder(d=holeDiameter, h=baseThickness+1);
                translate([68.6,(.75*in2mm),-.5])cylinder(d=holeDiameter, h=baseThickness+1);
            }
    }
}

module reinforcement()
{
    difference()
    {
        hull(){
            translate([0,8020width,0])cube([8020width+10,1,bearingHeight]);
            translate([0,-5,0])cube([8020width+10,5,baseThickness]);
        }
        translate([0,2,0])cube([8020width,8020width-1,bearingHeight]);
    }
}

module hook()
{
    translate([0,baseThickness/2,0])
    rotate([0,90,0])
    difference()
    {
        hull()
        {
            cylinder(d=baseThickness, h=baseThickness);
            translate([-baseThickness/2,-baseThickness/2,0])cube([baseThickness,0.1,baseThickness]);
        }
        cylinder(d=baseThickness/2, h=baseThickness);
    }
}

/**
 *   The actual part.
 */
union(){
    kinectBase();
    translate([baseWidth-8020width-10, baseDepth, 0])linearBearing(bearingHeight);
    translate([baseWidth-baseThickness-8020width, baseDepth-1, 0])reinforcement();
    translate([baseWidth-8020width/2-baseThickness-baseThickness/2, baseDepth+8020width, bearingHeight-baseThickness/2])hook();
}