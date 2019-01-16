/**
    This is a cnc-able langstroth hive (currently only the Deep Hive Body)
    To use this, scroll to the bottom and then uncomment the projection lines individually, and then use openSCAD to generate dxfs.
    
    The handle holes are intended to be pockets cut into the boards.
    
    Copyright (C) 2018 Phillip Showers
    This model is released under the Creative Commons Attribution/Share Alike license.
    Attribute me if you use it. 
    Share it like I shared it.
    https://creativecommons.org/licenses/by-sa/4.0/

    Feel free to make money on it! If you want, donate some to www.fsf.org.
    
**/

in2mm=25.4;

beehiveDimensions = [(19+7/8)*in2mm, 16.25*in2mm, (9+5/8)*in2mm];
woodWidth = .75*in2mm;
frameRestHeight = 5/8*in2mm;

module handleSide(){
    difference()
    {
        cube([woodWidth, beehiveDimensions.y, beehiveDimensions.z]);
        //slots
        for (zOffset =[woodWidth:woodWidth*2:beehiveDimensions.z])
            translate([0,0,zOffset])
                cube([woodWidth,woodWidth,woodWidth]);
        //slots
        for (zOffset =[woodWidth:woodWidth*2:beehiveDimensions.z])
            translate([0,beehiveDimensions.y-woodWidth,zOffset])
                cube([woodWidth,woodWidth,woodWidth]);
        
        translate([woodWidth/2,0,beehiveDimensions.z-frameRestHeight])
            cube([woodWidth/2, beehiveDimensions.y, frameRestHeight]);
    }    
}

module hiveFront(){
    difference()
    {
        cube([beehiveDimensions.x, woodWidth, beehiveDimensions.z]);
        for (zOffset =[0:woodWidth*2:beehiveDimensions.z])
            translate([0,0,zOffset])
                cube([woodWidth,woodWidth,woodWidth]);
        for (zOffset =[0:woodWidth*2:beehiveDimensions.z])
            translate([beehiveDimensions.x-woodWidth,0,zOffset])
                cube([woodWidth,woodWidth,woodWidth]);
        
        //handle holes
        hull()
        {
            translate([4*in2mm,woodWidth,beehiveDimensions.z-4*in2mm])
                rotate([90,0,0])    
                    cylinder(r1=in2mm,r2=in2mm, h=woodWidth);
            translate([beehiveDimensions.x-4*in2mm,woodWidth,beehiveDimensions.z-4*in2mm])
                rotate([90,0,0])    
                    cylinder(r1=in2mm,r2=in2mm, h=woodWidth);
        }
    }
}

module beehive(){
    //translate([woodWidth,beehiveDimensions.y,0])rotate([0,0,180])handleSide();
    //translate([beehiveDimensions.x-woodWidth,0,0])handleSide();
    hiveFront();
    translate([0,beehiveDimensions.y-woodWidth,0])
        hiveFront();
}


//handleSide();

beehive();
//projection(cut=false)translate([beehiveDimensions.z,0,0])rotate([0,-90,0])handleSide();
//projection(cut=false)translate([beehiveDimensions.z,0,0])rotate([-90,0,90])hiveFront();