bearing_diameter = 22.3;
bearing_height = 7.3;
bearing_id = 8.5;

bearing_holder_width = 26;
bearing_holder_height = 26;
bearing_holder_depth = 14;

rotate([90,0,0]) main();

module main(){
    difference(){
        union(){
            translate([bearing_holder_width / 2 + 30, bearing_holder_height + 20, 0]) rotate([0,0,180]) holder();
            attachment();

            hull(){
                translate([30 - (bearing_holder_width / 2),20, 0]) cube([bearing_holder_width, 1, bearing_holder_depth]);
                translate([30 - (bearing_holder_width / 2), 0, 0]) cube([bearing_holder_width, 1, 10]);    
            }              
        }
   
        translate([20, 10, 0]) cylinder(d=5.1, h=20, $fn=25);
        translate([40, 10, 0]) cylinder(d=5.1, h=20, $fn=25);      
    }

}

module attachment(){
    difference(){
        cube([60,20,10]);
        
        //translate([10, 10, 0]) cylinder(d=5.1, h=10, $fn=25);
        //translate([50, 10, 0]) cylinder(d=5.1, h=10, $fn=25);
    } 
}

module holder(){
    difference(){
        cube([bearing_holder_width, bearing_holder_height, bearing_holder_depth]);
        
        hull(){
            translate([bearing_diameter / 2 + (bearing_holder_width - bearing_diameter) / 2, 0, (bearing_holder_depth - bearing_height) / 2]) cylinder(d=bearing_diameter, h=bearing_height, $fn=25);
            translate([bearing_diameter / 2 + (bearing_holder_width - bearing_diameter) / 2, bearing_holder_height - bearing_height - 5, (bearing_holder_depth - bearing_height) / 2]) cylinder(d=bearing_diameter, h=bearing_height, $fn=25);
        }
        
        hull(){
            translate([bearing_diameter / 2 + (bearing_holder_width - bearing_diameter) / 2, 0, 0]) cylinder(d=bearing_id, h=bearing_holder_depth, $fn=25);
            translate([bearing_diameter / 2 + (bearing_holder_width - bearing_diameter) / 2, bearing_holder_height - bearing_height - 5, 0]) cylinder(d=bearing_id, h=bearing_holder_depth, $fn=25);            
        }
    }
}