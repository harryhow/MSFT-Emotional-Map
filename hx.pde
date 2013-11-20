class hexGroup {
  float hexSize = 15.0; // 15.0 - 40.0 (length of one hex side)
  float margin =25.0; // 10.0 - 50.0 (minimum gap between hexes and edge of display)
  float speed = 0.5; // 0.0 - 0.5 (the speed at which the perlin noise "goes by")
  float noiseScale = 0.08; // 0.03 - 0.15 (the amount of perlin noisiness (or smoothness if you prefer))
  float scaling = 3.0;
   
  int cntW, cntH; //counts of displayed hexes (width and height)
  float borderX, borderY; //size of gap between hexes and edge of display
  float counter = 0.0; //simple counter for perlin noise
   
  hexDef hd = new hexDef(hexSize, scaling); //figures and stores the hex dimensions
  hexagon[][] hexes; //the displayed hexes
   
  hexGroup(float speed1, float offX, float offY){  
    float width1=400;
    float height1=300;
    speed=speed1;
    //figure out hex counts and border sizes
    cntW = int((width1 - 2*margin - hd.ss) / (hd.side + hd.ss));
    cntH = int((height1 - 2*margin) / hd.ls - 1);
    borderX = (width1 - cntW*(hd.side + hd.ss) - hd.ss) / 2.0;
    borderY = (height1 - (cntH + 1)*hd.ls) / 2.0;
    //setup hexes
    hexes = new hexagon[cntW][cntH];
    for(int y = 0; y < cntH; y++)
      for(int x = y%2; x < cntW; x+=2)
        hexes[x][y] = new hexagon(x+offX, y+offY + 1, borderX, borderY, noiseScale, counter, hd);
  }
  void updateCount(){
    counter+=speed;
  }
  void show() {
    for(int y=0; y<cntH; y++)
      for(int x=y%2; x<cntW; x+=2)
        hexes[x][y].show(counter);
  }
}
class hexDef {
  float side, ss, ls, h, w, halfH, halfW, halfSide, offset, offsetBal;
  hexDef(float hexSide, float scaling1) {
    side = hexSide; //length of one hex side (in pixels)
    //if you picture each hex nestled in a rectangle of the same height and width, there would be
    //four right triangles *outside* the hex. I use the 30° angle (PI/6 radians) of those triangles
    //to figure up the lengths of the triangle's sides (thank you again, Pythagoras).
    ss = sin(PI/6)*side; //length of short side of triangle
    ls = cos(PI/6)*side; //length of long side of triangle
    h = ls*2.0; //total height of hex
    w = ss*2.0 + side; //total width of hex
    halfH = ls; //half of the hex's height (for drawing each hex from its center)
    halfW = w/2.0; //half of the hex's width (for drawing each hex from its center)
    halfSide = side/2.0; //half of one side (for drawing each hex from its center)
    offset = side * scaling1; // maximum perlin offset
    offsetBal = offset/2.0; // offest balance - to keep the hex nicely centered
  }
}
 
class hexagon {
  PVector pos, sPos; 
  float noiseScale, counter;
  hexDef hd;
  hexagon(float x, float y, float borderX1, float borderY1, float noiseScale1, float counter1, hexDef hd1) {
    //I use PVectors to hold the real coordinates and screen coordinates of the hex,  but I never got
    //around to actually using them as vectors.
    //println("x:"+x+" y:"+y);
    pos = new PVector(x, y);
    sPos = new PVector(pos.x*(hd1.side + hd1.ss) + hd1.ss + hd1.halfSide + borderX1, pos.y*(hd1.ls) + borderY1);
    noiseScale=noiseScale1;
    counter = counter1;
    hd=hd1;
  }
   
  void show(float counter1) {
    float c = noise(pos.x*noiseScale, (pos.y+counter1)*noiseScale); //get this hex's perlin noise value
    fill(c*255); //c is always somewhere between 0 and 1, so we just multiply it by 255 for the grayscale
    pushMatrix();
      translate(sPos.x, sPos.y - c*hd.offset + hd.offsetBal); //translate to the hex's center
      beginShape();
      vertex(-hd.halfW, 0); //center left
      vertex(-hd.halfSide, -hd.halfH); //upper left
      vertex(hd.halfSide, -hd.halfH); //upper right
      vertex(hd.halfW, 0); //center right
      vertex(hd.halfSide, hd.halfH); //lower right
      vertex(-hd.halfSide, hd.halfH); //lower left
      endShape(CLOSE);
      fill(0);
    popMatrix();
  }
   
}
