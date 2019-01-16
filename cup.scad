$fn=180;

in2mm = 25.4;


rounding = .5*in2mm;
PP=[[0,0],
    [((2+3/8)*in2mm-rounding)/2,0*in2mm],
    //[2.75*in2mm/2,.25*in2mm],   //uncommenting these will require a 2 part mold
    //[(2+5/8)*in2mm/2,3/8*in2mm],
    [((2+3/8)*in2mm-rounding)/2,2*in2mm],
    [(4*in2mm-rounding)/2,6*in2mm],
    [0,6*in2mm]];


//MAGIC NUMBER WARNING
scale([0.8758620689655172,0.8758620689655172,1])
difference()
{
    union(){
        translate([0,0,0])
            rotate_extrude($fn=200)
                translate([rounding/2+1,rounding/2+1,1])
                    minkowski()
                    {
                        polygon( points=PP );
                        circle(d=rounding);
                    }
        translate([-13, -12, 1])cube([25, 25 , 6*in2mm+rounding-1]);
    }
    translate([-10*in2mm/2,-10*in2mm/2,6*in2mm+rounding/2])cube([10*in2mm, 10*in2mm, 2*rounding]);
}

/*difference () {
    cube([110, 110, handle_height]);
    translate([50,50,handle_height])
        scale([(image_width)/100,(image_length)/100,emboss_height])
            rotate([0,180,0])
                surface(file=image_file, center=true, convexity=5);
}*/