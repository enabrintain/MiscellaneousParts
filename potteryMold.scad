$fn=180;

in2mm = 25.4;
/*
//bowl /w rounded bottom
difference()
{
    translate([0,0,in2mm])
    minkowski()
    {
        cylinder(r1=3*in2mm, r2=4*in2mm, h=3*in2mm);
        sphere(r=1*in2mm);
    }
    translate([-10*in2mm/2,-10*in2mm/2,3.7*in2mm])cube([10*in2mm, 10*in2mm, 2*in2mm]);
}

//bowl footer
rotate_extrude(convexity = 10, $fn = 100)
    translate([3*in2mm, 0, 0])
        circle(r = in2mm/8);
*/

PP=[[0,0],
    [(2+3/8)*in2mm,0*in2mm],
    [2.75*in2mm,.25*in2mm],
    [(2+5/8)*in2mm,3/8*in2mm],
    [(2.25)*in2mm,.75*in2mm],
    [4*in2mm,6*in2mm],
    [0,6*in2mm]];

//rotate_extrude($fn=200)
minkowski()
{
    polygon( points=PP );
    circle(d=.25*in2mm);
}