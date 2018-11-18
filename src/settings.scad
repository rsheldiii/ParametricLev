$fn=128;
// $fudge factor used strategically to eliminate crosshatching in previews without actually introducing extra play
$fudge = 0.01;

// standing nodes are made every half wavelength, so it's probably pertinent that the
// inner radius be a multiple of that
$half_wavelength = 4.68541666667;


// radius of inner sphere
$radius = $half_wavelength * 22;
// $thickness of sphere wall
$thickness = 5;

// the sphere is "cut off" - has a chunk missing - in the middle. how much is determined by this angle and some napkin trig
$end_angle = 33.109;

// how many transducers in the first ring
$start_number = 6;

// variables for the casing

$lip = 5;
$extra_room_underneath = 10;
$wall_thickness = 2;
$lip_thickness = 4;


// transducer settings

// 0.25 is slop for the transducers. 0.2 can sometimes yield a press fit
$transducer_diameter = 16 + 0.25;
$transducer_height = 12;
$transducer_leg_diameter = 2.5; // really 1mm but don't wanna skimp
$transducer_leg_separation_radius = 10 / 2;
$transducer_leg_height = 10;
$transducer_inset = 1;

// calc'ed variables
function inner_radius() = $radius;
function middle_radius() = inner_radius() + $transducer_height - $transducer_inset;
function outer_radius() = middle_radius() + $thickness;
// functions

// how far down the well is
function well_z(hypotenuse, angle) = cos(angle) * hypotenuse;
// how deep the well of transducers is
function well_depth(hypotenuse, angle) = hypotenuse - well_z(hypotenuse, angle);
// radius of the well of transducers
function well_radius(hypotenuse, angle) = sin(angle) * hypotenuse;

// what radius of circle can I place n circles of diameter d on so that they just barely don't touch?
function radius_for_circles(d, n) = 1 / (sin(180 / n)) * d / 2;
// how many circles of diameter d could fit on another circle of radius r without touching each other?
function circles_for_circumscribed_radius(r, d) = round(360 / (asin((d / 2) / r) * 2));

// if I have a chord with radius chord_r in a sphere of size r, if I were to draw a line from the bottom to the center, and then from the chord to the center, what would the angle be?
function angle_for_chord_radius(chord_r, r) = asin(chord_r / r);
// if I know the angle of a chord in a sphere, what is the chord's radius?
function chord_radius_for_angle(angle, radius) = sin(angle) * radius;
// given a side length r, what is the internal angle of the regular polygon that circumscribes that circle?
function circumscription_angle(r, s) = atan(s / 2 / r) * 2;

module transducer_placement(radius, rotation=[], inset=$transducer_inset) {
  rotate(rotation) translate([0,0,-radius - inset]) rotate(90) children();
}
