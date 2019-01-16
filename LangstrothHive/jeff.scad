
in2mm=25.4;
beehiveDimensions = [(19+7/8) * in2mm, 16.25 * in2mm, (9+5/8) * in2mm];
woodWidth = 3/4*in2mm;

//cube([beehiveDimensions.x,woodWidth,beehiveDimensions.z]);

color(["blue"])
//
for (i=[woodWidth, woodWidth, beehiveDimensions.z])
  translate([0,0,i])
{
    //echo(i);
    echo(i*2);
    cube([woodWidth,woodWidth,woodWidth]);
}