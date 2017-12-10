// FN controls how many faces the cylinders
// and circles have. I keep it to a low value
// during development to speed up render time.
FN=8;

// Default bar diameter.
DIA = 4;

// This method of making a bar takes the convex hull
// of a pair of spheres centered at the specified points.
// I like this method better than using cylinders for two
// reasons. First, it's usually easier to just specify the
// beginning and end points of the line you want to draw than
// to work out the rotation and translation factors for 
// a cylinder of the right length and diameter. Second, the
// spherical ends of a bar created this way are much better
// for connecting multiple bars together than the flat ends
// of a cylinder.
//
// @param a (Array) : [x, y, z]
// @param b (Array) : [x, y, z]
// @param dia (Number) : diameter
module bar(a, b, dia=DIA, $fn=FN) {
  hull() {
    translate(a) sphere(dia / 2, $fn=$fn);
    translate(b) sphere(dia / 2, $fn=$fn);
  }
}

module bar_rect(height, width) {
  bar([-width / 2, 0, 0], [width / 2, 0, 0]);
  bar([-width / 2, 0, height], [width / 2, 0, height]);
  bar([width / 2, 0, 0], [width / 2, 0, height]);
  bar([-width / 2, 0, 0], [-width / 2, 0, height]);
}
//bar_rect(20, 10);

module ring(side_width, num_sides) {
  angle_between_sides = 360 / num_sides;
  angle_to_axis = angle_between_sides / 2;
  distance_from_center = side_width / 2 / tan(angle_to_axis);
  for (side = [0:num_sides - 1]) {
    rotate([0, 0, side * 360 / num_sides]) {
      translate([0, distance_from_center, 0]) {
        children(side % $children);
      }
    }
  }
}

module stack(height, num_levels) {
  for (level = [0:num_levels - 1]) {
    translate([0, 0, level * height]) {
      children(level % $children);
    }
  }
}
