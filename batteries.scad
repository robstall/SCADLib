function aa4BatteryHolderSize() = [58,63,16];
function pb2sBatterySize() = [98,62,7];

module aaBattery() {
  cylinder(d=14, h=48.5);
  cylinder(d=5.5, h=50.3);
}

module aa4BatteryHolder(center=false) {
  d = aa4BatteryHolderSize();
  
  offX = center ? -d[0]/2 : 0;
  offY = center ? -d[1]/2 : 0;
  
  translate([offX, offY, 0]) {
    difference() {
      cube(d);
      translate([1.5,1.5,1.5]) cube([55, 60, 14.5]);
      translate([21,0,8]) cube([16.5,d[1],8]);
    }
    
    translate([5, 8.5,8.5]) rotate([0,90,0]) aaBattery();
    translate([54,8.5+15.5,8.5]) rotate([0,-90,0]) aaBattery();
    translate([5, 8.5+31,8.5]) rotate([0,90,0]) aaBattery();
    translate([54,8.5+46.5,8.5]) rotate([0,-90,0]) aaBattery();
    
    translate([-4.8, 45, 2]) cube([4.8,4.4,2]);
  }
}

module pb2sBattery(usbplug = false, center=false) {
  d = pb2sBatterySize();
  
  offX = center ? -d[0]/2 : 0;
  offY = center ? -d[1]/2 : 0;
  
  translate([offX, offY, 0]) {
    difference() {
      cube(d);
      translate([-13, 13, 0]) rotate([0,0,-45]) cube([30,11,7]);
    }
    if (usbplug) {
      translate([16.5-6, d[1], 0.5])
        cube([12,20,6]);
    }
  }
}

//aaBattery();
//aa4BatteryHolder(center=true);
//pb2sBattery(usbplug=true, center=true);