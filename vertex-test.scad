//general variables
arm_thickness = 10;
slot_thickness = 10;
arm_length = 80;
hole_size = 5.2;
arm_num_holes = 4;
//4040 vertical extrusions
vertical_extrusion_x = 40;
vertical_extrusion_y = 40;
extra_vertical_height = 20;
//2040 horizontal extrusions
horizontal_extrusion_x = 40;
horizontal_extrusion_y = 20;

vertex();

module vertex(){
    difference(){
        difference(){
            body();  
            //Recesses
            translate([20,0,10]) rotate([-90,0,-30]) translate([0,0,-5]) cylinder(d=8, $fn=15, h=60);
            translate([20,0,30]) rotate([-90,0,-30]) translate([0,0,-5]) cylinder(d=8, $fn=15, h=60);
            
            translate([-20,0,10]) rotate([-90,0,30]) translate([0,0,-5]) cylinder(d=8, $fn=15, h=60);
            translate([-20,0,30]) rotate([-90,0,30]) translate([0,0,-5]) cylinder(d=8, $fn=15, h=60);
        }
        translate([0,vertical_extrusion_y / 2 + slot_thickness,(horizontal_extrusion_x + extra_vertical_height) / 2]) vslot_extrusion(vertical_extrusion_x, vertical_extrusion_y, horizontal_extrusion_x + extra_vertical_height);
    }    
}

module body(){
    union(){
        mirror_copy() 
            translate([(vertical_extrusion_x + slot_thickness * 2) / 2 - sin(60) * (vertical_extrusion_x / 2 + slot_thickness),cos(60) * (vertical_extrusion_x / 2 + slot_thickness),0]) rotate([0, 0, -30]) arm();
        
        difference(){
            translate([0,(vertical_extrusion_y + slot_thickness * 2) / 2,(horizontal_extrusion_x + extra_vertical_height)/ 2])       
            cube([vertical_extrusion_x + slot_thickness * 2, vertical_extrusion_y + slot_thickness * 2, horizontal_extrusion_x + extra_vertical_height], center=true); 
            
            //T-slot holes
            translate([-horizontal_extrusion_x / 4,0,horizontal_extrusion_x / 4]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            translate([horizontal_extrusion_x / 4,0,horizontal_extrusion_x / 4]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            translate([-horizontal_extrusion_x / 4,0,horizontal_extrusion_x - (horizontal_extrusion_x / 4)]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            translate([horizontal_extrusion_x / 4,0,horizontal_extrusion_x - (horizontal_extrusion_x / 4)]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            
            translate([-horizontal_extrusion_x / 4,vertical_extrusion_y + slot_thickness,horizontal_extrusion_x / 4]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            translate([horizontal_extrusion_x / 4,vertical_extrusion_y + slot_thickness,horizontal_extrusion_x / 4]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            translate([-horizontal_extrusion_x / 4,vertical_extrusion_y + slot_thickness,horizontal_extrusion_x - (horizontal_extrusion_x / 4)]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            translate([horizontal_extrusion_x / 4,vertical_extrusion_y + slot_thickness,horizontal_extrusion_x - (horizontal_extrusion_x / 4)]) rotate([-90,0,0]) cylinder(d=hole_size,$fn=25,h=slot_thickness);
            
        }
           
    }    
}



module arm(){
    difference(){
        linear_extrude(height=horizontal_extrusion_x){
            union(){
                square([vertical_extrusion_x / 2 + slot_thickness, vertical_extrusion_y + (slot_thickness * 2)]);
                translate([0,vertical_extrusion_y + slot_thickness * 2,0]) square([arm_thickness, arm_length]);           
            }
        }   
        //4x holes on arm
        translate([0,vertical_extrusion_y + slot_thickness * 2 + arm_length / 4,horizontal_extrusion_x / 4]) rotate([0,90,0]) cylinder($fn=25, h=arm_thickness, d=hole_size);
        translate([0,vertical_extrusion_y + slot_thickness * 2 + arm_length - (arm_length / 4),horizontal_extrusion_x / 4]) rotate([0,90,0]) cylinder($fn=25, h=arm_thickness, d=hole_size);
        translate([0,vertical_extrusion_y + slot_thickness * 2 + arm_length / 4,horizontal_extrusion_x - (horizontal_extrusion_x / 4)]) rotate([0,90,0]) cylinder($fn=25, h=arm_thickness, d=hole_size);
        translate([0,vertical_extrusion_y + slot_thickness * 2 + arm_length - (arm_length / 4),horizontal_extrusion_x - (horizontal_extrusion_x / 4)]) rotate([0,90,0]) cylinder($fn=25, h=arm_thickness, d=hole_size);
        
        //2x holes for tap 
        translate([(horizontal_extrusion_y / 2) + arm_thickness,vertical_extrusion_y + (slot_thickness * 2),horizontal_extrusion_x / 4]) rotate([90,0,0]) cylinder($fn=25, h=vertical_extrusion_y + (slot_thickness * 2), d=hole_size);
        translate([(horizontal_extrusion_y / 2) + arm_thickness,vertical_extrusion_y + (slot_thickness * 2),horizontal_extrusion_x - (horizontal_extrusion_x/ 4)]) rotate([90,0,0]) cylinder($fn=25, h=vertical_extrusion_y + (slot_thickness * 2), d=hole_size);
    }
   
}

module mirror_copy(vec=[1,0,0]) 
{ 
    children(); 
    mirror(vec) children(); 
} 


module vslot_extrusion(x,y,length = 20) {
    difference(){
        cube([x,y,length],center=true);
        translate([x / 2 + 0.01,0,0]) vslot();
        translate([-x / 2 - 0.01,0,0]) rotate([0,0,180]) vslot();
        translate([0,y / 2 + 0.01,0]) rotate([0,0,90]) vslot();
        translate([0,-y / 2 - 0.01,0]) rotate([0,0,-90]) vslot();
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

/*
module misumibeam(size1=15, size2=15, length=100, extra=0) {
   difference() {
      cube([size1+extra, size2+extra, length], center=true);
      for (a = [0:180:180]) rotate([0, 0, a]) {
         translate([size1/2, 0, 0]) {
          //  % cube([size1/2, 3, length+1], center=true);
			minkowski() {
               cube([size1/2-(extra+1), size1/6-extra, length+1], center=true);
               cylinder(r=0.5, h=1, center=true);
			} 
        }
      }
      for (a = [0:90:270]) rotate([0, 0, a]) {
         translate([size2/2, 0, 0]) {
          //  % cube([size1/2, 3, length+1], center=true);
			minkowski() {
               cube([size1/2-(extra+1), size1/6-extra, length+1], center=true);
               cylinder(r=0.5, h=1, center=true);
			} 
        }
      }
   }
}*/
