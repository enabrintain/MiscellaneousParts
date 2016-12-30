/*
Copyright (c) 2016 Phillip Showers
Licensed under the
Creative Commons Attribution-ShareAlike 4.0 International
for full text, please visit
https://creativecommons.org/licenses/by-sa/4.0/legalcode

Summary:
    Share — copy and redistribute the material in any medium or format
    Adapt — remix, transform, and build upon the material for any purpose, even commercially.
The licensor cannot revoke these freedoms as long as you follow the license terms.
*/

$fn=90;
in2mm = 25.4;

module roundedCube(size)
{
    c = 0.25*in2mm;
    hull(){
        translate([c/2,c/2,c/2])sphere(d=c);
        translate([size.x-c/2,c/2,c/2])sphere(d=c);
        translate([size.x-c/2,size.x-c/2,c/2])sphere(d=c);
        translate([c/2,size.x-c/2,c/2])sphere(d=c);
        translate([c/2,c/2,size.x-c/2])sphere(d=c);
        translate([size.x-c/2,c/2,size.x-c/2])sphere(d=c);
        translate([size.x-c/2,size.x-c/2,size.x-c/2])sphere(d=c);
        translate([c/2,size.x-c/2,size.x-c/2])sphere(d=c);
    }
}

module endPiece(size)
{
    c = 0.25*in2mm;
    hull(){
        rotate([0,90,0])cylinder(d = size.x, h=0.5*in2mm);
        translate([size.x*1.5,-size.x/2*.75,-c/2])cube([c,size.x*.75,c]);
    }
}

module sandRammer(a)
{
    translate([6*in2mm,0,0])endPiece([a*in2mm, a*in2mm, a*in2mm]);
    translate([0,-in2mm*a/2,-in2mm*a/2])roundedCube([a*in2mm, a*in2mm, a*in2mm]);
    translate([3.75*in2mm, 0, 0])scale([5,1,1])sphere(d=a*in2mm*.75);
}

module top()
{
    a=10*in2mm;
    difference()
    {
        sandRammer(1.5);
        translate([-1,-a/2,-a])cube([a,a,a]);
        translate([.75*in2mm,0,0])cylinder(d=.25*in2mm, h=.5*in2mm);
        translate([6.5*in2mm,0,0])cylinder(d=.25*in2mm, h=.5*in2mm);
        
    }
}

//top();
//cylinder(d=.25*in2mm*.95, h=.95*in2mm);
sandRammer(1.5);