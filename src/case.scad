include <lev.scad>

module sponson(radius, shift=0) {
  rad = well_radius(radius, $end_angle) + $lip + $wall_thickness;
  height = well_z(middle_radius(), $end_angle); // TODO magic numbers everywhere and no idea why

  difference() {
    cylinder(r=rad, h=height);
    // cutoff cube
    translate([-outer_radius()*2, -well_radius(outer_radius(), $end_angle)-shift, -$fudge]) cube(outer_radius()*4);
    /* %translate([-outer_radius()*2, -well_radius(outer_radius(), $end_angle), -$fudge]) cube(outer_radius()*4); */
  }
}

module outside() {

  sponson_z = -well_z(outer_radius(), $end_angle) + $lip_thickness;


  difference() {
    // outer cylinder
    union() {
      difference() {
        translate([0,0,-outer_radius() - $extra_room_underneath]) {
          rad = well_radius(outer_radius(),$end_angle) + $lip + $wall_thickness;
          height = well_depth(outer_radius(),$end_angle) + $extra_room_underneath + $thickness;
          cylinder(r=rad, h=height-.81);
        }
        // inner cylinder
        translate([0,0,-outer_radius() - $extra_room_underneath - $fudge]) {
          rad = well_radius(outer_radius(),$end_angle)+$lip;
          height = well_depth(outer_radius(),$end_angle) + $extra_room_underneath - $lip_thickness + $fudge + $thickness;
          cylinder(r=rad, h=height);
        }
        // standin for lev
        cone_of_silence(1);
      }

      translate([0,0,sponson_z]) {
        sponson(outer_radius());
        rotate(180) sponson(outer_radius());
      }

    }

    // makes sure the opening to the acoustic sphere is at least vertical
    translate([0,0,-well_z(middle_radius(), $end_angle)]) cylinder(r=well_radius(middle_radius(), $end_angle), h=$lip_thickness);

    // inner sponson on right side
    rotate([0,0,180]) scale([1,1,3]) {
      translate([0,0,sponson_z+1]){
          sponson(middle_radius(), 1);
        }
    }

    // used to have hole for other sponson
    /* translate([-middle_radius(),well_radius(outer_radius(), $end_angle),sponson_z]){
      %cube(middle_radius()*2);
    } */

    // inner sponson on left side
    scale([1,1,3]) {
      translate([0, 0,sponson_z+1]) sponson(middle_radius(), 1);
    }

    scale([0.75,0.75, 1]) {
      /* translate([0,-well_radius(outer_radius(), $end_angle) * 0.75 / 2,0]) %sponson(); */
    }
  }
}
