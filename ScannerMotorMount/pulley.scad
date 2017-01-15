//from http://www.thingiverse.com/thing:1013153 -pms
$fn = 90;

// Total thickness of the whole pulley
base_height = 15; 

// Center to pulley surface
PulleyRadius = 40/2; 

// From pulley surface to rim surface
RimHeight = 20; 

RimRadius = PulleyRadius + RimHeight;

// How wide are the rims
RimWidth = 1;

ValleyWidth = RimHeight/5; // Set to RimHeight for a 45 degree valley
PulleySurface = base_height - (2*RimWidth) - (2*ValleyWidth);

// Hole size
HoleDiameter = 3.0;

// Adjust for best fit. Smaller = tighter fit
HoleClearance = 0.1;

HoleRadius = (HoleDiameter / 2) + HoleClearance;

difference(){
rotate_extrude(convexity = 10)
Vee_Groove();
 translate([-1.5,-2.5,-1])cube([3,5,100]);
translate([-20,0,15/2])rotate([0,90,0])cylinder(d=3, h=100);
}

module Vee_Groove()
{
	polygon( points=[
		[HoleRadius,0],
		[RimRadius,0],
		[RimRadius,RimWidth],
		[PulleyRadius,RimWidth+ValleyWidth],
		[PulleyRadius,RimWidth+ValleyWidth+PulleySurface],
		[RimRadius,RimWidth+ValleyWidth+PulleySurface+ValleyWidth],
		[RimRadius,RimWidth+ValleyWidth+PulleySurface+ValleyWidth+RimWidth],
		[HoleRadius,RimWidth+ValleyWidth+PulleySurface+ValleyWidth+RimWidth],
		[HoleRadius,0]] );
}