/*
  Simple method of rounding off corners. If the radius is zero or the radius more than half the width or height, a cube will be rendered instead.
*/

module plate(v, r=0) {
  if (r <= 0 || r > v[0] / 2 || r > v[1] / 2) {
    cube(v);
  }
  else {
    union() {
      linear_extrude(v[2])
        polygon(
          [
            [r, 0],
            [v[0]-r, 0],
            [v[0], r],
            [v[0], v[1]-r],
            [v[0]-r, v[1]],
            [r, v[1]],
            [0, v[1]-r],
            [0, r]
          ],
          [[0,1,2,3,4,5,6,7]]
        );
      translate([r, r, 0]) cylinder(r=r, h=v[2]);
      translate([v[0]-r, r, 0]) cylinder(r=r, h=v[2]);
      translate([v[0]-r, v[1]-r, 0]) cylinder(r=r, h=v[2]);
      translate([r, v[1]-r, 0]) cylinder(r=r, h=v[2]);
    }
  }
}

/*
// Quick rendering example. Corner is just beveled.
plate([20, 40, 2], r=2, $fn=4);

// Nicer looking corner but takes longer to render.
translate([-10, 0, 10]) rotate([0, 90, 0]) plate([10, 10, 3], r=3, $fn=24); 
*/