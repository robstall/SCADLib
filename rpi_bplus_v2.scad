include <plate.scad>

function rpi_bplusSize() = [85, 56, 1.4+15];

module rpi_bplus(show_dongle = 0) {
  off_mounting_hole = 3.5;
  
  board = [85, 56, 1.4];
  usb = [17, 13.2, 15];
  eth = [21, 16, 14];
  audio = [7, 15, 7];
  hdmi = [15, 11.5, 6.5];
  m_usb = [7.3, 5.6, 3];
  m_sd = [17, 13, 1];
  gpio = [2.54 * 20, 5, 2.54];
  cam = [3, 20.5, 4.5];
  dongle = [22, 16.5, 8];
  
  x = 0;
  y = 1;
  z = 2;
  
  difference() {
    plate(board, r=3);
    translate([off_mounting_hole, off_mounting_hole, 0])
      cylinder(d=2.75, h=board[z]);
    translate([off_mounting_hole + 58, off_mounting_hole, 0])
      cylinder(d=2.75, h=board[z]);
    translate([off_mounting_hole + 58, off_mounting_hole + 49, 0])
      cylinder(d=2.75, h=board[z]);
    translate([off_mounting_hole, off_mounting_hole + 49, 0])
      cylinder(d=2.75, h=board[z]);
  }
  
  translate([board[x]-usb[x]+2, 47-usb[y]/2, board[z]])
    cube(usb);
  translate([board[x]-usb[x]+2, 29-usb[y]/2, board[z]])
    cube(usb);
  translate([board[x]-eth[x]+2, 10.25-eth[y]/2, board[z]])
    cube(eth);
  translate([53.5-audio[x]/2, -2, board[z]])
    cube(audio);
  translate([32-hdmi[x]/2, -2, board[z]])
    cube(hdmi);
  translate([10.5-m_usb[x]/2, -2, board[z]])
    cube(m_usb);
  translate([0, 28-m_sd[y]/2,-m_sd[z]])
    cube(m_sd);
  gx = 2.75+29-gpio[x]/2;
  gy = 2.75+49-gpio[y]/2;
  gz = board[z];
  translate([gx, gy, gz])
    cube(gpio);
  // The pins.
  for (i = [0:19]) {
    px = gx + 2.54/4 + 2.54*i;
    translate([px, gy + 2.54/4, gz+gpio[z]])
      cube([0.65,0.65,3.2]);
    translate([px, gy + 2.54 + 2.54/4, gz+gpio[z]])
      cube([0.65,0.65,3.2]);
  }
  
  if (show_dongle > 0) {
      translate([board[x]+2, 29-dongle[y]/2, board[z]+1])
        cube([dongle[x], dongle[y], dongle[z]]);
  }
}

rpi_bplus(show_dongle = 0);