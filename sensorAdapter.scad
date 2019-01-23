/*
Copyright 2019 Phil Showers

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

https://opensource.org/licenses/MIT
*/

$fn=90;


mountHoleDiameter = 12;
mountThickness = 3.5;
sensorDiameter = 7.2;
sensorLength = 30;
adapterDiameter = 11;

module model()
{
    mount();
    adapter();
}

module mount()
{
    // mount plate
    difference(){
        translate([-15,-15,0])cube([30, 30, mountThickness]);
        cylinder(d = mountHoleDiameter, h = mountThickness+.1);
    }
} 

// this is the thing to print...
module adapter()
{
    difference(){
        union(){
            translate([0,0,-mountThickness])cylinder(d = mountHoleDiameter + 4, h = mountThickness);
            translate([0,0,0])cylinder(d = adapterDiameter, h = sensorLength);
        }
        //sensor hole
        translate([0,0,-mountThickness])cylinder(d = sensorDiameter, h = sensorLength+mountThickness);
    }
}

//model();

rotate([180,0,0])translate([0,0,mountThickness])adapter();
