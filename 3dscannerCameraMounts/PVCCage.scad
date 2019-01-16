$fn = 90;
in2mm = 25.4;
f2mm = 12*in2mm;

pvcWallThickness = 1/8*in2mm;

module pvc(d=in2mm, len = 1*f2mm, on=false)
{
    if(on)
        difference(){
            cylinder(d=d, h=len);
            translate([0,0,-.005])//silly trick to make preview prettier
                cylinder(d=d-pvcWallThickness*2, h=len+.01);
        }
    else
        cylinder(d=d, h=len);
        
}


module octagon(d = 8*f2mm)
{
    //d=(1 + √2)s -> thanks pythagoras
    s = d/(1+sqrt(2));
    
    translate([-s/2,0,0])rotate([0,90,0])pvc(len=s); //bottom
    translate([s/2,0,0])rotate([0,90,45])pvc(len=s); //bottom-right
    translate([d/2,s/sqrt(2),0])rotate([0,90,90])pvc(len=s); //right
    translate([d/2,s/sqrt(2)+s,0])rotate([0,90,135])pvc(len=s);//top-right
    translate([-s/2,d,0])rotate([0,90,0])pvc(len=s); //top
    translate([-s/2,d,0])rotate([0,90,225])pvc(len=s);//top-left
    translate([-d/2,s/sqrt(2),0])rotate([0,90,90])pvc(len=s); //left
    translate([-s/2,0,0])rotate([0,90,135])pvc(len=s); //left-bottom
}

module cage()
{
    d=10*f2mm;
    
    translate([0,0,in2mm])octagon(d);// base
    translate([0,0,2*f2mm])octagon(d);// bottom
    translate([0,0,4.5*f2mm])octagon(d);// middle
    translate([0,0,7.5*f2mm])octagon(d);// top
    
    s = d/(1+sqrt(2));
    echo(s/f2mm);//each side piece in ft
    echo(s/f2mm*8);// pvc for a whole octagon in ft
    echo(s/f2mm*8*4);// pvc for all 4 octagons in ft
    echo((s*8*4 + 8*(7.5*f2mm))/f2mm);// pvc for all 4 octagons + verticals in ft
    
    translate([-s/2,0,0])pvc(len=7.5*f2mm);
    translate([s/2,0,0])pvc(len=7.5*f2mm);
    translate([d/2,s/sqrt(2),0])pvc(len=7.5*f2mm);
    translate([d/2,s/sqrt(2)+s,0])pvc(len=7.5*f2mm);
    translate([s/2,d,0])pvc(len=7.5*f2mm);
    translate([-s/2,d,0])pvc(len=7.5*f2mm);
    translate([-d/2,d-s/sqrt(2),0])pvc(len=7.5*f2mm);
    translate([-d/2,s/sqrt(2),0])pvc(len=7.5*f2mm);
}

cage();

translate([0,5*f2mm,0])cylinder(r=f2mm, h=6.3*f2mm);


module joint(){
    difference(){
        union(){
            cylinder(d=1.5*in2mm, h=3*in2mm);
            hull(){
            translate([0,0,1.5*in2mm])rotate([0,90,0])cylinder(d=1.5*in2mm, h=2*in2mm);
            translate([0,0,1.5*in2mm])rotate([0,90,135])cylinder(d=1.5*in2mm, h=2*in2mm);
            }
            
            hull(){
            cylinder(d=1.5*in2mm, h=3*in2mm);
            translate([0,0,1.5*in2mm])rotate([0,90,0])cylinder(d=1.5*in2mm, h=2*in2mm);
            }
            
            
            hull(){
            cylinder(d=1.5*in2mm, h=3*in2mm);
            translate([0,0,1.5*in2mm])rotate([0,90,135])cylinder(d=1.5*in2mm, h=2*in2mm);
            }
        }
        translate([0,0,-0.005])pvc(len=3*in2mm+.01);
        translate([0,0,1.5*in2mm])rotate([0,90,0])pvc(len=3*in2mm+.01);
        translate([0,0,1.5*in2mm])rotate([0,90,135])pvc(len=3*in2mm+.01);
        //screwhole
        translate([0,0,1.5*in2mm])rotate([0,90,-135+45/2])cylinder(d=4, h=30);
    }
}


//will need 32 of these
joint();






