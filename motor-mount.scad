thickness = 10;
height = 40;
extrusion_x = 40;
extrusion_y = 40;

base();
translate([0,-20,0]) mount();

module mount(){
    center_x = thickness / 2 + 20;
    center_z = height / 2;
    
    difference(){
        linear_extrude(height=height){
            difference(){
                square([40 + thickness / 2 * 2, 20 + thickness / 2]);
                translate([thickness / 2,thickness / 2,0]) square([40, 20 + thickness]);
            }        
        }
        //Axle hole
        translate([(40 + thickness ) / 2, thickness / 2 + 2.5, 20]) rotate([90,0,0]) cylinder(d=15, $fn=25, h=thickness / 2 + 5);
        //Stepper holes
        translate([center_x + 15.5,thickness / 2,center_z - 15.5]) rotate([90,0,0]) cylinder(d=3.2, $fn=25, h=thickness / 2 + 5);
        translate([center_x + 15.5,thickness / 2,center_z + 15.5]) rotate([90,0,0]) cylinder(d=3.2, $fn=25, h=thickness / 2 + 5);
        translate([center_x - 15.5,thickness / 2,center_z - 15.5]) rotate([90,0,0]) cylinder(d=3.2, $fn=25, h=thickness / 2 + 5);
        translate([center_x - 15.5,thickness / 2,center_z + 15.5]) rotate([90,0,0]) cylinder(d=3.2, $fn=25, h=thickness / 2 + 5);
    }

}

module base(){
    translate([(thickness + extrusion_x) / 2, thickness + extrusion_y / 2,height / 2]){
        difference(){
           cube([extrusion_x + thickness, extrusion_y + thickness, height], center=true);
           vslot_extrusion(extrusion_x,extrusion_y,height);
            
           translate([0, extrusion_y / 4, extrusion_y / 4]) rotate([0,90,0])  cylinder(d=5.1, h=thickness * 2 + 40, $fn=16, center=true);
           translate([0, extrusion_y / 4, -extrusion_y / 4]) rotate([0,90,0])  cylinder(d=5.1, h=thickness * 2 + 40, $fn=16, center=true);  
           translate([0, -extrusion_y / 4, extrusion_y / 4]) rotate([0,90,0])  cylinder(d=5.1, h=thickness * 2 + 40, $fn=16, center=true); 
           translate([0, -extrusion_y / 4, -extrusion_y / 4]) rotate([0,90,0])  cylinder(d=5.1, h=thickness * 2 + 40, $fn=16, center=true); 
        }         
    }
   
}



module vslot_extrusion(x,y,length = 20) {
    difference(){
        cube([x,y,length],center=true);
        translate([x / 2 + 0.01,y / 4,0]) vslot();
        translate([x / 2 + 0.01,-y  / 4,0]) vslot();
        translate([-x / 2 - 0.01,-y / 4,0]) rotate([0,0,180]) vslot();
        translate([-x / 2 - 0.01,y / 4,0]) rotate([0,0,180]) vslot();
        translate([x / 4,y / 2 + 0.01,0]) rotate([0,0,90]) vslot();
        translate([-x / 4,y / 2 + 0.01,0]) rotate([0,0,90]) vslot();
        translate([x / 4,-y / 2 - 0.01,0]) rotate([0,0,-90]) vslot();
        translate([-x / 4,-y / 2 - 0.01,0]) rotate([0,0,-90]) vslot();
    }
    
    module vslot(){
        difference() {
            translate([0, 0, 0]) rotate([0, 0, 0])
             cylinder(r=4.5, h=length, center=true,  $fn=4);	

    //plane sides
            translate([-3.8, 0, 0]) rotate([0, 0, 0])
             cube([4, 20, length*2], center=true);
            translate([3, 0, 0]) rotate([0, 0, 0])
             cube([6, 20, length*2], center=true);
        }        
    }
}    