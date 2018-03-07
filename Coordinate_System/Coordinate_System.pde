int gridSize = 10;
int zoomFactor = 1;

class Point {
  float x, y;
  Point(float x, float y) {
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
  strokeWeight(1.2);
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

ArrayList<Point> points = new ArrayList();
void mouseClicked() {
  points.add(new Point( (mouseX - width / 2) / zoomFactor, -(mouseY - height / 2) / zoomFactor));
}

void drawPoint() {
  for (Point point : points) {
    float radius = clamp(gridSize / 12, 0.75, 5);
    fill(255, 0, 0);
    noStroke();
    ellipse(point.x * zoomFactor, point.y * zoomFactor, radius, radius);
    printLabel(point.x, point.y);
  }
}

void printLabel(float x, float y) {
  textSize(gridSize / 3);
  pushMatrix();
  fill(0, 128, 192);
  scale(1, -1);
  text("(" +nfc((zoomFactor * x / gridSize), 2) +", " +nfc((zoomFactor * y / gridSize), 2) +")", x * zoomFactor, -y * zoomFactor);
  popMatrix();
}

void drawPolygon(ArrayList<Point> _points) {
  if (!_points.isEmpty()) {
    pushMatrix();
    stroke(255, 0, 0);
    strokeWeight(1.2);
    for (int i = 0; i < _points.size() - 1; i++) {
      Point p1 = _points.get(i);
      Point p2 = _points.get(i + 1);
      line(p1.x * zoomFactor, p1.y * zoomFactor, p2.x * zoomFactor, p2.y * zoomFactor);
    }

    Point start = _points.get(0);
    Point end = _points.get(_points.size() - 1);
    line(start.x * zoomFactor, start.y * zoomFactor, end.x * zoomFactor, end.y * zoomFactor);
    popMatrix();
  }
}

//Methode experimental, Jangan di pikir berat!
int orientation(Point p, Point q, Point r) {
  float val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);

  if (val == 0) return 0;
  return (val > 0)? 1: 2;
}

//Methode experimental, Jangan di pikir berat!
ArrayList<Point> convexHull(ArrayList<Point> _points) {
  if (_points.size() < 3) return _points;
  ArrayList<Point> hull = new ArrayList();

  int l = 0;
  for (int i = 1; i < _points.size(); i++)
    if (_points.get(i).x < _points.get(l).x)
      l = i;

  int p = l, q;
  do {
    hull.add(_points.get(p));
    q = (p + 1) % _points.size();

    for (int i = 0; i < _points.size(); i++) {
      if (orientation(_points.get(p), _points.get(i), _points.get(q))== 2)
        q = i;
    } 
    p = q;
  } while (p != l); 
  return hull;
}

void setup() {
  size(1200, 720);
}

void draw() {
  background(255);
  translate(width/ 2, height/ 2);
  createGrid();
  scale(1, -1);
  /* y = 2x + 4
   * m = 2, c = 4
   */
  createLine(2, 4);
  drawPoint();
  drawPolygon(convexHull(points));
  
}
