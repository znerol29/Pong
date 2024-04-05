int mode = 0;
//0 = Homescreen
//1 = 2 Spieler
//2 = 1 Spieler
//3 = 1 Spieler unmöglich
//4 = Wandmodus

float difficulty = 0.4; // Min 0.3!
int hitCount = 0;
float incPerHit = 0.1;

int demHeight;
boolean m3Sel = false;

int ballX;
int ballY;
int ballDim = 20;
float ballSpeedX = 4;
float ballSpeedY = 0;

int racketWidth = 10;
int racketHeight = 80;
float racketSpeed = 5;

int racketLY;
int racketRY;

int leftScore = 0;
int rightScore = 0;

boolean wPressed = false;
boolean sPressed = false;
boolean upPressed = false;
boolean downPressed = false;

boolean noCollision = false;
int YCap = 0;

void setup() {
  size(600, 400);
  demHeight = height / 10;
  racketLY = racketRY = height / 2 - racketHeight / 2;
  ballX = width / 2 - ballDim / 2;
  ballY = height / 2 - ballDim / 2;
}

void draw() {
  textFont(createFont("Arial", 32));
  background(0);
  
  if (mode == 0){
    fill(255);
    rect(0.1 * width, 0.1 * height, 0.8 * width, 0.2 * height);
    rect(0.1 * width, 0.3 * height, 0.8 * width, 0.2 * height);
    rect(0.1 * width, 0.5 * height, 0.8 * width, 0.2 * height);
    rect(0.1 * width, 0.7 * height, 0.8 * width, 0.2 * height);
    
    textFont(createFont("Arial Bold", 32));
    textSize(32);
    textAlign(CENTER, CENTER);
    fill(0);
    
    text("Spieler vs Spieler", width / 2, 0.2 * height);
    text("Spieler vs Computer", width / 2, 0.4 * height);
    
    textFont(createFont("Arial", 18));
    textSize(18);
    text("Computer-Schwierigkeit", width / 2, 0.5375 * height);
    
    textFont(createFont("Arial Bold", 32));
    textSize(32);
    text("Spieler vs Wand", width / 2, 0.8 * height);

    
    fill(0);
    if (difficulty == 0.4){fill(125);}
    rect(width / 2 - demHeight * 4.7, 0.575 * height, demHeight, demHeight);
    fill(0);
    if (difficulty == 0.5){fill(125);}
    rect(width / 2 - demHeight * 3.5, 0.575 * height, demHeight, demHeight);
    fill(0);
    if (difficulty == 0.6){fill(125);}
    rect(width / 2 - demHeight * 2.3, 0.575 * height, demHeight, demHeight);
    fill(0);
    if (difficulty == 0.7){fill(125);}
    rect(width / 2 - demHeight * 1.1, 0.575 * height, demHeight, demHeight);
    fill(0);
    if (difficulty == 0.8){fill(125);}
    rect(width / 2 + demHeight * 0.1, 0.575 * height, demHeight, demHeight);
    fill(0);
    if (difficulty == 0.9){fill(125);}
    rect(width / 2 + demHeight * 1.3, 0.575 * height, demHeight, demHeight);
    fill(0);
    if (difficulty == 1){fill(125);}
    rect(width / 2 + demHeight * 2.5, 0.575 * height, demHeight, demHeight);
    fill(0);
    if (m3Sel == true){fill(125);}
    rect(width / 2 + demHeight * 3.7, 0.575 * height, demHeight, demHeight);
    
    fill(255);
    text("1", width / 2 - demHeight * 4.2, 0.625 * height);
    text("2", width / 2 - demHeight * 3, 0.625 * height);
    text("3", width / 2 - demHeight * 1.8, 0.625 * height);
    text("4", width / 2 - demHeight * 0.6, 0.625 * height);
    text("5", width / 2 + demHeight * 0.6, 0.625 * height);
    text("6", width / 2 + demHeight * 1.8, 0.625 * height);
    text("7", width / 2 + demHeight * 3, 0.625 * height);
    text("∞", width / 2 + demHeight * 4.2, 0.625 * height);
  }
  
  
  if (mode >= 1){
    // Home-Button
    fill(255);
    rect(5, height - 30, 25, 25);
    fill(0);
    textSize(15);
    text("←", 17.5, height - 18.5);
    
    // Mittellinie zeichnen
    stroke(125);
    strokeWeight(3);
    line(width / 2, 0, width / 2, height);
    strokeWeight(0);
    stroke(0);
    
    // Punkteanzeige
    fill(255);
    textSize(32);
    textAlign(CENTER, CENTER);
    if (mode == 4) {text(hitCount, 25, 25);
    } else {text(leftScore + "    " + rightScore, width / 2, 50);}
    
    // Schläger zeichnen
    fill(255);
    rect(0, racketLY, racketWidth, racketHeight);
    if (mode == 4) {
      rect(width - racketWidth, 0, racketWidth, height);
    } else {rect(width - racketWidth, racketRY, racketWidth, racketHeight);}
      
    // Ball Zeichnen
    rect(ballX, ballY, ballDim, ballDim);
    
    // Ballbewegung
    ballX += int(ballSpeedX);
    ballY += int(ballSpeedY);
    
    // Kolission mit Schlägern
    if (noCollision == false && ballX <= racketWidth && ballY > racketLY - ballDim && ballY < racketLY + racketHeight + ballDim) {
      if (abs(ballSpeedX) < 11){
        ballSpeedX = abs(ballSpeedX) + incPerHit;
        racketSpeed += 0.25;
      } else {ballSpeedX *= -1;}
      
      // Schräges abprallen im oberen & unteren drittel
      if (ballY + ballDim / 2 < racketLY + racketHeight / 3)  {
        ballSpeedY -= 1.5;
      }
      if (ballY + ballDim / 2 > racketLY + racketHeight / 3 * 2) {
        ballSpeedY += 1.5;
      }
      
      noCollision = true; // Verhindern das die richtung mehrfach geändert wird
      hitCount += 1;
      
      if (ballSpeedY <= 0.2){YCap += 1;} // Wiederholtes waagerechtes hin-und-her-spielen verhindern
      if (YCap >= 3) {
        ballSpeedY += 3;
        YCap = 0;
      }
    }
    
    if (noCollision == false && ballX >= width - racketWidth - ballDim && ballY > racketRY - ballDim && ballY < racketRY + racketHeight + ballDim) {
      if (abs(ballSpeedX) < 11){
        ballSpeedX = -1 * (abs(ballSpeedX) + incPerHit);
        racketSpeed += 0.25;
      } else {ballSpeedX *= -1;}
      
      if (ballY + ballDim / 2 < racketRY + racketHeight / 3)  {
        ballSpeedY -= 1.5;
      }
      if (ballY + ballDim / 2 > racketRY + racketHeight / 3 * 2) {
        ballSpeedY += 1.5;
      }
      
      noCollision = true;
      
      if (ballSpeedY <= 0.2){YCap += 1;}
      if (YCap >= 3) {
        ballSpeedY -= 3;
        YCap = 0;
      }
    }
    
    // Mode 4
    if (noCollision == false && mode == 4 && ballX >= width - racketWidth - ballDim) {
      if (abs(ballSpeedX) < 11){
        ballSpeedX = -1 * (abs(ballSpeedX) + incPerHit);
        racketSpeed += 0.25;
      } else {ballSpeedX *= -1;}
      noCollision = true;
      if (ballSpeedY <= 0.2){YCap += 1;}
    }
    
    // Kollisionen wieder erlauben sobald der Ball aus der Nähe des Schlägers ist
    if (ballX >= 2 * racketWidth && ballX <= width - 2 * racketWidth - ballDim) {
      noCollision = false;
    }
    
    // Kollision obere & untere Wand
    if (ballY <= 0 || ballY >= height - ballDim) {
      ballSpeedY *= -1;
    }
    
    // Tore zählen
    if (ballX < 0) {
      rightScore++;
      resetBall();
    }
    if (ballX > width) {
      leftScore++;
      resetBall();
    }
    
    // 1 Spieler
    if (mode == 2){
      if (racketRY + racketHeight / 2 < ballY + ballDim / 2) {
        racketRY += difficulty * racketSpeed;
      } else if (racketRY + racketHeight / 2 > ballY + ballDim / 2) {
        racketRY -= difficulty * racketSpeed;
      }
    }
    
    // Unmöglich
    if (mode == 3){
      racketRY = ballY + ballDim / 2 - racketHeight / 2;
    }
    
    // Tastenaktionen
    if (wPressed) {
      racketLY -= racketSpeed;
    }
    if (sPressed) {
      racketLY += racketSpeed;
    }
    
    if (mode == 1){
      if (upPressed) {
        racketRY -= racketSpeed;
      }
      if (downPressed) {
        racketRY += racketSpeed;
      }
    }
    
    // Beschränkung der Schlägerbewegung
    racketLY = constrain(racketLY, 0, height - racketHeight);
    racketRY = constrain(racketRY, 0, height - racketHeight);
  }
}

void mousePressed(){
  if (mode == 0) {
    if (mouseX > 0.1 * width && mouseX < 0.9 * width){
      if (mouseY > 0.1 * height && mouseY < 0.3 * height){mode = 1;}
      if (mouseY > 0.3 * height && mouseY < 0.5 * height){
        if (m3Sel == true){mode = 3;
        } else {mode = 2;}
      }
      if (mouseY > 0.7 * height && mouseY < 0.9 * height){
        mode = 4;
        ballSpeedX *= -1;
        ballSpeedY = random(-3, 3);
      }
    }
    
    if (mouseY > 0.575 * height && mouseY < 0.675 * height){
      if (mouseX > width / 2 - demHeight * 4.7 && mouseX < width / 2 - demHeight * 3.7){m3Sel = false; difficulty = 0.4;}
      if (mouseX > width / 2 - demHeight * 3.5 && mouseX < width / 2 - demHeight * 2.5){m3Sel = false; difficulty = 0.5;}
      if (mouseX > width / 2 - demHeight * 2.3 && mouseX < width / 2 - demHeight * 1.3){m3Sel = false; difficulty = 0.6;}
      if (mouseX > width / 2 - demHeight * 1.1 && mouseX < width / 2 - demHeight * 0.1){m3Sel = false; difficulty = 0.7;}
      if (mouseX > width / 2 + demHeight * 0.1 && mouseX < width / 2 + demHeight * 1.1){m3Sel = false; difficulty = 0.8;}
      if (mouseX > width / 2 + demHeight * 1.3 && mouseX < width / 2 + demHeight * 2.3){m3Sel = false; difficulty = 0.9;}
      if (mouseX > width / 2 + demHeight * 2.5 && mouseX < width / 2 + demHeight * 3.5){m3Sel = false; difficulty = 1;}
      if (mouseX > width / 2 + demHeight * 3.7 && mouseX < width / 2 + demHeight * 4.7){m3Sel = true; difficulty = 0;}
    }
  }
  
  if (mode >= 1){
    if (mouseX > 5 && mouseX < 30 && mouseY > height - 30 && mouseY < height - 5){goHome();}
  }
}

//Tastenerfassung
void keyPressed() {
  if (key == 'w') {
    wPressed = true;
  }
  if (key == 's') {
    sPressed = true;
  }
  if (keyCode == UP) {
    upPressed = true;
  }
  if (keyCode == DOWN) {
    downPressed = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    wPressed = false;
  }
  if (key == 's') {
    sPressed = false;
  }
  if (keyCode == UP) {
    upPressed = false;
  }
  if (keyCode == DOWN) {
    downPressed = false;
  }
}

// Ball zurücksetzen
void resetBall() {
  racketLY = racketRY = height / 2 - racketHeight / 2;
  ballX = width / 2 - ballDim / 2;
  ballY = height / 2 - ballDim / 2;
  ballSpeedX = 4;
  ballSpeedY = 0;
  racketSpeed = 5;
  hitCount = 0;
  if (mode == 4){
    ballSpeedX *= -1;
    ballSpeedY = random(-3, 3);
  }
}

void goHome() {
  mode = 0;
  difficulty = 0.4;
  ballSpeedX = 4;
  ballSpeedY = 0;
  racketSpeed = 5;
  hitCount = 0;
  racketLY = racketRY = height / 2 - racketHeight / 2;
  ballX = width / 2 - ballDim / 2;
  ballY = height / 2 - ballDim / 2;
}
