include <lib/fields.scad>;

//twist_field(360, 200, 15, 12, 10) skew_field([0, 0, 0], [5, 5, 5], 200, 15, 12, 10) scale_field([1, 1, 1], [5, 2, 2], 20, 15, 12, 10) cylinder(10, d=3, $fn=8);

module extruded_airfoil() {
  linear_extrude(height = 203) import("../dxf/airfoil.dxf");
}

module extruded_airfoil_cylinder_superimposed() {
  linear_extrude(height = 203) import("../dxf/airfoil.dxf");
  color("red") translate([100, 0, 0]) cylinder(1, d=300);
}

//extruded_airfoil_cylinder_superimposed();
module intersection_airfoil_cylinder() {
  intersection() {
    linear_extrude(height = 203) import("../dxf/airfoil.dxf");
    color("red") translate([100, 0, 0]) cylinder(1, d=300);
  }
}

//intersection_airfoil_cylinder();

module scaled_extruded_airfoil() {
  linear_extrude(height = 203, scale=[0.3, 0.3]) import("../dxf/airfoil.dxf");
}

//scaled_extruded_airfoil();

module hull_wing() {
  hull() {  
    linear_extrude(height = 0.5) scale([0.2, 0.2, 1]) import("../dxf/airfoil.dxf");
    translate([-100, 0, 203]) linear_extrude(height = 0.5) import("../dxf/airfoil.dxf");
  }
}

//hull_wing();
module fn_30_cylinder() {
  cylinder(10, d=5, $fn=30);
}

module default_cylinder() {
  cylinder(10, d=5);
}

function xy_interp(start, end, steps, step) =
  interp([start[0], start[1], 0], [end[0], end[1], 0], steps, step);

// start and end are [x, y, z] vectors for the translation.
module translate_field(diameter, height, steps, start, end) {
  for (i=[0:steps - 1]) {
    // take the intersection of the transformed object and
    // a cylinder to cut out a thin slice
    intersection() {
      // apply the appropriate transformation to the object.
      // note that the interpolate function doesn't
      //exist in OpenSCAD, I need to write it myself
      translate(xy_interp(start, end, steps, i)) {
         children(0);
      }
      // translate a thin cylinder to the correct height for this
      // step on the original object
      translate([0, 0, i * (height / steps)]) {
        cylinder((height / steps), d=diameter);
      }
    }
  }
}

module scaled_translated_wing(steps) {
  translate_field(600, 203, steps, [0, 0, 0], [100, 0, 0]) {
    scaled_extruded_airfoil();
  }
}

translate([-200, 0, 0]) scaled_translated_wing(20);
scaled_translated_wing(50);
translate([200, 0, 0]) scaled_translated_wing(500);

