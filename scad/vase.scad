FN=8;
DIA = 5;
BASE=15;
BOTTOM_ANGLE=30;
DIAG_LENGTH=25;
RISER = BASE * 2;
SHALLOW_OUT=4;
STEEP_OUT=SHALLOW_OUT * 2;
TILT=10;
OCTOGON_HEIGHT = (2 * cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER) * cos(TILT);
OCTOGON_OVERLAP_HEIGHT = OCTOGON_HEIGHT;
OCTOGON_WIDTH = BASE + 2 * sin(BOTTOM_ANGLE) * DIAG_LENGTH;
OCTOGON_OVERLAP_WIDTH = OCTOGON_WIDTH - DIA / 2;
BASE_RAD = tan(67.5) * OCTOGON_OVERLAP_WIDTH / 2;
module bar(a, b) {
hull() {
    translate(a) sphere(DIA, $fn=FN);
    translate(b) sphere(DIA, $fn=FN);
}
}
module octogon() {
bar([-BASE / 2, 0, 0], [BASE / 2, 0, 0]) ;
bar([BASE / 2, 0, 0], [(BASE / 2) + sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH]);
bar([-BASE / 2, 0, 0], [-(BASE / 2) - sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH]);
bar([(BASE / 2) + sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH], [(BASE / 2) + sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER]);
bar([-(BASE / 2) - sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH], [-(BASE / 2) - sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER]);
bar([-(BASE / 2) - sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER], [-(BASE / 2), 0, 2 * cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER]);
bar([(BASE / 2) + sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER], [(BASE / 2), 0, 2 * cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER]);
bar([-(BASE / 2), 0, 2 * cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER], [(BASE / 2), 0, 2 * cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER]);
bar([-(BASE / 2) - sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH], [0, SHALLOW_OUT, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER / 2]);
bar([0, SHALLOW_OUT, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER / 2], [(BASE / 2) + sin(BOTTOM_ANGLE) * DIAG_LENGTH, 0, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER]);
bar([-BASE / 2, 0, 0], [0, -STEEP_OUT, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER / 2]);
bar([0, -STEEP_OUT, cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER / 2], [(BASE / 2), 0, 2 * cos(BOTTOM_ANGLE) * DIAG_LENGTH + RISER]);
}
module wall() {
octogon();
translate([0, 0, OCTOGON_OVERLAP_HEIGHT]) mirror([1, 0, 0]) octogon();
translate([0, 0, OCTOGON_OVERLAP_HEIGHT * 2]) octogon();
translate([0, 0, OCTOGON_OVERLAP_HEIGHT * 3]) mirror([1, 0, 0]) octogon();
}

module level() {
translate([0, -BASE_RAD, 0]) rotate([TILT, 0, 0]) octogon();
rotate([0, 0, 360 / 8]) translate([0, -BASE_RAD, 0]) mirror([1, 0, 0]) rotate([TILT, 0, 0]) octogon();
rotate([0, 0, 360 / 8 * 2]) translate([0, -BASE_RAD, 0]) rotate([TILT, 0, 0]) octogon();
rotate([0, 0, 360 / 8 * 3]) translate([0, -BASE_RAD, 0]) mirror([1, 0, 0]) rotate([TILT, 0, 0]) octogon();
rotate([0, 0, 360 / 8 * 4]) translate([0, -BASE_RAD, 0]) rotate([TILT, 0, 0]) octogon();
rotate([0, 0, 360 / 8 * 5]) translate([0, -BASE_RAD, 0]) mirror([1, 0, 0]) rotate([TILT, 0, 0]) octogon();
rotate([0, 0, 360 / 8 * 6]) translate([0, -BASE_RAD, 0]) rotate([TILT, 0, 0]) octogon();
rotate([0, 0, 360 / 8 * 7]) translate([0, -BASE_RAD, 0]) mirror([1, 0, 0]) rotate([TILT, 0, 0]) octogon();
}

module vase() {
level();
translate([0, 0, OCTOGON_OVERLAP_HEIGHT * 2]) mirror([0, 0, 1]) level();
translate([0, 0, OCTOGON_OVERLAP_HEIGHT * 2])  level();
translate([0, 0, OCTOGON_OVERLAP_HEIGHT * 4]) mirror([0, 0, 1]) level();
translate([0, 0, OCTOGON_OVERLAP_HEIGHT * 4]) level();
}

module vase_with_flattened_base() {
difference() {
    vase();
    #translate([0, 0, -6]) cube([300, 300,5], center=true);
} 
}

bar([60, 0, 0], [60, 0, 70]);
translate([120, 0, 0]) octogon();
translate([240, 0, 0,]) level();
translate([420, 0, 0,]) vase();
