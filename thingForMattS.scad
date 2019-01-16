$fn=180;

in2mm = 25.4;
widestPartOfArm = in2mm/4;

module crossPiece(length, height)
{
    hull()
    {
        translate([-length/2, 0, 0])cube([length, .1, .1]);
        translate([0, -widestPartOfArm/2, 0])cube([.1, widestPartOfArm, .1]);
        translate([0, 0, 0])cube([.1, .1, height]);
    }
}

union(){
    crossPiece(in2mm, in2mm/8);
    rotate([0,0,90])crossPiece(in2mm, in2mm/8);
}