include <settings.scad>

module transducers_for(angle_adjustment=0, transducer_increment=undef) {
  // what radius gets us the number of starting circles we want
  start_chord_radius = radius_for_circles($transducer_diameter, $start_number);
  check = circles_for_circumscribed_radius(start_chord_radius, $transducer_diameter);

  echo("check: ", check);
  // what angle that radius is at
  start_angle = angle_for_chord_radius(start_chord_radius, inner_radius()) - angle_adjustment; // may have to adjust
  // how much we have to rotate the next row on the y axis before it's guaranteed not to collide with the row below
  angle_increment = circumscription_angle(inner_radius(), $transducer_diameter);

  echo("start chord radius: ",start_chord_radius);
  echo("start angle: ", start_angle);
  echo("start number:", $start_number);

  check2 = chord_radius_for_angle(start_angle, inner_radius());
  echo("check2: ", check2);


  // TODO the end angle is wrong and I don't know why
  // If you're digging in the code wondering why transducer placement isn't
  // ideal for your setup, this is a good place to fiddle
  for (angle = [start_angle:angle_increment:($end_angle - angle_increment/2)]) {
    index = (angle - start_angle) / angle_increment;
    // find the radius of the chord of the circle at our angle of inclination,
    // which corresponds to the radius of the circle we wish to "circumscribe"
    chord_radius = chord_radius_for_angle(angle, inner_radius());

    // find out how many circles we can fit on that radius
    circles_this_slice = transducer_increment ?
      $start_number + index * transducer_increment :
      circles_for_circumscribed_radius(chord_radius, $transducer_diameter);

    echo ("----------------------");
    echo("index: ", index);
    echo("chord_radius: ", chord_radius);
    echo("number: ", circles_this_slice);

    for (y = [0:circles_this_slice]) {
      // put em there duh
      transducer_placement(middle_radius(), [0, angle, 360 / circles_this_slice * y]) {
        children();
      }
    }
  }
}

module cone_of_silence(multiplier = 2) {
  height = (outer_radius() - well_depth(outer_radius(), $end_angle)) * multiplier;

  translate([0,0,-height]) cylinder(d2 = 1, r1 = chord_radius_for_angle($end_angle, outer_radius())*multiplier, h=height);
  /* translate([0,0,well_depth(outer_radius(),$end_angle)]) cube(outer_radius()*2, center = true); */
}

module outer_sphere() {
  intersection() {
    difference() {
      sphere(outer_radius());
      sphere(middle_radius());
    }

    cone_of_silence(100);
  }
}

module no_go_zone() {
  difference() {
    sphere(inner_radius());
    translate([0, 0, well_depth(inner_radius(), $end_angle)]) cube((inner_radius()) * 2, center = true);
  }
}

module lev(angle_adjustment=0) {
  /* rotate([0,$end_angle,0]) translate([0,0,-100]) cube([1,1,200], center = true); */
  difference() {
    outer_sphere();
    transducers_for(angle_adjustment){
      transducer();
    }
  }
  transducers_for(angle_adjustment){
    /* %transducer(fn=24); */
    /* %transducer(middle_radius()+1, 0, 24); */
  };

  // no-go zone
  /* %color([1,0,0,0.3]) no_go_zone(); */
}
