import g4p_controls.*;
void setup() {
  size(1200, 720);
  createGUI();
}
void draw() {
  background(255);
  translate(width/ 2, height/ 2);
  createGrid();
  scale(1, -1);
  /* y = 2x + 4
   * m = 2, c = 4
   */
  drawPoint();
  listLine();
   if(end!=-1)shap();
  //membuat garis dengan inputan 
  //createLine(int(textfield1.getText()), int(textfield2.getText()));
}
//kalo nullpointer coba run terus sampai bisa