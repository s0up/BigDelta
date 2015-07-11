// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// Modified for universal gantry plate from openbuilds by s0up 
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;

// Paramaters
arm_seperation = global_delta_arm_seperation;
belt_seperation = 12;

carriage_offset = 15; //+10 = 25.5 total
carriage_bolt_radius = 5.04/2;
backplate_thickness = 4;
v_wheel_seperation = 51.70;

alum_bar_height = 50.7;
alum_bar_width = 70.7;
alum_bar_thickness = 3;

back_plate_thickness = 4;

x_carriage();

//back_plate();

module x_carriage(){
    union(){
        translate([0,5,back_plate_thickness]) rotate([90,0,0]) carriage();
        translate() rotate() back_plate();
    }
}

module back_plate(){
    back_plate_x = 100;
    back_plate_y = 80;
    back_plate_rounded = 5;
    
    linear_extrude(height=back_plate_thickness){
        difference(){
            minkowski(){
                color("green") square([back_plate_x,back_plate_y], center=true);
                circle(d=back_plate_rounded, $fn=25);
            }
            translate([30,0,0]) circle(d=5.2, $fn=25);
            translate([-30,-30,0]) circle(d=5.2, $fn=25);
            translate([-30, 30,0]) circle(d=5.2, $fn=25);
            //Top left
            //translate([-back_plate_x / 2 + 10, back_plate_y / 2 - 10, 0]) circle(d=5.2, $fn=25);
            //Top right
            //translate([back_plate_x / 2 - 10, back_plate_y / 2 - 10, 0]) circle(d=5.2, $fn=25);
            //Bottom right
            //translate([back_plate_x / 2 - 10, -back_plate_y / 2 + 10, 0]) circle(d=5.2, $fn=25);
            //Bottom left
            //translate([-back_plate_x / 2 + 10, -back_plate_y / 2 + 10, 0]) circle(d=5.2, $fn=25);
            
       }
    }
}

// screw block
module block(radius=17, width=arm_seperation) {
	intersection() {
		difference () {
			union () {
				translate([0, 0, 0]) rotate([90, 22.5, 90])
				 cylinder(r=radius, h=width, center=true, $fn=8);
				translate([4, 9.2, -3.2]) rotate([0, 0, 0])
		 	 	 cube([15, 13, 25], center=true);			
			}
			translate([0, 0, radius*0.85]) rotate([0, 0, 0])
		 	 cube([width*2, radius*3, radius], center=true);
			translate([0, -radius*0.5, 0]) rotate([90, 0, 0])
		 	 cube([width*2, radius*3, radius], center=true);
		}
		translate([0, 0, -6]) rotate([0, 45, 0])
		  cube([width*0.8, width*0.8, width*0.8], center=true);
	}

}

// full carriage
module carriage(seperation=arm_seperation-15) {
	difference () {
		union () {
				translate([0, 0, 0]) rotate([0, 0, 0]) 
				 //backplate();
				translate([0, -1, 10]) rotate([0, 0, 0])
				 block();
				}

#		for (m = [-1,1]) scale([m, 1, 1]) {
			translate([seperation-8, 10, 4]) rotate([0, -90, 0])
			 cap_bolt(m3_bolt, 20);
		}
// M3 Nut channels
		for (a = [-1, 1]) scale([a, 1, 1]) {
		 translate([seperation/2, 10.5, 4]) rotate([0, 90, 180])
			hull() {	
				for (h = [-1,1]) {
					translate([0, 10*h-9.5, 0]) rotate([0, 0, 30])
					 flat_nut_boolean(3);
				}
			}
		}

// Belt Channels
		translate([belt_seperation/2+0.3, 7, 20]) rotate([-90, 100, 0])
		 timing_belt("GT2_boolean", 20, 10);
		translate([belt_seperation/2+4, 7, 20]) rotate([-90, 100, 0])
		 timing_belt("GT2_boolean", 20, 10);

		translate([-6, 14, 5]) rotate([0, 0, 0])
 	 	 cube([8, 20, 30], center=true);

	}
}


/*
// Primary Placement 
	translate([0, carriage_offset, 0]) rotate([0, 0, 0])
	 carriage ();
// Printed Backplate
*	translate([0, 0, 0]) rotate([0, 0, 0])
	 backplate (); // carriage backplate
// Hole Punch Template
*	translate([0, -carriage_offset, 0]) rotate([0, 0, 0])
	 backplate (bore=1.2, depth=2);



// Reference 
*union () {
	// Misumi Beam 
	translate([0, 0, 0]) rotate([0, 0, 90])
	 color("silver") misumibeam(20, 40, 500, extra_boolean); 

	// Belts
		for (a = [-1,1]) translate([belt_seperation/2*a, 25, 0]) rotate([0, 0, 0]) {
		 color("black") cube([1, 6, 500], center=true);
		}
}*/