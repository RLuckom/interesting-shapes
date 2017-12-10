include<lib/vase_functions.scad>;

module axes() {
axis_length = 100;
color("red") bar([-axis_length, 0, 0], [axis_length, 0, 0], dia = 1);
color("red") bar([0, -axis_length, 0], [0, axis_length, 0], dia = 1);
color("blue") rotate([0, 0, 45]) bar([-axis_length, 0, 0], [axis_length, 0, 0], dia=1);
color("blue") rotate([0, 0, 45]) bar([0, -axis_length, 0], [0, axis_length, 0], dia=1);
}

axes();
trans = tan(45) * 20 / 2;
module t_rect(t) {
  translate([0, t, 0]) bar_rect(30, 20);
}

module fixed_ring() {
  t_rect(trans);
  t_rect(-trans);
  rotate([0, 0, 90]) t_rect(trans);
  rotate([0, 0, 90]) t_rect(-trans);
}

stack(30, 6) ring(20, 47) {
  ring(20, 4) bar_rect(30, 20);
}
