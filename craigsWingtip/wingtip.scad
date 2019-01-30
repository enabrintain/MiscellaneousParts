/*
Copyright 2019 Phillip Showers

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


$fn=180;
in2mm = 25.4;
screwD = .15*in2mm;
holeD = 3/4*in2mm;
centerXOffset = sqrt(pow((in2mm/2),2) + pow(44.2,2)) + 16.3;

maxWidth = 50;
minWidth = 24;
    
minX = 0;
maxX = 1.5*in2mm;
minY = 1.125*in2mm;
maxY = 1.25*in2mm;

mountH = .9*in2mm;
mountPts = [ [maxX,-maxY], [maxX,maxY], [minX,minY], [minX,-minY],];

CubePoints = [
  [ maxX,-maxY,  0 ],  //0
  [ maxX,maxY,  0 ],  //1
  [ minX,minY,  0 ],  //2
  [ minX,-minY,  0 ],  //3
  [ maxX+13,-.55*in2mm,mountH ],  //4
  [ maxX+13,.55*in2mm,mountH],  //5
  [ minX,minY,mountH],  //6
  [ minX,-minY,mountH]];  //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  

module holes()
{
    //upper hole
    translate([16.3,in2mm/2,0])
        cylinder(d=screwD, h=in2mm);
    
    //lower hole
    translate([16.3,-in2mm/2,0])
        cylinder(d=screwD, h=in2mm);
    
    //tail hole
    translate([centerXOffset,0,0])
        cylinder(d=screwD, h=in2mm);

    //center hole
    cylinder(d=holeD, h=in2mm);
    
}

module beacon()
{
    
    //50 wide
    //100 length
    difference(){
        hull(){
        translate([0,0,0])
            cylinder(d=maxWidth, h=in2mm/8);        
        translate([17,0,0])
            cylinder(d=maxWidth, h=in2mm/8);
        translate([centerXOffset,0,0])
            cylinder(d=minWidth, h=in2mm/8);
            
        }
        holes();
    }
}

module mount(){
    difference(){
        
        translate([0,-1.5*in2mm,0])
            cube([4*in2mm, 3*in2mm, in2mm]);
        
        translate([4*in2mm-32,in2mm/2,0])
            cylinder(d=screwD, h=in2mm);

        translate([4*in2mm-32,-in2mm/2,0])
            cylinder(d=screwD, h=in2mm);
        
        //center hole
        translate([4*in2mm-32-16.3, 0, 0])    
            cylinder(d=holeD, h=in2mm);
        
        //front 
        translate([4*in2mm-9,-1.5*in2mm,0])
            rotate([0,-90+19.511,0])
                translate([0,0,-in2mm])
                    cube([4*in2mm, 3*in2mm, in2mm]);
        
        //back
        translate([0,-1.5*in2mm,0])
            rotate([0,-45,0])
                translate([0,0,0])
                    cube([4*in2mm, 3*in2mm, in2mm]);
    }
}

module mount1(){
    
    difference(){
        hull(){
            polyhedron( CubePoints, CubeFaces );
            cylinder(d=2.25*in2mm, h = mountH);
        }
        holes();
    }
}
    
translate([0, 0,mountH])beacon();
mount1();
