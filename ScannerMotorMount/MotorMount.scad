use <8020.scad>

//note: accelstepper lib

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
/*
union(){
kinectBase();
translate([87-1.25*in2mm,73,0])linearBearing(1.5*in2mm);
}
hh = 12*in2mm;
translate([87-1.25*in2mm,73,-hh/2])translate([1/8*in2mm,1/8*in2mm,0])aluminium8020(hh);
*/
module motor(){
    cylinder(d=28, h=19.3);
    difference(){
        hull(){
            translate([21-7/2,0,19.3-.8])cylinder(d=7, h=.8);
            translate([-21+7/2,0,19.3-.8])cylinder(d=7, h=.8);
        }
        translate([21-7/2,0,19.3-.9])cylinder(d=4, h=1);
        translate([-21+7/2,0,19.3-.9])cylinder(d=4, h=1);
    }
    translate([0,-7.9,0])cylinder(d=9.2, h=20.58);
    difference(){
        translate([0,-7.9,0])cylinder(d=5, h=29);
        translate([-2.5,-7.9+2.5-1,29-.25*in2mm])cube([5,5,.25*in2mm]);
        translate([-2.5,-7.9-7.5+1,29-.25*in2mm])cube([5,5,.25*in2mm]);
    }
}

module topMotorMount(){
    union(){
        translate([0,0,0])cube([1.25*in2mm,1.25*in2mm,.25*in2mm]);
        translate([0,0,-0.5*in2mm])linearBearing(0.5*in2mm);
        //translate([1.25*in2mm/2,1.25*in2mm-19.3+.8,28/2+(.25*in2mm)])rotate([90,0,180])motor();
        difference(){
            hull(){
                translate([-1/4*in2mm,1.25*in2mm-10,24])cube([1.75*in2mm,10,1]);
                translate([0,1.25*in2mm-10,(.25*in2mm)])cube([1.25*in2mm,10,1]);
            }
            translate([(1+1/4)*in2mm/2,1.25*in2mm-19.3+.8,28/2+(.25*in2mm)])rotate([90,0,180])cylinder(d=28, h=19.3);
                    translate([(1+1/4)*in2mm/2,1.25*in2mm-19.3+.8,2])translate([21-7/2,0,19.3-.9])rotate([90,0,180])cylinder(d=4, h=20);
            translate([(1+1/4)*in2mm/2,1.25*in2mm-19.3+.8,2])translate([-21+7/2,0,19.3-.9])rotate([90,0,180])cylinder(d=4, h=20);
        }
    }
}
//translate([87-1.25*in2mm,73,hh/2])
topMotorMount();
//translate([87-1.25*in2mm,73,hh/2])rotate([90,0,180])motor();