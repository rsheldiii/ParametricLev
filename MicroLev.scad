include <src/transducer.scad>
include<src/lev.scad>
include <src/case.scad>

// middle_radius() of inner sphere
// exactly 12 wavelengths
middle_radius() = 26;
// $thickness of sphere wall
$thickness = 4;

// the sphere is "cut off" - has a chunk missing - in the middle. how much is determined by this angle and some napkin trig
$end_angle = 57;

// how many transducers in the first ring
$start_number = 3;



// variables for the casing

$lip = 5;
$extra_room_underneath = 3;
$wall_thickness = 2;
// can't be less than the $thickness of the levitator sphere in weird scenarios
$lip_thickness = 2;



union(){
  /* translate([0,0,0]) lev();
  outside(); */
  /* translate([0,0,40]) cube(20, center = true); */
  /* translate([0,-500, 0]) cube(1000); */
}

// top
translate([0,0,0]) rotate([0,0,0]) mirror([1,0,0]) {
  translate([0,0,0]) lev();
  outside();
}


/* translate([0,0,-middle_radius()+22]) %cylinder(r=well_radius(middle_radius(), $end_angle)); */

/* mirror([0,0,1]) {

  outside();
  lev();

} */
