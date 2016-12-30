

in2mm=25.4;

adjustment=.5;
alSide = in2mm+adjustment;
adSideCuts = .25*in2mm-adjustment;

module aluminium8020(moduleHeight)
{
    difference(){
        cube([alSide, alSide, moduleHeight]);
        
        translate([alSide/2-(adSideCuts/2),0,0]) 
            cube([adSideCuts, adSideCuts, moduleHeight]);
        translate([alSide/2-(adSideCuts/2),alSide-adSideCuts,0])
            cube([adSideCuts, adSideCuts, moduleHeight]);
        translate([0,alSide/2-(adSideCuts/2),0])
            cube([adSideCuts, adSideCuts, moduleHeight]);
        translate([alSide-adSideCuts,alSide/2-(adSideCuts/2),0])
            cube([adSideCuts, adSideCuts, moduleHeight]);
    }
}

module linearBearing(height){
    difference(){
        cube([1.25*in2mm, 1.25*in2mm, height]);
        translate([1/8*in2mm,1/8*in2mm,0])aluminium8020(height);
        translate([(in2mm/4), (in2mm/4),])cube([.75*in2mm, .75*in2mm, height]);
    }
}




linearBearing(.5*in2mm);