thickness = 6;
height = 40;
extrusion_x = 40;
extrusion_y = 40;

arm_length = 63;
arm_spacing = 27;

arms();

module arms(){
    mirror_copy() translate([arm_spacing, cos(60) * thickness, 0]) rotate([0,0,-30]) arm();
}

module arm(angle = 30){
     cube([thickness, arm_length, height]);
}

module mirror_copy(vec=[1,0,0]) 
{ 
    children(); 
    mirror(vec) children(); 
} 