public class Tile {
  float pX, pY, size;
  float currentSize = 0;
  float r, g, b;
  String numberToDisplay;
  int numberAsInt;
  
  public Tile(float pX, float pY, float size) {
    this.pX = pX;
    this.pY = pY;
    
    r = 200;
    g = 200;
    b = 200;
    
    this.size = size;
    
    numberToDisplay = "0";
    numberAsInt = 0;
  }
  
  public void display(boolean show) {
    if (!show) {
      currentSize = 0;
      return;
    }
    
    currentSize += size/10;
    if (currentSize >= size) currentSize = size;
    
    rectMode(CENTER);
    float value = map(numberAsInt, 2, 2048, 200, 0) - (numberAsInt < 256 ? map(numberAsInt, 2, 4, 100, 90) : 25);
    r = 255 - value;
    g = value - 255;
    b = value;
    fill(r, g, b);
    rect(pX, pY, currentSize, currentSize);
    
    textSize(size/2.5);
    fill(255);
    textAlign(CENTER, CENTER);
    text(numberToDisplay, pX, pY-size/14, 1);
  }
  
  public float getSize() { return size; }
  
  public void setColor(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public void setNumber(int number) {
    numberToDisplay = "" + number;
    numberAsInt = number;
  }
}
