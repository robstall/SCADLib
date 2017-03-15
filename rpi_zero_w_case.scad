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
upperStandoffHeight = wallHeight-standoffHeight-pzCirBrdDim[2]-0.4;

connectorDim = [50.6,5,2.3]; // Connector for pins

// Cutouts
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

//drawRpi();
color("red") drawBottom();
color("yellow") drawWalls();
color("blue") drawTop();

// Calculated globals
bottomDim = [
  pzCirBrdDim[0] + wallThickness * 2 + gap * 2,
  pzCirBrdDim[1] + wallThickness * 2 + gap * 2,
  bottomThickness
];

cornerRadius = pzCnrRad + gap + wallThickness;

module top(center = true) {
  d = bottomDim;
  t = center ? [-d[0]/2,-d[1]/2,0] : [0,0,0];
  
  lipHeight = 2.5;
  lip = [d[0]-wallThickness*2, d[1]-wallThickness*2, lipHeight];
  thk = wallThickness;
  
  translate(t) {
    // The top plate
    difference() {
      rcube(d, r=cornerRadius);
      translate([pwrCenterX-5, 1, 1]) linear_extrude(height=1) text("PWR", size=3);
      translate([usbCenterX-4.4, 1, 1]) linear_extrude(height=1) text("USB", size=3);
      translate([0, 0, -.1]) vents();
    }
    
    // The bits that extend into the cutouts
    hdmi = [hdmiWidth-1, wallThickness+0.2, lipHeight];
    usb = [usbWidth-1, wallThickness+0.2, lipHeight];
    pwr = usb;
    sd = [wallThickness+0.2, sdWidth-1, lipHeight];
    
    z = -lipHeight;
    translate([hdmiCenterX-hdmiWidth/2, -0.1, z]) cube(hdmi);
    translate([usbCenterX-usbWidth/2, -0.1, z]) cube(usb);
    translate([pwrCenterX-pwrWidth/2, -0.1, z]) cube(pwr);
    translate([-0.1, sdCenterY-sdWidth/2, z]) cube(sd);
    translate([bottomDim[0]-wallThickness-0.1, camCenterY-  camWidth/2, z]) cube(sd);
    
    // The inner rim
    translate([wallThickness, wallThickness, -lip[2]]) {
      difference() {
        rcube(lip, r=pzCnrRad+gap);
        translate([2, 2, -0.01]) 
          rcube([lip[0]-2*thk, lip[1]-2*thk, lip[2]+.02], r=    pzCnrRad+gap-2);
          translate([pinCenterX-pinWidth/2-thk, d[1]-8, -.01])
            cube([pinWidth, 5, lip[2]+.02]);
      }
    }
    
    // Stand offs
    so = pzStdOffOffset + wallThickness + gap;
    zus = -upperStandoffHeight;
    translate([so, so, zus]) upperStandOff();
    translate([bottomDim[0]-so, so, zus]) upperStandOff();
    translate([so, bottomDim[1]-so, zus]) upperStandOff();
    translate([bottomDim[0]-so, bottomDim[1]-so, zus]) upperStandOff();
    
    // Pinguard
    translate([pinCenterX-pinWidth/2-1, bottomDim[1], 0]) topPinGuard();
    
  }
}

module vents() {
  vy = bottomDim[1]-16;
  offx = (bottomDim[0] - 10*6) / 2 + 1.5;
  for (n = [0:9]) {
    translate([n*6+offx, ((bottomDim[1]-vy)/2), 0]) rcube([3, vy, topThickness+.2], r=1.5);
  }
}

module bottom(center = true) {
  d = bottomDim;
  t = center ? [-d[0]/2,-d[1]/2,0] : [0,0,0];
  
  translate(t) {
    // plate
    rcube(d, r=cornerRadius);
    
    // stand offs
    so = pzStdOffOffset + wallThickness + gap;
    translate([so, so, bottomThickness]) standOff();
    translate([bottomDim[0]-so, so, bottomThickness]) standOff();
    translate([so, bottomDim[1]-so, bottomThickness]) standOff();
    translate([bottomDim[0]-so, bottomDim[1]-so, bottomThickness]) standOff();
    
    // guard
    translate([pinCenterX-pinWidth/2-1, d[1], bottomThickness]) bottomPinGuard();
  }
}

module standOff() {
  cylinder(d=pzStdOffDia+2, h=standoffHeight);
  //cylinder(d=2.5, h=standoffHeight+pzCirBrdDim[2]*1.5);
}

module upperStandOff() {
  cylinder(d=pzStdOffDia+2, h=upperStandoffHeight);
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

module bottomPinGuard() {
  difference() {
    cube([pinWidth+2, 7, wallHeight]);
    translate([1, -.001, pzCirBrdDim[2]]) cube([pinWidth, 7.002, wallHeight]);
  }
}

module topPinGuard() {
    cube([pinWidth+2, 7, topThickness]);
}

module wallCutouts() {
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

module drawTop() {
  translate([0,0,bottomThickness+wallHeight]) top();
};