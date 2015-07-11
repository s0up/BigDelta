
mount_point();

module mount_point(){
    difference(){
        cube([25, 10, 11], center=true);
        translate([0, 0, 2]) cube([22, 6.5, 10], center=true);
        translate([-0.5,0,-(11/2) - 0.5]) cube([18,5,12], center=true);
    }    
    
    difference(){
        translate([15,0,0]) cube([10,10,11], center=true);
        translate([15, 0, 0]) rotate([90,0,0]) cylinder(d=5.2, h=12, $fn=25, center=true);
    }
    
}