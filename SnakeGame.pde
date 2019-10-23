Snake snake;
final int gridWidth=40, gridHeight=20, cellSize=20;

private int foodX,foodY;
int score=0;
long draw=0;

void setup() {
  size(800, 400);
  //frameRate(1);
  background(255);
  snake = new Snake(cellSize);
  generateFood();
}

void keyPressed() {
  println("Pressed");
  switch(keyCode) {
  case UP:
    snake.changeDir(Snake.UP);
    break;
  case DOWN:
    snake.changeDir(Snake.DOWN);
    break;
  case LEFT:
    snake.changeDir(Snake.LEFT);
    break;
  case RIGHT:
    snake.changeDir(Snake.RIGHT);
    break;
  }
}

private void generateFood() {
  foodX = int(random(gridWidth));
  foodY = int(random(gridHeight));
}

void draw() {
  background(255);
  fill(0,255,30);
  strokeWeight(0);
  square(foodX*cellSize,foodY*cellSize,cellSize);
  snake.draw();
  if(snake.x < 0 || snake.x > gridWidth || snake.y < 0 || snake.y > gridHeight || !snake.isAlive()) {
    snake.kill();
    textSize(36);
    fill(255,0,30);
    text("Game Over",300,200);
    text("Score : "+score,320,250);
  } else if (snake.x == foodX && snake.y == foodY) {
    snake.addPart();
    score += 15;
    generateFood();
  }
}
