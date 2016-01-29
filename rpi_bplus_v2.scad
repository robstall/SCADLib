include <plate.scad>

rpi_bplus();

module rpi_bplus() {
  off_mounting_hole = 3.5;
  
  board = [85, 56, 1.4];
  usb = [10, 10, 10];
  eth = [13, 10, 10];
  audio = [5, 10, 5];
  hdmi = [10, 5, 4];
  m_usb = [5, 4, 3];
  m_sd = [10, 10, 3];
  gpio = [50, 5, 5];
  
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
  translate([2.75+29-gpio[x]/2, 2.75+49-gpio[y]/2, board[z]])
    cube(gpio);
}