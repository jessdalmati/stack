int[][] blocks;
int[] blockSizes;
int moveSpeed = 3;
int currentBlock = 0;
Boolean gameOver = false;

void setup() { 
  size(600, 600);
  rectMode(CENTER);
  blocks = new int[12][2];
  for(int i = 0; i < blocks.length; i++) {
    blocks[i][0] = width/2;
    blocks[i][1] = height - 50*(i + 1) + 25;
  }
  blockSizes = new int[12];
  for(int i = 0; i < blockSizes.length; i++) {
    blockSizes[i] = 100;
  }
}

void draw() {
  background(0);
  fill(255, 0, 0);
  for(int i = 0; i <= currentBlock; i++) {
    rect(blocks[i][0], blocks[i][1], blockSizes[i], 50);
  }
  if(!gameOver) {
    move();
  }
}

void keyPressed() {
  if(!gameOver) {
    chop();
  }
  
  if(!gameOver) {
    currentBlock++;
  }
  
  if(currentBlock >= blocks.length) {
    currentBlock--;
    gameOver = true;
  }
}

void move() {
  int x = blocks[currentBlock][0];
  if(x > 450 || x < 150) {
    moveSpeed = moveSpeed * -1;
  }
  blocks[currentBlock][0] += moveSpeed;
}

void chop() {
  if(currentBlock > 0) {
    int x1 = blocks[currentBlock - 1][0];
    int w1 = blockSizes[currentBlock - 1];
    int x2 = blocks[currentBlock][0];
    int w2 = blockSizes[currentBlock];
    
    if(x1 > x2 && (x1-w1/2) < (x2+w2/2)) {
      int w = (x2+w2/2) - (x1-w1/2);
      int c = (x1-w1/2) + w/2;
      blocks[currentBlock][0] = c;
      for(int i = currentBlock; i < blockSizes.length; i++) {
        blockSizes[i] = w;
      }
    } else if(x2 > x1 && (x2-w2/2) < (x1+w1/2)) {
      int w = (x1+w1/2) - (x2-w2/2);
      int c = (x1+w1/2) - w/2;
      blocks[currentBlock][0] = c;
      for(int i = currentBlock; i < blockSizes.length; i++) {
        blockSizes[i] = w;
      }
    } else if(x1 != x2) {
      gameOver = true;
    }
  }
}
