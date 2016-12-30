// Phillip Showers
// CC - GNU

$fn = 45;

in2mm=25.4;

adjustment=.5;
alSide = in2mm+adjustment;
adSideCuts = .25*in2mm-adjustment;

moduleHeight = .5*in2mm;

module aluminium8020()
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

module linearBearing(){
    difference(){
        cube([1.25*in2mm, 1.25*in2mm, moduleHeight]);
        translate([1/8*in2mm,1/8*in2mm,0])aluminium8020();
        translate([(in2mm/4), (in2mm/4),])cube([.75*in2mm, .75*in2mm, moduleHeight]);
    }
}






motorMount();
module motorMount(){
    
    
}


aluminium8020();
