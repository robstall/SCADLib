$fn = 32;

pzCirBrdDim = [65,30,1.2]; // pi zero circuit board dim
pzStdOffOffset = 3.5; // pi zero stand off hole center offset
pzStdOffDia = 2.75; // pi zero stand off hole diameter
pzCnrRad = 3.0;

wallThickness = 1.6;   // Case wall thickness
bottomThickness = 1.6; // Case botton thickness
topThickness = 1.6;    // Case top thickness
standoffHeight = 1.2;  // Case standoff height
gap = 0.4;             // Gap between pi and inside walls
wallHeight = 8;       // Height off wall not counting bottom

connectorDim = [50.6,5,2.3]; // Connector for pins

//drawRpi();
drawBottom();
drawWalls();

// Calculated globals
bottomDim = [
  pzCirBrdDim[0] + wallThickness * 2 + gap * 2,
  pzCirBrdDim[1] + wallThickness * 2 + gap * 2,
  bottomThickness
];

cornerRadius = pzCnrRad + gap + wallThickness;

module bottom(center = true) {
  d = bottomDim;
  t = center ? [-d[0]/2,-d[1]/2,0] : [0,0,0];
  
  translate(t) {
    rcube(d, r=cornerRadius);
    so = pzStdOffOffset + wallThickness + gap;
    translate([so, so, bottomThickness]) standOff();
    translate([bottomDim[0]-so, so, bottomThickness]) standOff();
    translate([so, bottomDim[1]-so, bottomThickness]) standOff();
    translate([bottomDim[0]-so, bottomDim[1]-so, bottomThickness]) standOff();
  }
}

module standOff() {
  cylinder(d=pzStdOffDia+2, h=standoffHeight);
  cylinder(d=2.5, h=standoffHeight+pzCirBrdDim[2]*1.5);
}

module walls(center = true) {
  d = [bottomDim[0], bottomDim[1], wallHeight];
  t = center ? [-d[0]/2,-d[1]/2,0] : [0,0,0];
  
  translate(t) {
    difference() {
      rcube(d, r=cornerRadius);
      translate([wallThickness, wallThickness, -.01]) 
        rcube([d[0]-wallThickness*2, d[1]-wallThickness*2, d[2]+.02], r=cornerRadius-wallThickness);
      wallCutouts();
    }
    //color("red") wallCutouts();
  }
}

module wallCutouts() {
  hdmiCenterX = 12.4 + wallThickness + gap;
  hdmiWidth = 11.0 + 2;
  usbCenterX = 41.4 + wallThickness + gap;
  usbWidth = 7.8 + 2;
  pwrCenterX = 54.0 + wallThickness + gap;
  pwrWidth = 7.8 + 2;
  sdCenterY = 16.9 + wallThickness + gap;
  sdWidth = 11.8 + 2;
  camCenterY = pzCirBrdDim[1]/2 + wallThickness + gap;
  camWidth = 16.7 + 2;
  pinCenterX = pzCirBrdDim[0]/2 + wallThickness + gap;
  pinWidth = 50.6 + 2;
  
  hdmi = [hdmiWidth, wallThickness+0.2, wallHeight];
  usb = [usbWidth, wallThickness+0.2, wallHeight];
  pwr = usb;
  sd = [wallThickness+0.2, sdWidth, wallHeight];
  pin = [pinWidth, wallThickness+0.2, wallHeight];
  z = standoffHeight;
  
  translate([hdmiCenterX-hdmiWidth/2, -0.1, z]) cube(hdmi);
  translate([usbCenterX-usbWidth/2, -0.1, z]) cube(usb);
  translate([pwrCenterX-pwrWidth/2, -0.1, z]) cube(pwr);
  translate([-0.1, sdCenterY-sdWidth/2, z]) cube(sd);
  translate([bottomDim[0]-wallThickness-0.1, camCenterY-camWidth/2, z]) cube(sd);
  translate([pinCenterX-pinWidth/2, bottomDim[1]-wallThickness-0.1, z]) cube(pin);
}

module rcube(v, r=3) {
  union() {
    difference() {
      cube(v);
      translate([-.001,-.001,-.01]) cube([r,r,v[2]+.02]);
      translate([v[0]-r+.001,-.001,-.01]) cube([r,r,v[2]+.02]);
      translate([v[0]-r+.001,v[1]-r+.001,-.01]) cube([r,r,v[2]+.02]);
      translate([-.001,v[1]-r+.001,-.01]) cube([r,r,v[2]+.02]);
    }
    translate([r,r,0]) cylinder(r=r,h=v[2]);
    translate([v[0]-r,r,0]) cylinder(r=r,h=v[2]);
    translate([v[0]-r,v[1]-r,0]) cylinder(r=r,h=v[2]);
    translate([r,v[1]-r,0]) cylinder(r=r,h=v[2]);
  }
}

module rpi_zero(center=true) {
  d = pzCirBrdDim;
  t = center ? [-d[0]/2,-d[1]/2,0] : [0,0,0];
  off = pzStdOffOffset;
  r = pzStdOffDia/2;
  translate(t) {
    color("green") difference() {
      rcube(d);
      translate([off,off,-.01]) cylinder(r=r,h=d[2]+.02);
      translate([d[0]-off,off,-.01]) cylinder(r=r,h=d[2]+.02);
      translate([d[0]-off,d[1]-off,-.01]) cylinder(r=r,h=d[2]+.02);
      translate([off,d[1]-off,-.01]) cylinder(r=r,h=d[2]+.02);
    }
    translate([0,d[1]+connectorDim[1]/2,0]) pins();
  }
}

module pins() {
  d = pzCirBrdDim;
  cd = connectorDim;
    color("gray") 
      translate([(d[0]-cd[0])/2,0,d[2]]) 
        rotate([90,0,0])
          cube(cd);
}

module drawRpi() {
  z = bottomThickness + standoffHeight;
  translate([0,0,z]) rpi_zero();
}

module drawBottom() {
  bottom();
}

module drawWalls() {
  translate([0,0,bottomThickness]) walls();
};