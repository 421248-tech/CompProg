// Connor DeWeerd | Sept 15 2026 | Calculator
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
float l = 0;          // Left operand
float r = 0;          // Right operand
float result = 0;     // Result value
boolean left = true;  // Is the user typing the left operand?
char op = ' ';        // Active operator
String displayVal = "0";

void setup() {
  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = ' ';

  size(300, 480);
  opButtons[0] = new Button(50, 80, 40, 40, '('); // opButton
  opButtons[1] = new Button(110, 80, 40, 40, ')'); // opButton
  opButtons[2] = new Button(50, 140, 40, 40, '.'); // opButton
  opButtons[3] = new Button(110, 140, 40, 40, '%'); // opButton
  opButtons[4] = new Button(170, 140, 40, 40, '±'); // opButton
  opButtons[5] = new Button(230, 140, 40, 40, '√'); // opButton
  numButtons[0] = new Button(50, 200, 40, 40, '7'); // numButton
  numButtons[1] = new Button(110, 200, 40, 40, '8'); // numButton
  numButtons[2] = new Button(170, 200, 40, 40, '9'); // numButton
  opButtons[6] = new Button(230, 200, 40, 40, '+'); // opButton
  numButtons[3] = new Button(50, 260, 40, 40, '4'); // numButton
  numButtons[4] = new Button(110, 260, 40, 40, '5'); // numButton
  numButtons[5] = new Button(170, 260, 40, 40, '6'); // numButton
  opButtons[7] = new Button(230, 260, 40, 40, '-'); // opButton
  numButtons[6] = new Button(50, 320, 40, 40, '1'); // numButton
  numButtons[7] = new Button(110, 320, 40, 40, '2'); // numButton
  numButtons[8] = new Button(170, 320, 40, 40, '3'); // numButton
  opButtons[8] = new Button(230, 320, 40, 40, '*'); // opButton
  numButtons[9] = new Button(50, 380, 40, 40, '0'); // numButton
  opButtons[9] = new Button(110, 380, 40, 40, 'C'); // opButton
  opButtons[10] = new Button(170, 380, 40, 40, '='); // opButton
  opButtons[11] = new Button(230, 380, 40, 40, '/'); // opButton
}

void draw() {
  background(33);

  for (int i = 0; i < numButtons.length; i++) {
    numButtons[i].hover(mouseX, mouseY);
    numButtons[i].display();
  }
  for (int i = 0; i < opButtons.length; i++) {
    opButtons[i].hover(mouseX, mouseY);
    opButtons[i].display();
  }

  fill(10);
  rectMode(CORNER);
  fill(127);
  rect(20, 15, 260, 35, 5);
  fill(255);
  textAlign(RIGHT);
  textSize(20);
  text(displayVal, 270, 30);
}

void mousePressed() {

  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover) {
      handleNumberInput(numButtons[i].val);
    }
  }

  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover) {
      handleOperatorInput(opButtons[i].val);
    }
  }

  // Print current calculator state to the console pane below
  println("l: " + l + " r: " + r + " result: " + result + " left: " + left + " op: " + op + " display: " + displayVal);
}

void keyPressed() {
  // Number Keys 0-9
  if (key >= '0' && key <= '9') {
    handleNumberInput(key);
  } 
  // Operator Keys
  else if (key == '+' || key == '-' || key == '*' || key == '/' || key == '.' || key == '%' || key == '(' || key == ')') {
    handleOperatorInput(key);
  } 
  // Clear Keys (C, c, or Backspace)
  else if (key == 'c' || key == 'C' || key == BACKSPACE) {
    handleOperatorInput('C');
  } 
  // Equals Keys (= or Enter/Return)
  else if (key == '=' || key == ENTER || key == RETURN) {
    handleOperatorInput('=');
  } 
  // Square Root Key ('s' or 'S')
  else if (key == 's' || key == 'S') {
    handleOperatorInput('√');
  } 
  // Toggle Negative/Positive Key ('n' or 'N')
  else if (key == 'n' || key == 'N') {
    handleOperatorInput('±');
  }

  // Print current calculator state to console pane when typing
  println("l: " + l + " r: " + r + " result: " + result + " left: " + left + " op: " + op + " display: " + displayVal);
}

// Helper method for handling number inputs
void handleNumberInput(char numChar) {
  if (displayVal.equals("0") || left) {
    displayVal = String.valueOf(numChar);
    left = false; // Reset flag so subsequent digits append
  } else {
    displayVal += numChar;
  }
}

// Helper method for handling operator inputs
void handleOperatorInput(char bVal) {
  // Clear (C)
  if (bVal == 'C') {
    l = 0.0;
    r = 0.0;
    result = 0.0;
    op = ' ';
    displayVal = "0";
    left = false;
  } 
  // Basic Math Operators (+, -, *, /)
  else if (bVal == '+' || bVal == '-' || bVal == '*' || bVal == '/') {
    l = float(displayVal);
    op = bVal;
    left = true; // Signals that the next number typed starts fresh
  } 
  // Equals (=)
  else if (bVal == '=') {
    performCalculation();
  } 
  // Decimal (.)
  else if (bVal == '.') {
    if (!displayVal.contains(".")) {
      displayVal += ".";
    }
  } 
  // Toggle Positive/Negative (±)
  else if (bVal == '±') {
    float temp = float(displayVal) * -1;
    displayVal = String.valueOf(temp);
  } 
  // Square Root (√)
  else if (bVal == '√') {
    float temp = sqrt(float(displayVal));
    displayVal = String.valueOf(temp);
    left = true;
  } 
  // Percentage (%)
  else if (bVal == '%') {
    float temp = float(displayVal) / 100.0;
    displayVal = String.valueOf(temp);
    left = true;
  }
}

void performCalculation() {
  r = float(displayVal);

  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '*') {
    result = l * r;
  } else if (op == '/') {
    if (r != 0) {
      result = l / r;
    } else {
      displayVal = "Error";
      return;
    }
  }

  displayVal = String.valueOf(result);
  left = true;
}
