int ballX;
int ballY;
int ballDim = 20;
float ballSpeedX = 4;
float ballSpeedY = 4;

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
  
  // move ball
  ballX += int(ballSpeedX);
  ballY += int(ballSpeedY);
  
  // check collision with rackets
  if (noCollision == false && ballX <= racketWidth && ballY > racketLY - ballDim && ballY < racketLY + racketHeight + ballDim) {
    ballSpeedX *= -1;
    noCollision = true;
  }
  if (noCollision == false && ballX >= width - racketWidth - ballDim && ballY > racketRY - ballDim && ballY < racketRY + racketHeight + ballDim) {
    ballSpeedX *= -1;
    noCollision = true;
  }
  
  if (ballX >= 2 * racketWidth && ballX <= width - 2 * racketWidth - ballDim) {
    noCollision = false;
  }
  
  // check collision with top and bottom walls
  if (ballY <= 0 || ballY >= height - ballDim) {
    ballSpeedY *= -1;
  }
  
  // check if ball went past rackets
  if (ballX < 0) {
    rightScore++;
    resetBall();
  }
  if (ballX > width) {
    leftScore++;
    resetBall();
  }
  
  // display scores
  textSize(32);
  textAlign(CENTER, CENTER);
  text(leftScore + "    " + rightScore, width / 2, 50);
  
  // NPC
  
  while(racketRY != ballY + ballDim / 2 - racketHeight / 2){
    if (racketRY + racketHeight / 2 < ballY + ballDim / 2) {
      racketRY += racketSpeed;
    } else if (racketRY + racketHeight / 2 > ballY + ballDim / 2) {
      racketRY -= racketSpeed;
    }
  }
  
  
  //racketRY = ballY + ballDim / 2 - racketHeight / 2;
  
  // move rackets with keys
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
  
  // ensure rackets stay within bounds
  racketLY = constrain(racketLY, 0, height - racketHeight);
  racketRY = constrain(racketRY, 0, height - racketHeight);
}

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

void resetBall() {
  ballX = width / 2 - ballDim / 2;
  ballY = height / 2 - ballDim / 2;
  if (abs(ballSpeedX) * 1.05 <= 9){
    ballSpeedX *= 1.05;
    ballSpeedY *= 1.05;
    racketSpeed *= 1.05;
  }
}
