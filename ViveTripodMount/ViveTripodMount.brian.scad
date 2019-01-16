// Version 2 - Brian Bousman 6/22/2017
//      slight modification of Phil's original to move mounting screws closer together
//      and add a tension screw at the back

$fn = 90;

in2mm = 25.4;

tripodDai = (1+3/8)*in2mm+1; 
mountHeight = 1.75*in2mm;
wallThickness = .25*in2mm;

//mountHoleDistance = (2+5/8)*in2mm+4;
mountHoleDistance = 65;    // measured with calipers
mountX = (3.5)*in2mm;
mountHoleDia = 1/8*in2mm+.5;
mountHoledepth = (1.625)*in2mm;
tensionHoleDia = 6;

module center_tube()
{
    cylinder(d=tripodDai, h=mountHeight);
}



module mount()
{
    difference()
    {
        hull()
        {
            cylinder(d=tripodDai+2*wallThickness, h=mountHeight+wallThickness);
            translate([-mountX/2, (tripodDai+2*wallThickness)/2, 0])cube([mountX,1,mountHeight+wallThickness]);
            
        translate([-(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia+wallThickness, h=mountHoledepth+wallThickness);
        translate([(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia+wallThickness, h=mountHoledepth+wallThickness);
        }
        translate([0,0,-0.01])center_tube();
        //hole
        translate([-(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia, h=mountHoledepth);
        translate([(mountHoleDistance)/2,(tripodDai+2*wallThickness)/2+1.01,(mountHeight+wallThickness-mountHoleDia/2)/2])rotate([90,0,0])cylinder(d=mountHoleDia, h=mountHoledepth);
        // tension screw hole
        translate([0,-(tripodDai+2*wallThickness)/2,mountHeight/2])rotate([90,0,-180])cylinder(d=tensionHoleDia, h=mountHoledepth);
        
    }
}

mount();