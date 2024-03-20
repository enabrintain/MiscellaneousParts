/**
    This is a scouting woggle (a neckerchief holder for Boy/Girl Scouts) that I made for my niece for her Eagle Scout award ceremony
	
	There are two options, One with wings that can have text, and one without the wings.
	
	LampWoggle.scad is not all the way complete, but the parametric measurements are correct for the smaller lamp that can be bought from China. 
		Some adjustments will be necessary for the small design, but I'd be happy to colab with someone if theres interest.
	LampWoggle2.scad is complete, and has the parametric measurements for the larger lamps - that have leds and light up.
    
    Copyright (C) 2024 Phillip Showers
		phil@showe.rs
    This model is released under the Creative Commons Attribution/Share Alike license.
    Attribute me if you use it. 
    Share it like I shared it.
    https://creativecommons.org/licenses/by-sa/4.0/

    Feel free to make money on this design! If you want, donate some to www.fsf.org.
**/

$fn=90;

in = 25.4;

lampOutsideDimension = [50, 36.3, 73]; //from https://www.walmart.com/ip/Kerosene-Lamp-Lantern-Led-Light-Oil-Miniature-Mini-Hanging-Small-Ornament-Decor-Lamp-Light-Xmas-Christmastree-Decor/1697373677
heightOfScrews = 60; //from floor
widthOfScrews = 30;

minkowskiSphereD = 1;

//arm
heightOfLowerArms = 10;
angleOfLowerArms = 35;
angleOfBend3Arms = 15;
armD = 4.5;

//cylinders
bottomD1 = 35;
bottomD2 = 29.5;
bottomH = 12;
transitionH = 1.5;
midD = 21.5;
midH = 4.4;
lampTransitionD1 = 17.5;
lampTransitionD2 = 12;
lampTransitionH = 4.8;
centerRingD = 36.3;

top1D = 15;
top1H = armD+1;
top2D2 = 19.5;
top2H = 6;
top3D2 = 10.5;
top3H = 3;

//'glass'
glassBottomD = bottomD2-1;
glassTopD = top1D+2;

//obligatory trigonometry because I love trig
arm1TopHeight = (sin(angleOfLowerArms)*heightOfLowerArms) + (bottomH-armD/2); 
arm1TopXOffset = (bottomD2/2) + (cos(angleOfLowerArms)*heightOfLowerArms);
arm2Angle = atan((heightOfScrews-arm1TopHeight)/(arm1TopXOffset-widthOfScrews/2));
//echo("arm2Angle", arm2Angle);
arm2H = (heightOfScrews-arm1TopHeight) / sin(arm2Angle);

woggleOuterHoleD = 35;
woggleInnerHoleD = woggleOuterHoleD-12;
woggleHoleH = heightOfScrews-(bottomH-armD)+1.5;
fudgFactor = 1.25; 
		
//more trig is more right
upperArmBendAngle = atan((top1H-1)/(widthOfScrews/2));
//echo("upperArmBendAngle", upperArmBendAngle);

//color("blue")translate([-lampOutsideDimension.x/2,0,0])cube(lampOutsideDimension);

module lampArm()
{
	//bottom arm
	translate([-bottomD2/2,0,bottomH-armD/2])
		rotate([0,-90+angleOfLowerArms,0])
			cylinder(d=armD, h=heightOfLowerArms);
	
	translate([-arm1TopXOffset,0,arm1TopHeight])
		rotate([0,90-arm2Angle,0])
		{
			cylinder(d=armD, h=arm2H);
			sphere(d=armD);// elbow
		}
			
	//screw holes
	translate([-widthOfScrews/2,0,heightOfScrews])
		rotate([90,0,0])
			translate([0,0,-armD/2])
			cylinder(d=armD+.5, h=armD);

		
	translate([-widthOfScrews/2+armD/2,0,heightOfScrews])
		rotate([0,90-upperArmBendAngle,0])
			translate([0,0,-armD/2])
			cylinder(d=armD, h=widthOfScrews/2);
}

module lamp()
{
//	color("green", 0.2)
//	translate([-lampOutsideDimension.x/2,-lampOutsideDimension.y/2,0])cube(lampOutsideDimension);
	union()
	{
		//bottom cylinder
		cylinder(d1 = bottomD1, d2 = bottomD2, h=bottomH); //bottom part
		translate([0,0,bottomH]) cylinder(d1 = bottomD2, d2 = midD, h=transitionH); //transition
		translate([0,0,bottomH+transitionH]) cylinder(d1 = midD, d2 = midD, h=midH); //middle part
		translate([0,0,bottomH+transitionH+midH]) cylinder(d1 = lampTransitionD1, d2 = lampTransitionD2, h=lampTransitionH); //middle part

		//arms
		lampArm();
		rotate([0,0,180])lampArm();
		
		//lamp 'glass part'
		hull()
		{
		color("blue")
		translate([0,0,bottomH+transitionH+midH+lampTransitionH+glassBottomD/2])
			sphere(d=glassBottomD);
		translate([0,0,lampOutsideDimension.z-top3H-top2H-top1H-1]) cylinder(d=glassTopD, h=1);		
		}
		
		//top
		translate([0,0,lampOutsideDimension.z-top3H-top2H-top1H]) cylinder(d1 = top1D, d2 = top1D, h=top1H); //top1
		translate([0,0,lampOutsideDimension.z-top3H-top2H]) cylinder(d1 = top1D, d2 = top2D2, h=top2H); //top2
		translate([0,0,lampOutsideDimension.z-top3H]) cylinder(d1 = top2D2, d2 = top3D2, h=top3H); //top3

		//center ring
		translate([0,0,bottomH+transitionH+midH+lampTransitionH+glassBottomD/2])
		cylinder(d=centerRingD, 2);
	}
}
//lamp();

module woggle()
{
	lampOffset = 1;
	
//	translate([0,-lampOffset-centerRingD/2,0])color("blue")lamp();
	
	//screwHoleSupports
	difference()
	{
		translate([-widthOfScrews/2,0,heightOfScrews])
			rotate([90,0,0])
				cylinder(d=armD+.5, h=(centerRingD/2)-lampOffset);
		//screwHole
		color("blue")
		translate([-widthOfScrews/2,0,heightOfScrews])
			rotate([90,0,0])
				cylinder(d=0.75, h=20);
	}
	difference()
	{
		translate([widthOfScrews/2,0,heightOfScrews])
			rotate([90,0,0])
				cylinder(d=armD+.5, h=(centerRingD/2)-lampOffset);
		//screwHole
		translate([widthOfScrews/2,0,heightOfScrews])
			rotate([90,0,0])
				cylinder(d=0.75, h=20);
	}
	
	//lower Supports
	translate([(-bottomD2/2)-armD-.5,0,(bottomH-armD/2)])
	difference()
	{
		rotate([90,angleOfLowerArms,0])
			hull()
			{
				minkowski()
				{
					cylinder(d=armD+.5-1, h=(centerRingD/2)+armD);
					sphere(r=1);
				}
				translate([-2,0,0])
				minkowski()
				{
					cylinder(d=armD+.5-1, h=(centerRingD/2)+armD);
					sphere(r=minkowskiSphereD);
				}
			}
		color("blue")
		translate([4+armD,-lampOffset-centerRingD/2,-armD/2-.5])
			rotate([0,-90+angleOfLowerArms,0])
				cylinder(d=armD, h=(centerRingD/2)+armD);
	}
	translate([(bottomD2/2)+armD+.5,0,(bottomH-armD/2)])
	difference()
	{
		rotate([90,180-angleOfLowerArms,0])
			hull()
			{
				minkowski()
				{
					cylinder(d=armD+.5-1, h=(centerRingD/2)+armD);
					sphere(r=1);
				}
				translate([-2,0,0])
				minkowski()
				{
					cylinder(d=armD+.5-1, h=(centerRingD/2)+armD);
					sphere(r=minkowskiSphereD);
				}
			}
		color("blue")
		translate([-4-armD,-lampOffset-centerRingD/2,-armD/2-.5])
			rotate([0,90-angleOfLowerArms,0])
				cylinder(d=armD, h=(centerRingD/2)+armD);
	}	
	
	// backplate
	difference()
	{
		hull()
		{
			//screwHoleCylinders
			translate([-widthOfScrews/2,0,heightOfScrews])
				rotate([-90,0,0])
					cylinder(d=armD+0.5, h=10);
			translate([widthOfScrews/2,0,heightOfScrews])
				rotate([-90,0,0])
					cylinder(d=armD+0.5, h=10);
			//bottom Support parts
			translate([(-bottomD2/2)-armD-.5,0,(bottomH-armD/2)])
				rotate([-90,angleOfLowerArms,0])
					hull()
					{
						cylinder(d=armD+1.5, h=10);
						translate([-2,0,0])
							cylinder(d=armD+1.5, h=10);
					}
			translate([(bottomD2/2)+armD+.5,0,(bottomH-armD/2)])
				rotate([-90,180-angleOfLowerArms,0])
					hull()
					{
						cylinder(d=armD+1.5, h=10);
						translate([-2,0,0])
							cylinder(d=armD+1.5, h=10);
					}
			
			//woggle hole barrel wall
			translate([0,2+(woggleOuterHoleD)/3,(heightOfScrews+(armD-minkowskiSphereD*2.75))-woggleHoleH])
			  scale([1,.5,1])
				minkowski()
				{
					cylinder(d=woggleOuterHoleD, h = woggleHoleH);
					sphere(r=minkowskiSphereD);
				}
		}
		
		translate(
		[0,	(woggleOuterHoleD)/3,
		((heightOfScrews+(armD-.5)/2)-woggleHoleH)-minkowskiSphereD*fudgFactor])
		scale([1,.5,1])
			woggleHole(woggleInnerHoleD, woggleHoleH);
		
	}
	
	
	
}
woggle();

//
module woggleHole(woggleInnerHoleD, woggleHoleH)
{
	fudgeFactor = 0;
	union()
	{	
		cylinder(d=woggleInnerHoleD, h= woggleHoleH+minkowskiSphereD*fudgeFactor); //big cylinder
		translate([0,0,1])
		difference()
			{
			translate([0,0,-minkowskiSphereD])
				cylinder(d=woggleInnerHoleD+minkowskiSphereD*2, h= minkowskiSphereD);
			rotate_extrude(convexity = 10)
				translate([woggleInnerHoleD/2+minkowskiSphereD, 0, 0])
					circle(r = minkowskiSphereD);
			}
		translate([0,0,woggleHoleH+minkowskiSphereD*fudgeFactor])
			rotate([0,180,0])
			difference()
				{
				translate([0,0,-minkowskiSphereD-1])
					cylinder(d=woggleInnerHoleD+minkowskiSphereD*2, h= minkowskiSphereD+1);
				rotate_extrude(convexity = 10)
					translate([woggleInnerHoleD/2+minkowskiSphereD, 0, 0])
						circle(r = minkowskiSphereD+1);
				}
	}
}
//woggleHole(19, heightOfScrews-(bottomH-armD)+minkowskiSphereD);


wingSize = [10,10,50];
wingAngle = 10;
// Size of the text
size = wingSize.x;
//Font of the text
font = "Cousine";
//Style of the text, options: Blank, 'Bold', 'Bold Italic', 'Italic'
style = "Bold";


module wing(xOffset, wingTilt)
{
	echo("xOffset", xOffset);
	echo("wingTilt", wingTilt);
	rotate([0,wingTilt,0])
		translate([-wingSize.x/2,0,0])
			hull()
			{
				cube(wingSize);
				translate([wingSize.x/2,wingSize.y,0])
					cylinder(d=wingSize.x, h=wingSize.z);
			}
	translate([-wingSize.x/2,0,0])
		hull()
		{
				translate([-xOffset,wingSize.y/2,0])
					cube(wingSize);
			translate([wingSize.x/2,wingSize.y,0])
			rotate([0,wingTilt,0])
				cylinder(d=wingSize.x, h=wingSize.z);
		}
}
//wing( (-bottomD2/2)-armD-7-wingSize.x, wingAngle );

baseSupportZ = (bottomH-armD/2);
wingZ = ((heightOfScrews-((bottomH-armD/2)))/2);
margin = 1.7;

difference()
{
	union()
	{
	//left wing
	translate([(-bottomD2/2)-armD-7-wingSize.x,-5,baseSupportZ])
	union()
	{
		color("blue")
		wing((-bottomD2/2)-armD-7-wingSize.x, wingAngle);
		rotate([0,wingAngle,0])
			union()
			{
				color("green")
					translate([0,0,wingSize.z-wingSize.x-margin])
						rotate([90,0,0])
							linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
							text("C", font = str(font,":style=",style), size = size, halign = "center", language = "en");
				color("green")
					translate([0,0,wingSize.z-(wingSize.x+margin)*2])
						rotate([90,0,0])
							linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
							text("R", font = str(font,":style=",style), size = size, halign = "center", language = "en");
				color("green")
					translate([0,0,wingSize.z-(wingSize.x+margin)*3])
						rotate([90,0,0])
							linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
							text("E", font = str(font,":style=",style), size = size, halign = "center", language = "en");
				color("green")
					translate([0,0,wingSize.z-(wingSize.x+margin)*4])
						rotate([90,0,0])
							linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
							text("W", font = str(font,":style=",style), size = size, halign = "center", language = "en");
			}
	}

	//right wing
	translate([(bottomD2/2)+armD+7+wingSize.x,-5,baseSupportZ])
		union()
		{
			wing((bottomD2/2)+armD+7+wingSize.x, -wingAngle);
			rotate([0,-wingAngle,0])
				union()
				{
					color("green")
						translate([0,0,wingSize.z-wingSize.x*2.5])
							rotate([90,0,0])
								linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
								text("9", font = str(font,":style=",style), size = size, halign = "center", language = "en");
					color("green")
						translate([0,0,wingSize.z-wingSize.x*3.5])
							rotate([90,0,0])
								linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
								text("9", font = str(font,":style=",style), size = size, halign = "center", language = "en");
				}
		}
	}


	translate([0,
		(woggleOuterHoleD)/3,
		((heightOfScrews+(armD-.5)/2)-woggleHoleH)-minkowskiSphereD*fudgFactor])
		scale([1,.5,1])
			woggleHole(woggleInnerHoleD, woggleHoleH);

}








