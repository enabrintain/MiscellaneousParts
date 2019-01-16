
// Version 1 - Brian Bousman 6/30/2017
//    Modified the Vive mount to be a camera mount that slips
//    over the end of the tripod mount and has a mount screw
//    at the top.

$fn = 90;

in2mm = 25.4;

tripodDai = (1+3/8)*in2mm+1; 
mountHeight = 2.0*in2mm;
wallThickness = .25*in2mm;
topwallThickness = 12;

//mountHoleDistance = (2+5/8)*in2mm+4;
mountHoleDistance = 65;    // measured with calipers
mountX = (3.5)*in2mm;
mountHoleDia = 1/8*in2mm+.5;
mountHoledepth = (1.625)*in2mm;
tensionHoleDia = 6.0;

cameraHoleDia = 6.5;
ctrsinkdepth = 8;
ctrsinkdia = 32;


module center_tube()
{
    cylinder(d=tripodDai, h=mountHeight);
}



module mount()
{
    difference()
    {
        // main cylinder body
        #cylinder(d=tripodDai+2*wallThickness, h=mountHeight+topwallThickness);
        
        // hole in center for tripod pole
        translate([0,0,-0.01])center_tube();
        
        // tension screw hole
        translate([0,-(tripodDai+2*wallThickness)/2,mountHeight/2])rotate([90,0,-180])cylinder(d=tensionHoleDia, h=mountHoledepth);

        // camera mount screw hole
        translate([0,0,mountHeight-0.1])cylinder(d=cameraHoleDia, h=wallThickness*2);
        // counter sink the screw hole
        color("white")translate([0,0,mountHeight-0.1])cylinder(d1=ctrsinkdia+1, d2=ctrsinkdia, h=ctrsinkdepth);
    }
}

mount();