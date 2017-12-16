// Applies a cylindrical scaling field to a union of its children
module scale_field(start_scale, end_scale, dia, height, steps, $fn) {
  apply_scale_field(start_scale, end_scale, dia, height, steps, $fn) {
    union() {
      for (i = [0:$children - 1]) {
        children(i);
      }
    }
  }
}

// Applies a cylindrical scaling field to a union of its children
module skew_field(start_scale, end_scale, dia, height, steps, $fn) {
  apply_skew_field(start_scale, end_scale, dia, height, steps, $fn) {
    union() {
      for (i = [0:$children - 1]) {
        children(i);
      }
    }
  }
}
// Applies a cylindrical scaling field to a union of its children
module twist_field(degrees, dia, height, steps, $fn) {
  apply_twist_field([0, 0, 0], [0, 0, degrees], dia, height, steps, $fn) {
    union() {
      for (i = [0:$children - 1]) {
        children(i);
      }
    }
  }
}

function interp(start_scale, end_scale, steps, step) =
  let (pct = step / steps)
  [
   start_scale[0] + (pct * (end_scale[0] - start_scale[0])),
   start_scale[1] + (pct * (end_scale[1] - start_scale[1])),
   start_scale[2] + (pct * (end_scale[2] - start_scale[2])),
  ];

function z_interp(start_scale, end_scale, steps, step) =
  let (pct = step / steps)
  [
   1,
   1,
   start_scale[2] + (pct * (end_scale[2] - start_scale[2])),
  ];
   

module apply_scale_field(start_scale, end_scale, dia, height, steps, $fn) {
  for (i=[0:steps - 1]) {
    intersection() {
      translate([0, 0, i * (height / steps)]) cylinder((height / steps), d=dia, $fn=$fn);
       scale(interp(start_scale, end_scale, steps, i)) children(0);
    }
  }
}

module apply_skew_field(start_scale, end_scale, dia, height, steps, $fn) {
  for (i=[0:steps - 1]) {
    intersection() {
      translate([0, 0, i * (height / steps)]) cylinder((height / steps), d=dia, $fn=$fn);
       translate(interp(start_scale, end_scale, steps, i)) children(0);
    }
  }
}

module apply_twist_field(start_scale, end_scale, dia, height, steps, $fn) {
  for (i=[0:steps - 1]) {
    intersection() {
      translate([0, 0, i * (height / steps)]) cylinder((height / steps), d=dia, $fn=$fn);
       rotate(z_interp(start_scale, end_scale, steps, i)) children(0);
    }
  }
}
