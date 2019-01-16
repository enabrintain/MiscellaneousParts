$fn = 90;

in2mm = 25.4;

tripodDai = (1+3/8)*in2mm+1; 
mountHeight = 1.75*in2mm;
wallThickness = .25*in2mm;

mountHoleDistance = (2+5/8)*in2mm+2;
mountX = (3.5)*in2mm;
mountHoleDia = 1/8*in2mm+.5;
mountHoledepth = (1.625)*in2mm;

module center_tube()
{
    cylinder(d=tripodDai, h=mountHeight);
}



module mount()
{
    difference()
    {
        hull(){
            cylinder(d=tripodDai+2*wallThickness, h=mountHeight+wallThickness);
            translate([-mountX/2, (tripodDai+2*wallThickness)/2, 0])cube([mountX,1,mountHeight+wallThickness]);
            
        translate([-(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia+wallThickness, h=mountHoledepth+wallThickness);
        translate([(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia+wallThickness, h=mountHoledepth+wallThickness);
        }
        translate([0,0,-0.01])center_tube();
        //hole
        translate([-(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia, h=mountHoledepth);
        translate([(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia, h=mountHoledepth);
        
    }
}

mount();