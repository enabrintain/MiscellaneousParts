$fn = 45;


in2mm = 25.4;
extrusion = [20,20,13.5*in2mm];
extrusion2 = [20,20,23*in2mm];
rod = [8,8,13*in2mm];

//translate([0,0,extrusion.x])
rotate([0,90,0])
cube(extrusion);

color("blue")
//translate([0,0,extrusion.x])
cube(extrusion2);

translate([sin(45)*rod.z + extrusion2.x,extrusion.x/2,0])
rotate([0,-45,0])
cylinder(d=rod.x, rod.z);


module mount()
{
    difference()
    {
        union(){
            cube([extrusion.x*3,extrusion.y,5]);
            hull(){
                translate([extrusion.x*2+4,2,15])
                    sphere(r=2);
                translate([extrusion.x*2+4,extrusion.x-2,15])
                    sphere(r=2);
                translate([extrusion.x-4,2,15])
                    sphere(r=2);
                translate([extrusion.x-4,extrusion.x-2,15])
                    sphere(r=2);
                
                translate([extrusion.x-8,0,0])
                    cube([extrusion.x+16,extrusion.x,1]);
            }
        }
        translate([2+6,extrusion.x/2,0])
            cylinder(d=4, h=6);
        translate([extrusion.x*3-(2+6),extrusion.x/2,0])
            cylinder(d=4, h=6);
    }
    
    
}

translate([sin(45)*rod.z - extrusion2.x,0,0])
    mount();
