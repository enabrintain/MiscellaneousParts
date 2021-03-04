use <threads.scad>;
$fn=360;

pindaProbeD = 8.82;
outerAdapterD = 11.7;

pitch = 1;
height = 25;

//metric_thread (diameter, pitch, length)
difference()
{
    metric_thread (outerAdapterD, pitch, height);
    metric_thread (pindaProbeD, pitch, height+1);
}


