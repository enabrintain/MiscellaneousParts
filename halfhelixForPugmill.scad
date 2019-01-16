
// with twist the extruded shape will rotate around the Z axis
$fn=180;

in2mm = 25.4;
shaftDia = 1.5*in2mm;

scaleFactor = 3/2.73;

//difference()
{
    //hull()
    {
        scale([scaleFactor, scaleFactor, scaleFactor])
            linear_extrude(height = 3.75*in2mm, twist = 180)
            translate([-(3*in2mm/2 + shaftDia/2) , 0, 0])
                square([3*in2mm, .01], center = true);
        /*translate([0, 0, 0])
            linear_extrude(height = .01, twist = 180)
            translate([-(3*in2mm/2 + shaftDia/2) , 0, 0])
                square([3*in2mm, .01], center = true);*/
    }

    //cylinder(d=shaftDia, h=3.75*in2mm);
}