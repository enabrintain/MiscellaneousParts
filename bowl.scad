$fn=180;

in2mm = 25.4;
rounding = 1*in2mm;
//bowl /w rounded bottom
/*difference()
{
    translate([0,0,in2mm])
    union(){
        minkowski()
        {
            cylinder(r1=2*in2mm-rounding, r2=3*in2mm-rounding, h=2*in2mm);
            sphere(r=rounding);
        }
        //bowl footer
        translate([0,0,-in2mm+2])
        rotate_extrude(convexity = 10, $fn = 100)
            translate([1.25*in2mm, 0, 0])
                circle(r = in2mm/8);
    }
    
    translate([-10*in2mm/2,-10*in2mm/2,2.7*in2mm])cube([10*in2mm, 10*in2mm, 2*in2mm]);
    
    translate([0,0,2+rounding])
    minkowski()
    {
        cylinder(r1=2*in2mm-rounding-2, r2=3*in2mm-rounding-2, h=2*in2mm);
        sphere(r=1*in2mm);
    }
}*/

//a different bowl
module bowl(r1=50*in2mm, r2=3*in2mm, h=2.75*in2mm)
{
    //difference()
    union()
    {
    translate([0,0,r2/2-3.18])
        difference(){
            scale([1,1,h/r2/2])sphere(r=r2);
            translate([-r2,-r2,0])cube(r2*2,r2*2, h);
        }
    
    
    translate([0,0,h/2-1])cylinder(r=r2, h=h/2);
    translate([0,0,h/2+h/4])cylinder(r1=r2, r2=r2+in2mm/8, h=h/4);
    }
    //translate([-5, -5, 0])cube([10, 10 , h]);
}

difference()
{
    union()
    {
        bowl();
        translate([0,0,in2mm/16+1.5])
            rotate_extrude(convexity = 10)
                    translate([1.5*in2mm, 0, 0])
                        union(){
                        circle(r = in2mm/8);
                            translate([0,0,0])square([in2mm/8, in2mm/8]);
                        }
    }
    translate([0,0,2])bowl(r1=1.5*in2mm-1, r2=3*in2mm-1, h=2.75*in2mm);
}













