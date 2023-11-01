fidelity=100;

// Turret Cap customization

turret_cap_thickness=2;
turret_cap_inner_diameter=11.9;
turret_cap_height=7;

// Knurl customization
knurls_per_layer=10;
knurl_radius=1.5;
knurl_rotation=0;
knurl_roundness=10;
knurl_start_height=0;
knurl_height_duration=4;


module turret_cap(thickness, inner_diameter, height){
    outer_diameter=inner_diameter+thickness;
    difference(){
        union(){
            for(i = [0:knurl_height_duration-1]){
                translate([0,0,knurl_start_height])
                rotate(360/knurls_per_layer/2*i){
                    translate([0,0,knurl_radius*i]){
                        turret_knurl_layer(
                            knurls_per_layer, 
                            knurl_radius,
                            (outer_diameter)/2-knurl_radius/2);
                    }
                }
            }
            cylinder(h=height+2, d=inner_diameter+thickness, $fn=fidelity);
        }
        
        translate([0,0,2]){
            cylinder(h=height, d=inner_diameter, $fn=fidelity);
        }
        

        translate([0,0,-height]){
            cylinder(h=height, d=outer_diameter+knurl_radius, $fn=fidelity);
        }
    }
}

module turret_knurl_layer(knurl_count, radius, offset){
    for(i = [1:knurl_count]){
        rotate(i * 360/knurl_count)
        translate([offset,0,knurl_radius]){
            rotate(knurl_rotation){
                sphere(r=radius, $fn=knurl_roundness);
            }
        }
    }
}

turret_cap(turret_cap_thickness, turret_cap_inner_diameter, turret_cap_height);