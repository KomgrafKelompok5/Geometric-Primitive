int gridSize = 10;
int zoomFactor = 1;

class Coordinate {
  float x, y;
  Coordinate(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

void createGrid() {
  //Text Config
  fill(0, 128, 192);
  float textOffSide = gridSize / 8;
  textAlign(RIGHT, TOP);
  textSize(gridSize / 3);
  //Line Config
  stroke(0, 128, 192);
  //Draw Coordinate System
  for (int y = -height / 2, index = height / (gridSize * 2); 
    y <= height / 2; y += gridSize) {
    strokeWeight(y == 0 ? 1.2 : 0.3);
    text(index--, -textOffSide, y + textOffSide);
    ellipseMode(RADIUS);
    ellipse(0, y, gridSize / 15, gridSize / 15);
    line(-width / 2, y, width / 2, y);
  }
  for (int x = -width / 2, index = -width / (gridSize * 2); 
    x <= width / 2; x += gridSize) {
    strokeWeight(x == 0 ? 1.2 : 0.3);
    text(index++, x - textOffSide, textOffSide);
    ellipseMode(RADIUS);
    ellipse(x, 0, gridSize / 15, gridSize / 15);
    line(x, -height / 2, x, height / 2);
  }
}

float lineEq(float m, float x, float c) {
  return m * x + (c * gridSize);
}

void createLine(float m, float c) {
  stroke(255, 0, 0);
  float x = width / 2;
  line(-x, lineEq(m, -x, c), x, lineEq(m, x, c));
}

//Zoom Coordinate System
float clamp(float val, float min, float max) {
  return val < min ? min : val > max ? max : val;
}

void mouseWheel(MouseEvent event) {
  zoomFactor = (int)clamp(zoomFactor - event.getCount(), 1, 4);
  gridSize = 10 * zoomFactor;
}

ArrayList<Coordinate> list = new ArrayList();
void mouseClicked() {
  list.add(new Coordinate( (mouseX - width / 2) / zoomFactor, -(mouseY - height / 2) / zoomFactor));
  if (begin!=-1) {
    loc+= "("+float ((mouseX - width / 2) / zoomFactor)/10+", "+ -float((mouseY - height / 2) / zoomFactor)/10+") ";
    label4.setText(loc);
  }
}

void drawPoint() {
  for (Coordinate i : list) {
    float radius = clamp(gridSize / 12, 0.75, 8);
    fill(255, 0, 0);
    noStroke();
    ellipse(i.x * zoomFactor, i.y * zoomFactor, radius, radius);
    printLabel(i.x, i.y);
  }
}
void printLabel(float x, float y) {
  textSize(gridSize / 3);
  pushMatrix();
  fill(0, 128, 192);
  scale(1, -1);
  text("(" +(4 * x / gridSize) +", " +(4 * y / gridSize) +")", x * zoomFactor, -y * zoomFactor);
  popMatrix();
}

//============NEW=========

//creatline
class Line {
  float x, y;
  Line(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
ArrayList<Line> linelist = new ArrayList();
void listLine() {
  for (Line i : linelist) {
    createLine(i.x, i.y);
  }
}

//create shape
int begin=-1, end=-1;
String loc="";
void shap() {
  noFill();
  stroke(0, 255, 255);
  beginShape(TRIANGLE_FAN);
  for (int i=begin; i<=end; i++) {
    vertex(list.get(i).x* zoomFactor, list.get(i).y* zoomFactor);
  }
  endShape(CLOSE);
}
//show Coordinate
void mouseMoved() {
  label3.setText(float ((mouseX - width / 2) / zoomFactor)/10+", "+ -float((mouseY - height / 2) / zoomFactor)/10);
}