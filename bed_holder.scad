difference(){
    cube([20,40,10]);
    translate([2,2,7]) cube([16, 36, 5]);
    
    translate([10, 10, 0]) cylinder(d=5.2, h=10, $fn=25);
    translate([10, 30, 0]) cylinder(d=5.2, h=10, $fn=25);
    translate([10, 30, 5]) cylinder(d=12, h=10, $fn=25);
     translate([10, 10, 5]) cylinder(d=12, h=10, $fn=25);
}

