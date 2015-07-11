difference(){
    cube([60,40,10]);
    
    translate([10,10, 0]) cylinder(d=5.1, h=10, $fn=25);
    translate([50,10, 0]) cylinder(d=5.1, h=10, $fn=25);
    translate([30,40,5]) rotate([90,0,0]) cylinder(d=4.25, h=40, $fn=25);
    
    translate([0,20,0]) cube([20,20,10]);
    translate([40,20,0]) cube([20,20,10]);
}
