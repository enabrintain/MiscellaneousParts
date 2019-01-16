$fn=180;
pvcDia = 27;
clampThickness = 4;
clampH = 19;


stubheigth = 8;
armtabthickness = 4;
armlength = 25;
stubholediameter = 3;

difference(){
cylinder(d=pvcDia+clampThickness*2, h=clampH);
translate([0,0,-clampH/2])cylinder(d=pvcDia, h=clampH*2);
    
translate([-clampThickness*.5,-pvcDia/2-clampThickness,0])cube([clampThickness,clampThickness*2,clampH]);
}
difference(){
translate([-clampThickness*1.5,-pvcDia/2-clampThickness-3,0])cube([clampThickness,4,clampH]);
rotate([0,0,20])translate([-clampThickness*4,-pvcDia/2-clampThickness-2,0])cube([clampThickness*3,4,clampH]);
}
translate([clampThickness*.5,-pvcDia/2-clampThickness-3,0])cube([clampThickness,4,clampH]);

module armTab()
{
    difference(){
        union(){
            //back tab
            translate([0,0,0])cylinder(d=stubheigth*1.5, h=stubheigth);
        }
        //back tab hole
        translate([0,0,-stubheigth/2])
                cylinder(d=stubholediameter, h=stubheigth*2);   
    }
}
translate([0,pvcDia/2+clampThickness+stubheigth*.75,(clampH-stubheigth)/2])
armTab();