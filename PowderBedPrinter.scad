/*
    this is a design for a powderbed printer
    
    Author: Phil Showers
    License: MIT or CC

*/

in2mm=25.4;

materialThickness=in2mm/4;
spillGap = in2mm;
tabZ = in2mm;
printEnvelope = [12*in2mm, 12*in2mm, 14*in2mm];

//translate([spillGap+materialThickness*2,0,0])cube(printEnvelope);
//translate([printEnvelope.x+materialThickness*3+spillGap,0,0])cube(printEnvelope);

module frontAndBackPart()
{
    difference()
    {
        cube([printEnvelope.x*2+materialThickness*5+spillGap*2, materialThickness, printEnvelope.z]);
    
        for (zOffset =[0:(printEnvelope.z-tabZ)/4:printEnvelope.z])
        {
            //left side
            translate([0,0,zOffset])
                cube([materialThickness, tabZ, tabZ]);
            
            //left spillgap
            translate([spillGap+materialThickness,0,zOffset])
                cube([materialThickness, tabZ, tabZ]);
            
            
            //ceter
            translate([printEnvelope.x+materialThickness*2+spillGap,0,zOffset])
                cube([materialThickness, tabZ, tabZ]);
            
            
            //right spillgap
            translate([printEnvelope.x*2+materialThickness*3+spillGap,0,zOffset])
                cube([materialThickness, tabZ, tabZ]);
            
            //right side
            translate([printEnvelope.x*2+materialThickness*4+spillGap*2,0,zOffset])
                cube([materialThickness, tabZ, tabZ]);
            
        }
    }
}

frontAndBackPart();


module side()
{
    
    translate([0,materialThickness,0])
        cube([materialThickness, printEnvelope.y, printEnvelope.z]);
    
    for (zOffset =[0:(printEnvelope.z-tabZ)/4:printEnvelope.z])
    {
        translate([0,0,zOffset])
            cube([materialThickness, tabZ, tabZ]);
        translate([0,printEnvelope.y-tabZ+materialThickness*2,zOffset])
            cube([materialThickness, tabZ, tabZ]);
    }
}

//side();