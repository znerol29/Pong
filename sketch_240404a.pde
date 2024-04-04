int ballX = 300;
int ballY = 200;
int ballWidth = 20;
int ballHeight = 20;
int ballSpeedX = 5;
int ballSpeedY = 5;

int paddleWidth = 10;
int paddleHeight = 80;
int paddleSpeed = 5;

int leftPaddleY;
int rightPaddleY;

int leftScore = 0;
int rightScore = 0;

boolean wPressed = false;
boolean sPressed = false;
boolean upPressed = false;
boolean downPressed = false;

void setup() {
  size(600, 400);
  leftPaddleY = height / 2 - paddleHeight / 2;
  rightPaddleY = height / 2 - paddleHeight / 2;
}

void draw() {
  background(255);
  
  // draw paddles
  fill(0);
  rect(0, leftPaddleY, paddleWidth, paddleHeight);
  rect(width - paddleWidth, rightPaddleY, paddleWidth, paddleHeight);
  
  // draw ball
  rect(ballX, ballY, ballWidth, ballHeight);
  
  // move ball
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  
  // check collision with paddles
  if (ballX <= paddleWidth && ballY >= leftPaddleY && ballY <= leftPaddleY + paddleHeight) {
    ballSpeedX *= -1;
  }
  if (ballX >= width - paddleWidth && ballY >= rightPaddleY && ballY <= rightPaddleY + paddleHeight) {
    ballSpeedX *= -1;
  }
  
  // check collision with top and bottom walls
  if (ballY <= 0 || ballY >= height - ballHeight) {
    ballSpeedY *= -1;
  }
  
  // check if ball went past paddles
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
  text(leftScore + " : " + rightScore, width / 2, 50);
  
  // move paddles with keys
  if (wPressed) {
    leftPaddleY -= paddleSpeed;
  }
  if (sPressed) {
    leftPaddleY += paddleSpeed;
  }
  if (upPressed) {
    rightPaddleY -= paddleSpeed;
  }
  if (downPressed) {
    rightPaddleY += paddleSpeed;
  }
  
  // ensure paddles stay within bounds
  leftPaddleY = constrain(leftPaddleY, 0, height - paddleHeight);
  rightPaddleY = constrain(rightPaddleY, 0, height - paddleHeight);
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
  ballX = width / 2 - ballWidth / 2;
  ballY = height / 2 - ballHeight / 2;
  ballSpeedX *= random(1) > 0.5 ? 1 : -1; // randomize initial direction
  ballSpeedY *= random(-5, 5); // randomize initial vertical speed
}
