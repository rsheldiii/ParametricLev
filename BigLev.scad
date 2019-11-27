include <src/transducer.scad>
include <src/lev.scad>
include <src/case.scad>

union(){
  /* translate([0,0,0]) lev();
  outside(); */
  /* translate([0,0,40]) cube(20, center = true); */
  /* translate([0,-500, 0]) cube(1000); */
}

sponson_z = -well_z(outer_radius(), $end_angle) + $lip_thickness;


/* translate([0,0,-middle_radius()+22]) %cylinder(r=well_radius(middle_radius(), $end_angle)); */
// no idea why +1. really need to figure this out
/* translate([0,0,-$lip_thickness+1]) rotate(0) mirror([0,1,0]) { */

  outside();
  lev();
  /* total_sponson(); */
  /* rotate(180) total_sponson(); */
  /* translate([0,0,-outer_radius() - $extra_room_underneath - $wall_thickness*3]) top_cover(); */

/* } */
