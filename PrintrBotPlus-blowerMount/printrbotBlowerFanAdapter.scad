$fn=90;

base = [40,40,3];
holeSeparation=[32,32];
fanInsert = [17.35,12.12,3];
wallThickness = 1.5;
angle = asin((24.91-3.11)/40);

module holes()
{
	cylinder(d=3, h=8);
	translate([holeSeparation.x,0,0])cylinder(d=3, h=8);
	translate([0,holeSeparation.y,0])cylinder(d=3, h=8);
	translate([holeSeparation.x,holeSeparation.y,0])cylinder(d=3, h=8);
}

module adapter()
{
	difference(){
		union(){
			cube(base);
			
			color("green")
			translate([(base.x-fanInsert.x)/2,(fanInsert.y*2.08),-8])
			rotate([90-angle,0,0])
			cube([fanInsert.x,fanInsert.y,30]);
			
			//translate([(base.x-fanInsert.x)/2,(fanInsert.y*.75),base.z])
			//rotate([90-angle,0,0])
			//cube(fanInsert);
		}
		translate([(base.x-holeSeparation.x)/2,(base.y-holeSeparation.y)/2,-.01])
		holes();
		
		color("blue")
		rotate([90-angle,0,0])
		translate([(base.x-fanInsert.x)/2+wallThickness,(base.y-fanInsert.y)/2+wallThickness-7,-40])
		cube([fanInsert.x-wallThickness*2, fanInsert.y-wallThickness*2,900]);
		
		translate([0,0,-500])
		cube([base.x,base.y,500]);
		translate([(base.x-holeSeparation.x)/2,(base.y-holeSeparation.y)/2,-.01])
		hull(){
			//top
			translate([(holeSeparation.x-fanInsert.x)/2, (holeSeparation.y-fanInsert.y)/2, base.z])
			cube([fanInsert.x,fanInsert.y,.01]);
			//bottom
			cube([holeSeparation.x,holeSeparation.y,.01]);
		}
	}
}


//rotate([angle,0,0])
adapter();


