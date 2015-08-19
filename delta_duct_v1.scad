tube_wall_thickness = 2;
tube_id = 30;
tube_od = 62;
tube_opening_width = 2.5;
tube_resolution = 25;

blower_insert_x = 15;
blower_insert_y = 20;
blower_insert_z = 6;
blower_insert_wall_thickness = 2;

mount_point_thickness = 3.5;
mount_point_height = 65;
mount_point_length = 25;
//circle_tube(tube_id, tube_od);

//effector

use <effector.scad>;

translate([0,0,15]) rotate([0,0,60]) effector();

translate([-10,0,30]){
    rotate([0,0,90]){
        //import("/Users/s0up/Desktop/3dprintstuff/3d_models/jhead_prusa_bowden_v0.2/assembled_donotprint.stl");

    }
}    

rotate([0,0,-90]){
    difference(){
        circle_tube(tube_id, tube_od);  
        //translate([0,0,25 / 2 + 5]) cube([100,100,25], center=true);
    }
}
   //slit(); 
//}



//slit();

//mount_point();

module mount_point(){
    rotate([0,0,90])
    translate([-mount_point_thickness / 2,-mount_point_length /2,mount_point_height]) 
    rotate([0,90,0])
    linear_extrude(height=mount_point_thickness){
        difference(){
            square([mount_point_height, mount_point_length]);
            //translate([mount_point_height / 3, mount_point_length / 2, 0]) circle(d=3.2, $fn=25);
        }        
    }
}

module slit(){
    /*
    rotate_extrude($fn=100){
        translate([tube_id / 2 + tube_wall_thickness, 0, 0]) rotate([29.566,29.566, 0]) square([tube_opening_width, tube_wall_thickness * 2]);            
    }*/
    
    rotate_extrude($fn=tube_resolution){
        translate([tube_id / 2 + tube_wall_thickness / 2 - 0.1, 0, 0]) rotate([60.434,60.434, 0]) square([tube_opening_width, tube_wall_thickness * 4]);            
    }
}

module circle_tube(tube_id, tube_od){
    tube_dia = (tube_od - tube_id) / 3;
    tube_x = (tube_od - tube_id) / 2;
    
    difference(){
        union(){
            rotate_extrude($fn=tube_resolution){
                translate([tube_dia / 2 + tube_id / 2,0,0]) rotate([180,0,180]) duct_outline(tube_dia);        
            }
            
            //Mounting points for hull
            //Outer mount
            hull(){
                translate([tube_od / 2 - (tube_dia / 2) - tube_wall_thickness, -10, 0]) cube([2, 20, (tube_od - tube_id) / 3]);
                tube_mount();
            }
        } 
        //Inner mount hole
        hull(){
            translate([tube_od / 2 - (tube_dia / 2) - tube_wall_thickness, -10 + tube_wall_thickness, tube_wall_thickness]) cube([2, 20 - (tube_wall_thickness * 2), (tube_od - tube_id) / 3 - (tube_wall_thickness * 2)]);
            tube_mount_hole();
        }
        
        //Inner tube hole
        translate([0,0,tube_wall_thickness]) 
            rotate_extrude($fn=tube_resolution){
            translate([tube_dia / 2 + tube_id / 2 + tube_wall_thickness,0,0]) rotate([180,0,180]) duct_outline(tube_dia - (tube_wall_thickness * 2)); 
         //translate([tube_dia / 2 + tube_id / 2,0,0]) rotate([180,0,180]) duct_outline(tube_dia - (tube_wall_thickness * 2));          
        }   
   
        slit();
    }


}

module tube_mount(){
    degrees = 45;
    
    offset = cos(degrees) * (blower_insert_x + (blower_insert_wall_thickness * 2));
    
    translate([tube_od / 2,-blower_insert_y / 2 - blower_insert_wall_thickness, offset]) 
    
    rotate([0,degrees,0]) cube([blower_insert_x + (blower_insert_wall_thickness * 2), blower_insert_y + (blower_insert_wall_thickness * 2), blower_insert_z]);
}

module tube_mount_hole(){
    degrees = 45;
    
    offset = cos(degrees) * (blower_insert_x);
    
    translate([tube_od / 2 + blower_insert_wall_thickness,-blower_insert_y / 2, offset + blower_insert_wall_thickness]) 
    
    rotate([0,degrees,0]) cube([blower_insert_x, blower_insert_y, blower_insert_z]);
}

module duct_outline(diameter = 10){
    hull(){
        polygon(points=[[0,0], [0,diameter / 2],[diameter / 2,0]], paths=[[0,1,2]]);
         translate([-diameter / 2, diameter / 2, 0]){
            circle(d=diameter); 
        }       
    }   
}
