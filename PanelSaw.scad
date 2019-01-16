// Title: Open Source Panel Saw
// License: This is design is in the public domain
// Author: Phil Showers

// Global Variables
$fn = 90;
in2mm=25.4;
plywoodSheet = [48*in2mm, 96*in2mm, .75*in2mm];
2x4 = [3.5*in2mm,92*in2mm,1.5*in2mm];




translate([0,0,2x4.x])
    union(){
        rotate([80,0,0])cube(plywoodSheet);
        rotate([-10,0,0])translate([-plywoodSheet.x/2,0,plywoodSheet.x])rotate([90,90,0])color("blue")cube(plywoodSheet);
}
