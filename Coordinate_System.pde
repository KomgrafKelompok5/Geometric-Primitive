final int GRID_SIZE = 20;

void createGrid() {
  stroke(0, 128, 192);
  fill(0);
  for(int y = -height / 2, index = height / (GRID_SIZE * 2);
          y <= height / 2; y += GRID_SIZE){
      float weight = y == 0 ? 1.2 : 0.5;
      strokeWeight(weight);
      text(index--, -GRID_SIZE, y + GRID_SIZE);
      line(-width / 2, y, width / 2, y);
  }
  for(int x = -width / 2, index = width / (GRID_SIZE * 2);
          x <= width / 2; x += GRID_SIZE){
      float weight = x == 0 ? 1.2 : 0.5;
      strokeWeight(weight);
      text(index--, x -GRID_SIZE, GRID_SIZE);
      line(x, -height / 2, x, height / 2);
  }
}

void setup() {
  size(1200, 720);
  background(255);
  
}

void draw(){
  translate(width/ 2, height/ 2);
  createGrid();
  scale(1, -1);
  rect(0, 0, 3 * GRID_SIZE, 3 * GRID_SIZE);
  
}