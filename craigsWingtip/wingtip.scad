


$fn=180;
in2mm = 25.4;
screwD = 7/64*in2mm;
holeD = 12.7;
centerXOffset = sqrt(pow((in2mm/2),2) + pow(44.2,2)) + 16.3;


module holes()
{
    //upper hole
    translate([16.3,in2mm/2,0])
        cylinder(d=screwD, h=in2mm);
    
    //lower hole
    translate([16.3,-in2mm/2,0])
        cylinder(d=screwD, h=in2mm);
    
    //tail hole
    translate([centerXOffset,0,0])
        cylinder(d=screwD, h=in2mm);

    //center hole
    cylinder(d=holeD, h=10);
    
}

maxWidth = 50;
minWidth = 24;
module beacon()
{
    
    //50 wide
    //100 length
    difference(){
        hull(){
        translate([0,0,0])
            cylinder(d=maxWidth, h=in2mm/4);        
        translate([17,0,0])
            cylinder(d=maxWidth, h=in2mm/4);
        translate([centerXOffset,0,0])
            cylinder(d=minWidth, h=in2mm/4);
            
        }
        holes();
    }
}
translate([0,0,-in2mm])
difference(){
    
    translate([0,-1.5*in2mm,0])
        cube([4*in2mm, 3*in2mm, in2mm]);
    
    translate([4*in2mm-32,in2mm/2,0])
        cylinder(d=screwD, h=in2mm);

    translate([4*in2mm-32,-in2mm/2,0])
        cylinder(d=screwD, h=in2mm);
    
    //center hole
    translate([4*in2mm-32-16.3, 0, 0])    
        cylinder(d=holeD, h=in2mm);
    
    translate([4*in2mm-9,-1.5*in2mm,0])
        rotate([0,-90+19.511,0])
            translate([0,0,-in2mm])
                cube([4*in2mm, 3*in2mm, in2mm]);
    
    translate([0,-1.5*in2mm,0])
        rotate([0,-45,0])
            translate([0,0,0])
                cube([4*in2mm, 3*in2mm, in2mm]);
}
    
    
    
   
    
    
    
translate([4*in2mm-32-16.3, 0, 0])    
beacon();
    
    
    
    
    
    
    
    