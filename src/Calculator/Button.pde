class Button {
  // Member Variables
  float x, y, w, h;
  char val;
  boolean hover;
  color c1, c2;

  // Constructor
  Button(float x, float y, float w, float h, char val) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.val = val;
    hover = false;
    c1 = color(65);
    c2 = color(155);
  }

  // Hover detection logic for rectMode(CENTER)
  void hover(float mx, float my) {
    if (mx > x - w/2 && mx < x + w/2 && my > y - h/2 && my < y + h/2) {
      hover = true;
    } else {
      hover = false;
    }
  }

  // Member Methods
  void display() {
    if (hover) {
      fill(c2);
    } else {
      fill(c1);
    }
    
    rectMode(CENTER);
    rect(x, y, w, h, 3);
    
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(val, x, y);
  }
  
  void mouseOver (float tempX, float tempY) {
    if(tempX>x-w/2 && tempX<x+w/2 && tempY > y-h/2 && tempY < y+h/2)  
      hover = true;
  }
  
}
