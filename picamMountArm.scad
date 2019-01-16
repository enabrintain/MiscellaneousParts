$fn=180;

stubwidth = 12;
stublength = 19;
stubheigth = 8;
stubholediameter = 3;

armtabthickness = 4;
armlength = 25;

module stub(){
    difference(){
        hull(){
            translate([-stubwidth/2,0,0])
                cube([stubwidth, 1, stubheigth]);
            translate([-stubwidth/2,stublength-stubheigth/2,stubheigth/2])
                rotate([0,90,0])
                    cylinder(d=stubheigth, h=stubwidth);
        }
        translate([-stubwidth,stublength-stubheigth/2,stubheigth/2])
            rotate([0,90,0])
                cylinder(d=stubholediameter, h=stubwidth*2);
    }
}
//translate([0,armlength+stublength-stubheigth/2,0])rotate([0,0,180])stub();

module mountArm(){
    //plate
    translate([-(stubwidth+(armtabthickness*2))/2,armlength-stubheigth*.75-armtabthickness,-(stubheigth*1.5-stubheigth)/2])
        cube([stubwidth+(armtabthickness*2),armtabthickness,stubheigth*1.5]);
    //right side
    hull(){
    translate([stubwidth/2,armlength-stubheigth*.75,-(stubheigth*1.5-stubheigth)/2])
        cube([armtabthickness,1,stubheigth*1.5]);
    translate([stubwidth/2,armlength,stubheigth/2])
        rotate([0,90,0])
            cylinder(d=stubheigth*1.5, h=armtabthickness);
    }
    translate([stubwidth/2,armlength,stubheigth/2])
    rotate([0,-90,0])
    cylinder(d1=stubholediameter+1, d2=1, h=stubholediameter/2);
    
    //left side
    hull(){
    translate([-armtabthickness-stubwidth/2,armlength-stubheigth*.75,-(stubheigth*1.5-stubheigth)/2])
        cube([armtabthickness,1,stubheigth*1.5]);
    translate([-armtabthickness-stubwidth/2,armlength,stubheigth/2])
        rotate([0,90,0])
            cylinder(d=stubheigth*1.5, h=armtabthickness);
    }
    translate([-stubwidth/2,armlength,stubheigth/2])
        rotate([0,90,0])
            cylinder(d1=stubholediameter+1, d2=1, h=stubholediameter/2);
    
    difference(){
        union(){
            //arm cylinder
            translate([0,0,stubheigth/2])
                rotate([-90,0,0])
                    cylinder(d=stubheigth, h=armlength-stubheigth*.75-armtabthickness+1);
            //back tab
            translate([0,stubheigth/2,0])
                    cylinder(d=stubheigth*1.5, h=stubheigth);
        }
        //back tab hole
        translate([0,stubheigth/2,-stubheigth/2])
                cylinder(d=stubholediameter, h=stubheigth*2);
    }
}

mountArm();




