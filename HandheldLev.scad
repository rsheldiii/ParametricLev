include <src/transducer.scad>
include<src/lev.scad>
include <src/case.scad>

middle_radius() = 56; // for handheld
$thickness = 3; // for handheld
$end_angle = 75; // for handheld

// how many transducers in the first ring
$start_number = 6;

lev();
