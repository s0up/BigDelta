thickness = 10;
height = 40;
extrusion_x = 40;
extrusion_y = 40;
center_x = thickness / 2 + 20;
center_z = height / 2;

motor_mount();

module motor_mount(){
    difference(){
        union(){
            base();
            translate([0,-25 - (thickness / 2) + thickness / 2,0]) mount();            
        }  
  
        //Cutout to only wrap around half the extrusion
        translate([0, thickness / 2 + extrusion_y / 2, 0]) cube([extrusion_x + thickness, extrusion_y, height]);
        
        //Axle hole
        translate([(40 + thickness ) / 2, thickness / 2 + 2.5, 20]) rotate([90,0,0]) cylinder(d=5.2, $fn=25, h=extrusion_y + thickness * 2 + 5);     
    }
}

module mount(){
    difference(){
        linear_extrude(height=height){
            difference(){
                square([40 + thickness / 2 * 2, 30 + thickness / 2]);
                translate([thickness / 2,thickness / 2,0]) square([40, 30 + thickness]);
            }        
        }
    }

}

module base(){
    translate([(thickness + extrusion_x) / 2, (extrusion_y / 2) + (thickness /2 ),height / 2]){
        difference(){
           cube([extrusion_x + thickness, extrusion_y + thickness, height], center=true);
           
            vslot_extrusion(extrusion_x,extrusion_y,height);
           translate([0, -extrusion_y / 4, extrusion_y / 4]) rotate([0,90,0])  cylinder(d=5.1, h=thickness * 2 + 40, $fn=16, center=true); 
           translate([0, -extrusion_y / 4, -extrusion_y / 4]) rotate([0,90,0])  cylinder(d=5.1, h=thickness * 2 + 40, $fn=16, center=true); 

        }         
    }
   
}



module vslot_extrusion(x,y,length = 20) {
    difference(){
        cube([x,y,length],center=true);
        //translate([x / 2 + 0.01,y / 4,0]) vslot();
        //translate([x / 2 + 0.01,-y  / 4,0]) vslot();
        //translate([-x / 2 - 0.01,-y / 4,0]) rotate([0,0,180]) vslot();
        //translate([-x / 2 - 0.01,y / 4,0]) rotate([0,0,180]) vslot();
        //translate([x / 4,y / 2 + 0.01,0]) rotate([0,0,90]) vslot();
        //translate([-x / 4,y / 2 + 0.01,0]) rotate([0,0,90]) vslot();
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