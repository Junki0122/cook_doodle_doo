import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;

String [] path = {"BrownDye.png", "Pig.png", "Potato.png", "Carrot.png", "Sugaricon.png", "Pumpkin.png", "Egg.png", "Wheat.png", "Wheat.png"};
float [] posX = new float [path.length];
float [] posY = new float [path.length];

void setup() {
  size(960, 600, P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  String[] cams = Capture.list();
  cam = new Capture(this, width, height, cams[0]);
  //cam = new Capture(this, width, height);
  nya=new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  for (int i=0; i<16; i++) {
    nya.addNyIdMarker(i, 80);
  }
  cam.start();
}

void draw() {
  if (cam.available() !=true) {
    return;
  }

  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);
  stroke(0);
  noFill();
  rect(50, 30, 80, 80);
  rect(130, 30, 80, 80);
  rect(210, 30, 80, 80);
  rect(50, 110, 80, 80);
  rect(130, 110, 80, 80);
  rect(210, 110, 80, 80);
  rect(50, 190, 80, 80);
  rect(130, 190, 80, 80);
  rect(210, 190, 80, 80);

  for (int i=0; i<path.length; i++) {
    if ( nya.isExist(i) ) {
      PVector [] pos = nya.getMarkerVertex2D(i);
      posX[i] = (pos[0].x + pos[2].x) /2;
      posY[i] = (pos[0].y + pos[2].y) /2;
      nya.beginTransform(i);
      PImage img = loadImage(path[i]);
      noStroke();
      beginShape();
      texture(img);
      vertex(-50, -50, 0, 120, 120);
      vertex(50, -50, 0, 0, 120);
      vertex(50, 50, 0, 0, 0);
      vertex(-50, 50, 0, 120, 0);
      endShape();
      println(nya.getNyId(i));
      nya.endTransform();
    }
  }
  create();
}


//レシピ判定機
void create() {
  //パンプキンパイ
  if (posX[5] >= 50 && posX[5] <= 130 && posY[5] >= 110 && posY[5] <= 190) {
    if (posX[4] >= 130 && posX[4] <= 210 && posY[4] >= 110 && posY[4] <= 190) {
      if (posX[6] >= 210 && posX[6] <= 290 && posY[6] >= 110 && posY[6] <= 190) {
        //パンプキンパイ表示
        PImage img = loadImage("Pumpkin_Pie.png");
        noStroke();
        translate(-160, 200, 0);
        beginShape();
        texture(img);
        vertex(280, 110, 0, 0, 0);
        vertex(380, 110, 0, 150, 0);
        vertex(380, 210, 0, 150, 150);
        vertex(280, 210, 0, 0, 150);
        endShape();
      }
    }
  }

  //クッキー
  if (posX[7] >= 50 && posX[7] <= 130 && posY[7] >= 110 && posY[7] <= 190) {
    if (posX[0] >= 130 && posX[0] <= 210 && posY[0] >= 110 && posY[0] <= 190) {
      if (posX[8] >= 210 && posX[8] <= 290 && posY[8] >= 110 && posY[8] <= 190) {
        //クッキー表示
        PImage img = loadImage("Cookie.png");
        noStroke();
        translate(-160, 200, 0);
        beginShape();
        texture(img);
        vertex(280, 110, 0, 0, 0);
        vertex(380, 110, 0, 150, 0);
        vertex(380, 210, 0, 150, 150);
        vertex(280, 210, 0, 0, 150);
        endShape();
      }
    }
  }
}