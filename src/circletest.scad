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

module transducers_for(middle_radius(), side, start_number, end_angle, cylinder_height) {
  // we want to start at a certain number of transducers. could start at 0 and
  // let it figure it out, but that always results in a starting number of 6,
  // and sometimes I want 3
  start_chord_radius = radius_for_circles(side, start_number);
  start_angle = angle_for_chord_radius(start_chord_radius, middle_radius()-cylinder_height);

  echo("start chord middle_radius(): ",start_chord_radius);
  echo("start angle: ", start_angle);

  // how much we have to rotate the next row on the y axis before it's guaranteed not to collide with the row below
  angle_increment = circumscription_angle(middle_radius()-cylinder_height, side);

  for (angle = [start_angle:angle_increment:end_angle]) {
    // find the middle_radius() of the chord of the circle at our angle of inclination,
    // which corresponds to the middle_radius() of the circle we wish to "circumscribe"
    chord_radius = chord_radius_for_angle(angle, middle_radius()-cylinder_height);

    echo("chord_radius: ", chord_radius);

    // find out how many circles we can fit on that middle_radius()
    n = circles_for_circumscribed_radius(chord_radius, side);

    echo("n: ", n);

    for (y = [0:n]) {
      // put em there duh
      rotate([0, angle, 360 / n * y]) translate([0, 0, -middle_radius()]) cylinder(h=cylinder_height, d=side);
    }
  }
}

transducers_for(100, 16, 6, 40, 12);
