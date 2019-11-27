include <lev.scad>

inner_case_radius = well_radius(outer_radius(),$end_angle) + $lip;
outer_case_height = well_depth(outer_radius(),$end_angle) + $extra_room_underneath + $thickness;

outer_case_radius = inner_case_radius + $wall_thickness;
inner_case_height = outer_case_height - $lip_thickness + $fudge;
sponson_z = -well_z(outer_radius(), $end_angle) + $lip_thickness;




module sponson(radius, height, shift=0) {
  rad = well_radius(radius, $end_angle) + $lip + $wall_thickness;

  difference() {
    cylinder(r=rad, h=height);
    // cutoff cube
    translate([-outer_radius()*2, -well_radius(outer_radius(), $end_angle)-shift, -$fudge]) cube(outer_radius()*4);
    /* %translate([-outer_radius()*2, -well_radius(outer_radius(), $end_angle), -$fudge]) cube(outer_radius()*4); */
  }
}

module total_sponson(height = undef) {
  real_height = height ? height : well_z(middle_radius(), $end_angle); // TODO magic numbers everywhere and no idea why

  difference() {
    translate([0,0,sponson_z]) {
      sponson(outer_radius(), real_height);
    }
    scale([1,1,3]) {
      translate([0,0,sponson_z+1]){
        sponson(middle_radius(), real_height, 1);
      }
    }
  }
}

module top_cover() {
  cylinder(r=outer_case_radius, h=$wall_thickness);
  translate([0,0,$wall_thickness]) difference() {
    cylinder(r=inner_case_radius-$slop, h=$wall_thickness);
    cylinder(r=inner_case_radius-$wall_thickness, h=$wall_thickness);
  }
}

module outside() {



  difference() {
    // outer cylinder
    union() {
      difference() {
        translate([0,0,-outer_radius() - $extra_room_underneath]) {
          /* rad = well_radius(outer_radius(),$end_angle) + $lip + $wall_thickness; */
          /* height = well_depth(outer_radius(),$end_angle) + $extra_room_underneath + $thickness; */
          cylinder(r=outer_case_radius, h=outer_case_height-.81);
        }
        // inner cylinder
        translate([0,0,-outer_radius() - $extra_room_underneath - $fudge]) {
          /* rad = well_radius(outer_radius(),$end_angle)+$lip; */
          /* height = well_depth(outer_radius(),$end_angle) + $extra_room_underneath - $lip_thickness + $fudge + $thickness; */
          cylinder(r=inner_case_radius, h=inner_case_height);
        }
        // standin for lev
        cone_of_silence(1);
      }

      total_sponson();
      rotate(180) total_sponson();
    }

    // makes sure the opening to the acoustic sphere is at least vertical
    translate([0,0,-well_z(middle_radius(), $end_angle)]) cylinder(r=well_radius(middle_radius(), $end_angle), h=$lip_thickness);

    // used to have hole for other sponson
    /* translate([-middle_radius(),well_radius(outer_radius(), $end_angle),sponson_z]){
      %cube(middle_radius()*2);
    } */

    /* scale([0.75,0.75, 1]) {
      /* translate([0,-well_radius(outer_radius(), $end_angle) * 0.75 / 2,0]) %sponson(); */
    /* } */
  }
}
