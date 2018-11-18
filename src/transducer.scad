include <settings.scad>

module transducer(height = $transducer_height, d2=$transducer_diameter, fn=$fn) {
  cylinder(d=$transducer_diameter, d2=d2, h=height, $fn=fn);
  translate([0, $transducer_leg_separation_radius, -$transducer_leg_height]) {
    cylinder(h=$transducer_leg_height + $fudge, d=$transducer_leg_diameter, $fn=24);
  }
  translate([0, -$transducer_leg_separation_radius, -$transducer_leg_height]) {
    cylinder(h=$transducer_leg_height + $fudge, d=$transducer_leg_diameter, $fn=24);
  }
}
