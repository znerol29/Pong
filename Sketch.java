import processing.core.PApplet;

public class Sketch extends PApplet {

  public void settings() {
    size(400, 400);
  }

  public void setup() {
    background(152, 190, 100);
  }

  public void draw() {
    fill(255);
    ellipse(mouseX, mouseY, 25, 25);
  }
}