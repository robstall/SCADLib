use <../../SCADLib/batteries.scad>
use <../../SCADLib/plate.scad>
use <../../SCADLib/rpi_bplus_v2.scad>
use <../../SCADLib/sensors.scad>
use <../../SCADLib/servoS9001.scad>

module pb2s() {
  b = pb2sBatterySize();
  translate(0, -b[1]/2, 0)
    pb2sBattery();
}
//aa4BatteryHolder();

module bot() {
  pb2s();
}

color("green") square(145); 
bot();
