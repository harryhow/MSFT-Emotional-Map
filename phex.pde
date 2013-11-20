import processing.data.XML;
import geomerative.*;

int ARRAY_SIZE = 3; // numbers of file
hexGroup hg1;
hexGroup hg2;
hexGroup hg3;
hexGroup hg4;

RPoint[] points1;
RPoint[] points2;
RPoint[] points3;
RPoint[] points4;
RShape[] s = new RShape[ARRAY_SIZE];;
RShape polyshp;

String filename = "";
boolean isMousePressed = false;
PShape img;

void setupMap()
{
  RG.init(this);
  RG.ignoreStyles(true);
  
  for (int i = 0; i < s.length; i++){
      filename = "data/zipcode"+i+".svg";
      s[i] = RG.loadShape(filename);
      //backgroundimg[i] = loadShape(filename);   
   }
   
   points1 = s[0].getPoints();
   points2 = s[1].getPoints();
   points3 = s[2].getPoints();
   
   
//    for(int i=0; i<points1.length; i++){
//      println("(" +"["+i+"]"+points1[i].x + ", " + points1[i].y +")");
//    }
//    for(int i=0; i<points2.length; i++){
//      println("(" +"["+i+"]"+points2[i].x + ", " + points2[i].y +")");
//    }
//    for(int i=0; i<points3.length; i++){
//      println("(" +"["+i+"]"+points3[i].x + ", " + points3[i].y +")");
//    }
}

void setup() {
  size(800,600);
  smooth();
  noStroke();
  RG.init(this);
  hg1=new hexGroup(0.5,0,0);
  hg2=new hexGroup(0.1,15,0);
  hg3=new hexGroup(0.2,0,15);
  hg4=new hexGroup(0.3,15,15);
  
  setupMap();
  img = loadShape("data/home.svg");
}
 
void draw() {
  //main draw loop
  background(0);
  if (isMousePressed == false){
    background(11, 2, 41);
    shape(img, 0, 0, 800, 600);
  }
  else {
    hg1.updateCount();
    hg2.updateCount();
    hg3.updateCount();
    hg4.updateCount();
    hg1.show();
    hg2.show();
    hg3.show();
    hg4.show();
    isMousePressed = true;
  }
  
//  
//
//   s[0].draw();
//   translate(230, 0);
//   s[1].draw();
//   translate(230, 0);
//   s[2].draw();
//   
    
}

void mousePressed () {
  isMousePressed = true;
  println("question was pressed");
}


