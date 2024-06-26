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

lampOutsideDimension = [37, in, 55]; //from https://share.temu.com/8gqEdKMOzfA
heightOfScrews = 45.5; //from floor
widthOfScrews = 22;

minkowskiSphereD = 1;

//arm
heightOfLowerArms = 8;
angleOfLowerArms = 35;
angleOfBend3Arms = 15;
armD = 4;

//cylinders
bottomD1 = 26;
bottomD2 = 20;
bottomH = 10;
transitionH = 1.5;
midD = 15;
midH = 2;
lampTransitionD1 = 13;
lampTransitionD2 = 6;
lampTransitionH = 3;
centerRingD = 27.5;

top1D = 8;
top1H = armD+1;
top2D2 = 13;
top2H = 2;
top3D2 = 5;
top3H = 2;

//'glass'
glassBottomD = bottomD2-1;
glassTopD = top1D+2;

//obligatory trigonometry because I love trig
arm1TopHeight = (sin(angleOfLowerArms)*heightOfLowerArms) + (bottomH-armD/2); 
arm1TopXOffset = (bottomD2/2) + (cos(angleOfLowerArms)*heightOfLowerArms);
arm2Angle = atan((heightOfScrews-arm1TopHeight)/(arm1TopXOffset-widthOfScrews/2));
echo("arm2Angle", arm2Angle);
arm2H = (heightOfScrews-arm1TopHeight) / sin(arm2Angle);
		
//more trig is more right
upperArmBendAngle = atan((top1H-1)/(widthOfScrews/2));
echo("upperArmBendAngle", upperArmBendAngle);


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
	
	translate([0,-lampOffset-centerRingD/2,0])color("blue")lamp();
	
	//screwHoleSupports
	translate([-widthOfScrews/2,0,heightOfScrews])
		rotate([90,0,0])
			cylinder(d=armD+.5, h=(centerRingD/2)-lampOffset);
	translate([widthOfScrews/2,0,heightOfScrews])
		rotate([90,0,0])
			cylinder(d=armD+.5, h=(centerRingD/2)-lampOffset);
	
	//lower Supports
	translate([(-bottomD2/2)-armD-.5,0,(bottomH-armD/2)])
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
	translate([(bottomD2/2)+armD+.5,0,(bottomH-armD/2)])
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
	
	woggleOuterHoleD = 25;
	woggleInnerHoleD = woggleOuterHoleD-6;
	woggleHoleH = heightOfScrews-(bottomH-armD)+minkowskiSphereD;
	fudgFactor = 1.5; 
	
	
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
			
			//woggle hole
			translate([0,2+(woggleOuterHoleD+minkowskiSphereD)/2,(heightOfScrews+(armD-minkowskiSphereD*2.75))-woggleHoleH])
				minkowski()
				{
					cylinder(d=woggleOuterHoleD, h = woggleHoleH);
					sphere(r=minkowskiSphereD);
				}
		}
		
		color("blue")
		translate([0,2+(woggleOuterHoleD+minkowskiSphereD)/2,((heightOfScrews+(armD-.5)/2)-woggleHoleH)-minkowskiSphereD*fudgFactor])
		woggleHole(woggleInnerHoleD, woggleHoleH);
	}
	
	
	
}
woggle();

//
module woggleHole(woggleInnerHoleD, woggleHoleH)
{
	union()
	{	
		cylinder(d=woggleInnerHoleD, h= woggleHoleH+minkowskiSphereD*2); //big cylinder
		translate([0,0,1])
		difference()
			{
			translate([0,0,-minkowskiSphereD])
				cylinder(d=woggleInnerHoleD+minkowskiSphereD*2, h= minkowskiSphereD);
			rotate_extrude(convexity = 10)
				translate([woggleInnerHoleD/2+minkowskiSphereD, 0, 0])
					circle(r = minkowskiSphereD);
			}
		translate([0,0,woggleHoleH+minkowskiSphereD])
			rotate([0,180,0])
		difference()
			{
			translate([0,0,-minkowskiSphereD])
				cylinder(d=woggleInnerHoleD+minkowskiSphereD*2, h= minkowskiSphereD);
			rotate_extrude(convexity = 10)
				translate([woggleInnerHoleD/2+minkowskiSphereD, 0, 0])
					circle(r = minkowskiSphereD);
			}
	}
}
//woggleHole(19, heightOfScrews-(bottomH-armD)+minkowskiSphereD);


wingSize = [5,5,21];
wingAngle = 10;
// Size of the text
size = wingSize.x;
//Font of the text
font = "Cousine";
//Style of the text, options: Blank, 'Bold', 'Bold Italic', 'Italic'
style = "Bold";


module wing(xOffset, wingTilt)
{
	color("blue")
	
	
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
		rotate([0,-wingTilt,0])
			translate([-wingSize.x/2-xOffset,wingSize.y/2,0])
				cube(wingSize);
		translate([wingSize.x/2,wingSize.y,0])
			cylinder(d=wingSize.x, h=wingSize.z);
	}
}
//wing( (-bottomD2/2)-armD-7-wingSize.x, wingAngle );

wingZ = ((heightOfScrews-((bottomH-armD/2)))/2);


////left wing
//translate([(-bottomD2/2)-armD-7-wingSize.x,0,wingZ])
//rotate([0,wingAngle,0])
//union()
//{
//	wing((-bottomD2/2)-armD-7-wingSize.x, wingAngle);
//	color("green")
//		translate([0,0,wingSize.z-wingSize.x])
//			rotate([90,0,0])
//				linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
//				text("C", font = str(font,":style=",style), size = size, halign = "center", language = "en");
//	color("green")
//		translate([0,0,wingSize.z-wingSize.x*2])
//			rotate([90,0,0])
//				linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
//				text("R", font = str(font,":style=",style), size = size, halign = "center", language = "en");
//	color("green")
//		translate([0,0,wingSize.z-wingSize.x*3])
//			rotate([90,0,0])
//				linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
//				text("E", font = str(font,":style=",style), size = size, halign = "center", language = "en");
//	color("green")
//		translate([0,0,wingSize.z-wingSize.x*4])
//			rotate([90,0,0])
//				linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
//				text("W", font = str(font,":style=",style), size = size, halign = "center", language = "en");
//}
//
////right wing
//translate([(bottomD2/2)+armD+7+wingSize.x,0,wingZ])
//rotate([0,-wingAngle,0])
//union()
//{
//	wing((bottomD2/2)+armD+7+wingSize.x, -wingAngle);
//	color("green")
//		translate([0,0,wingSize.z-wingSize.x*2])
//			rotate([90,0,0])
//				linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
//				text("9", font = str(font,":style=",style), size = size, halign = "center", language = "en");
//	color("green")
//		translate([0,0,wingSize.z-wingSize.x*3])
//			rotate([90,0,0])
//				linear_extrude(height = 1, center = true, convexity = 10, slices = 20, scale = 1.0)
//				text("9", font = str(font,":style=",style), size = size, halign = "center", language = "en");
//}















































