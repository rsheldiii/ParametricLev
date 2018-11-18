// old transducer placement version where the math isn't automagically done. still useful for manual stuff maybe
module old_transducers() {
  // how much further up is the next set of transducers. first set starts at this number too
  x_angle_increase = 10;
  x_angle_max = $end_angle - 10;

  // how many transducers in the first ring
  number_start = 6;
  // how many more transducers in the next
  number_increase = 6;

  for(x = [x_angle_increase:x_angle_increase:x_angle_max]) {
    num_x = (x - x_angle_increase) / x_angle_increase;
    z_angle_inc = 360 / (num_x * number_increase + number_start);

    for(z = [x:z_angle_inc:360+x]) {
      transducer_placement([x,0,z]) {
        transducer();
        /* %transducer(107); */
      }
    }
  }
}


// old automagic transducer placement on circles I don't want to forget

// what middle_radius() of circle can I place n circles of diameter d on so that they just barely don't touch?
function radius_for_circles(d, n) = 1 / (sin(180 / n)) * d / 2;
// how many circles of diameter d could fit on another circle of middle_radius() r without touching each other?
function circles_for_circumscribed_radius(r, d) = round((360 / (asin((d / 2) / r) * 2)));

// if I have a chord with middle_radius() chord_r in a sphere of size r, if I were to draw a line from the bottom to the center, and then from the chord to the center, what would the angle be?
function angle_for_chord_radius(chord_r, r) = asin(chord_r / r);
// if I know the angle of a chord in a sphere, what is the chord's middle_radius()?
function chord_radius_for_angle(angle, middle_radius()) = sin(angle) * middle_radius();
// given a side length r, what is the internal angle of the regular polygon that circumscribes that circle?
function circumscription_angle(r, s) = atan(s / 2 / r) * 2;

/* module circumscribe_with_number(n, side) {
  middle_radius() = radius_for_circles(side, n);
  circle(r = middle_radius());
  for( x = [0:n]) {
    color([.3, .6, .0]) rotate([0,0,360 / n * x]) translate([middle_radius(), 0,0]) cylinder(h=10, d=side);
  }
}

module circumscribe_with_radius(middle_radius(), side) {
  sides = circles_for_circumscribed_radius(middle_radius(), side);

  circle(r=middle_radius());
  for(x = [0:1:sides]) {
    rotate([0,0,360 / sides * x]) translate([middle_radius(), 0, 0]) {
      color([.3, .6, .0]) cylinder(h=10, d=side);
    }
  }
} */

/* circumscribe_with_number(6, 16);
circumscribe_with_number(12, 16); */



// old way of doing transducer layouts
/* module transducers() {
  x_angle_increase = (asin((transducer_diameter / 2) / (middle_radius() - transducer_height)) * 2);
  echo("X angle increase:");
  echo(x_angle_increase);
  x_angle_max = $end_angle-5;

  for(x = [x_angle_increase:x_angle_increase:x_angle_max]) {
    num_x = (x - x_angle_increase) / x_angle_increase;
    z_angle_inc = 360 / (num_x * number_increase + number_start);

    for(z = [0:z_angle_inc:360+0]) {
      transducer_placement([x,0,z]) {
        transducer();
        // enable to make sure all the transducers point where you expect
        // %transducer(middle_radius(), .01);
      }
    }
  }
} */
