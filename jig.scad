include <src/transducer.scad>
include <src/lev.scad>
include <src/case.scad>

union(){
  /* translate([0,0,0]) lev();
  outside(); */
  /* translate([0,0,40]) cube(20, center = true); */
  /* translate([0,-500, 0]) cube(1000); */
}


/* translate([0,0,-middle_radius()+22]) %cylinder(r=well_radius(middle_radius(), $end_angle)); */
// no idea why +1. really need to figure this out
/* translate([0,0,-$lip_thickness+1]) rotate(0) mirror([0,1,0]) {

  outside();
  lev();

} */
difference() {
  translate([0,0,-9]) cube(17, center=true);
  transducer(d2=$transducer_diameter + 1);
  translate([5,0,-14]) cube([14,14,8], center = true);
}
