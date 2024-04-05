int mode = 0;
//0 = Homescreen
//1 = 2 Spieler
//2 = 1 Spieler
//3 = 1 Spieler unmöglich
//4 = Wandmodus

float difficulty = 0.8;

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
  racketLY = racketRY = height / 2 - racketHeight / 2;
  ballX = width / 2;
  ballY = height / 2;
}

void draw() {
  background(0);
  
  // Schläger zeichnen
  fill(255);
  rect(0, racketLY, racketWidth, racketHeight);
  rect(width - racketWidth, racketRY, racketWidth, racketHeight);
  
  // Mittellinie zeichnen
  stroke(125);
  strokeWeight(3);
  line(width / 2, 0, width / 2, height);
  strokeWeight(0);
    
  // Ball Zeichnen
  rect(ballX, ballY, ballDim, ballDim);
  
  // Ballbewegung
  ballX += int(ballSpeedX);
  ballY += int(ballSpeedY);
  
  // Kolission mit Schlägern
  if (noCollision == false && ballX <= racketWidth && ballY > racketLY - ballDim && ballY < racketLY + racketHeight + ballDim) {
    if (abs(ballSpeedX) < 11){
      ballSpeedX = abs(ballSpeedX) + 0.25;
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
    
    if (ballSpeedY <= 0.2){YCap += 1;} // Wiederholtes waagerechtes hin-und-her-spielen verhindern
    if (YCap >= 3) {
      ballSpeedY += 3;
      YCap = 0;
    }
  }
  if (noCollision == false && ballX >= width - racketWidth - ballDim && ballY > racketRY - ballDim && ballY < racketRY + racketHeight + ballDim) {
    if (abs(ballSpeedX) < 11){
      ballSpeedX = -1 * (abs(ballSpeedX) + 0.25);
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
  
  textSize(20);
  textAlign(LEFT, TOP);
  text(YCap + ballSpeedY, 1, 1);
  
  // Punkteanzeige
  textSize(32);
  textAlign(CENTER, CENTER);
  text(leftScore + "    " + rightScore, width / 2, 50);
  
  // NPC
  
  //if (racketRY + racketHeight / 2 < ballY + ballDim / 2) {
  //  racketRY += difficulty * racketSpeed;
  //} else if (racketRY + racketHeight / 2 > ballY + ballDim / 2) {
  //  racketRY -= difficulty * racketSpeed;
  //}
  
  
  //racketRY = ballY + ballDim / 2 - racketHeight / 2;
  
  // Tastenaktionen
  if (wPressed) {
    racketLY -= racketSpeed;
  }
  if (sPressed) {
    racketLY += racketSpeed;
  }
  if (upPressed) {
    racketRY -= racketSpeed;
  }
  if (downPressed) {
    racketRY += racketSpeed;
  }
  
  // Beschränkung der Schlägerbewegung
  racketLY = constrain(racketLY, 0, height - racketHeight);
  racketRY = constrain(racketRY, 0, height - racketHeight);
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
  ballX = width / 2 - ballDim / 2;
  ballY = height / 2 - ballDim / 2;
  ballSpeedX = 4;
  ballSpeedY = 0;
  racketSpeed = 5;
}
