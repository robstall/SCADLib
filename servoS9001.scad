
module servoS9001() {
  union() {
    cube([40.5,20,36.1]); // main body
    translate([-7.5,1,26.6]) cube([55.1,18,29.1-26.1]); // screw plate
    translate([-4.5,9,29.1]) cube([49.5,2,1]); // Tabs on screw plate
  }
}

servoS9001();
