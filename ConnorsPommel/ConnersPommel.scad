/**
    This is a pommel for a buster sword designed in collabortion with Conner Roberson.
    
    Copyright (C) 2018 Phillip Showers and Conner Roberson
    This model is released under the Creative Commons Attribution/Share Alike license.
    Attribute me if you use it. 
    Share it like I shared it.
    https://creativecommons.org/licenses/by-sa/4.0/

    Feel free to make money on it! If you want, donate some to www.fsf.org.
**/

$fn = 180;

hollowD = 38;
mainD = 46;
overallL = 10;
difference(){
    union(){overallL
        cylinder(d=mainD, h=);
        scale([1,1,1.5])
        sphere(d=mainD-5);
    }
    cylinder(d=hollowD, h=100);
    translate([-mainD/2,-mainD/2,-mainD+8])
        cube([mainD,mainD,10]);
    translate([-mainD/2,-mainD/2,overallL])
        cube([mainD,mainD,10]);
}