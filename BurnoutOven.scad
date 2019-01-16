$fn = 180;

in2mm = 25.4;

stdBrick = [4.5*in2mm,9*in2mm,2.5*in2mm];
vol = [10*in2mm, 13.5*in2mm, 9*in2mm];

module brick(x=stdBrick.x, y=stdBrick.y, z=stdBrick.z)
{
    cube([x,y,z]);
}

// currently 30 bricks needed.


//base = 4
brick();
translate([stdBrick.x,0,0])brick();
translate([stdBrick.x*2,0,0])brick();
translate([stdBrick.x*3,0,0])brick(x=1.5*in2mm);
//cut off 1.5" from a block, leaving a remainder block of 3"
//color("red")translate([stdBrick.x*3+in2mm*1.5,0,0])brick(stdBrick.x-in2mm*1.5, y=stdBrick.y, z=stdBrick.z);

//top = 4
translate([0,0,stdBrick.z+vol.z])brick();
translate([stdBrick.x,0,stdBrick.z+vol.z])brick();
translate([stdBrick.x*2,0,stdBrick.z+vol.z])brick();
translate([stdBrick.x*3,0,stdBrick.z+vol.z])brick(x=1.5*in2mm);
//cut off 1.5" from a block, leaving a remainder block of 3"
//color("red")translate([stdBrick.x*3+in2mm*1.5,0,0])brick(stdBrick.x-in2mm*1.5, y=stdBrick.y, z=stdBrick.z);

//left side = 2
translate([stdBrick.z,0,stdBrick.z])rotate([0,-90,0])brick();
translate([stdBrick.z,0,stdBrick.z+stdBrick.x])rotate([0,-90,0])brick();

//right side = 2
translate([vol.x+stdBrick.z*2,0,stdBrick.z])rotate([0,-90,0])brick();
translate([vol.x+stdBrick.z*2,0,stdBrick.z+stdBrick.x])rotate([0,-90,0])brick();

//back extension base = 2
translate([0,stdBrick.y+stdBrick.x,0])rotate([0,0,-90])brick();
translate([stdBrick.y,stdBrick.y+stdBrick.x,0])rotate([0,0,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);
//back extension top = 2
translate([0,stdBrick.y+stdBrick.x,stdBrick.z+vol.z])rotate([0,0,-90])brick();
translate([stdBrick.y,stdBrick.y+stdBrick.x,stdBrick.z+vol.z])rotate([0,0,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);
//back extension sides = 2
translate([stdBrick.z,stdBrick.y+stdBrick.x,stdBrick.z])rotate([90,0,-90])brick();
translate([stdBrick.z*2+vol.x,stdBrick.y+stdBrick.x,stdBrick.z])rotate([90,0,-90])brick();


//back wall = 6
translate([0,vol.y,0])rotate([0,-90,-90])brick();
translate([stdBrick.y,vol.y,0])rotate([0,-90,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);
translate([0,vol.y,stdBrick.x])rotate([0,-90,-90])brick();
translate([stdBrick.y,vol.y,stdBrick.x])rotate([0,-90,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);
translate([0,vol.y,stdBrick.x*2])rotate([0,-90,-90])brick();
translate([stdBrick.y,vol.y,stdBrick.x*2])rotate([0,-90,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);


//front wall = 6
translate([0,-stdBrick.z,0])rotate([0,-90,-90])brick();
translate([stdBrick.y,-stdBrick.z,0])rotate([0,-90,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);
translate([0,-stdBrick.z,stdBrick.x])rotate([0,-90,-90])brick();
translate([stdBrick.y,-stdBrick.z,stdBrick.x])rotate([0,-90,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);
translate([0,-stdBrick.z,stdBrick.x*2])rotate([0,-90,-90])brick();
translate([stdBrick.y,-stdBrick.z,stdBrick.x*2])rotate([0,-90,-90])brick(x=stdBrick.x, y=stdBrick.y-in2mm*3);


//translate([stdBrick.z,0,stdBrick.z])color("green")cube(vol);