final int LIFE_W = 50;
final int LIFE_H = 51;
final int GROUNDHOG_W = 80;
final int GROUNDHOG_H = 80;
final int SOIL_W = 640;
final int SOIL_H = 320;
final int ROBOT_W = 80;
final int ROBOT_H = 80;
final int SOLDIER_W = 80;
final int SOLDIER_H = 80;
final int grid = 80;
final int LIFE_T = 2;
final int CABBAGE_W = 80;
final int CABBAGE_H = 80;
final int BUTTON_W = 144;
final int BUTTON_H = 60;

//boolean
boolean right = false ;
boolean left = false ;
boolean up = false;
boolean down = false;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = GAME_START;

int robotX, robotY, soldierX, soldierY, groundhog_X0, groundhog_Y0, groundhog_X1, groundhog_Y1;
int lifeLeft, cabbageX, cabbageY;
int buttonX, buttonY;

PImage bg, groundhogIdle, life, robot, soil, soldier, cabbage, title;
PImage startNormal, startHovered, restartNormal, restartHovered, gameover;

void setup() {
	size(640, 480);
  // load images
  bg = loadImage("img/bg.jpg");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  gameover = loadImage("img/gameover.jpg");
  imageMode(CORNER);

  //set up groundhog position
  groundhog_X1 = grid*4;
  groundhog_Y1 = grid;
  groundhog_X0 = grid*4;
  groundhog_Y0 = grid;
  
  //set up soldier
  soldierY = grid * floor(random(2,6));
  soldierX = 0;
  
  //set up cabbage
  cabbageY = grid * floor(random(2,6));
  cabbageX = grid * floor(random(0,8));
  
  //set up life
  lifeLeft = 2;
  
  //set up buttons
  buttonX = 248;
  buttonY = 360;
}

void draw() {
	switch (gameState){
    case GAME_START:
    //put bg
    image(title, 0, 0, width, height);
    image(startNormal, buttonX, buttonY, BUTTON_W, BUTTON_H);
    
    //button
    if (mouseX > buttonX && mouseX < buttonX + BUTTON_W && mouseY > buttonY && mouseY < buttonY + BUTTON_H){
      image(startHovered, buttonX, buttonY, BUTTON_W, BUTTON_H);
      if(mousePressed == true){
        gameState = GAME_RUN;
    }}
    break;
    
		case GAME_RUN:
    //put bg
    image(bg, 0, 0, width, height);
    
    //put life
    if (lifeLeft == 3){
    image(life, 10, 10, LIFE_W, LIFE_H);
    image(life, 10 + LIFE_W + 20, 10, LIFE_W, LIFE_H);
    image(life, 10 + LIFE_W*2 + 20*2, 10, LIFE_W, LIFE_H);
    }
    if (lifeLeft == 2){
    image(life, 10, 10, LIFE_W, LIFE_H);
    image(life, 10 + LIFE_W + 20, 10, LIFE_W, LIFE_H);
    }
    if (lifeLeft == 1){
    image(life, 10, 10, LIFE_W, LIFE_H);
    }
    
    //put grass
    noStroke();
    fill(124, 204, 25);
    rect(0, grid*2 - 15, width, 15);
    
    //put soil
    image(soil, 0, grid*2, SOIL_W, SOIL_H);
    
    //put sun
    stroke(255,255,0);
    strokeWeight(5);
    fill(253,184,19);
    ellipse(width - 50, 50, 120,120);

    //put groundhog
    image(groundhogIdle, groundhog_X1, groundhog_Y1, GROUNDHOG_W, GROUNDHOG_H);
    
    //put soldier
    image(soldier, soldierX, soldierY, SOLDIER_W, SOLDIER_H);

    //soldier move
    soldierX += 2;
    if (soldierX > width){
      soldierX = -SOLDIER_W;
    }
    
    //put cabbage
    image(cabbage, cabbageX, cabbageY, CABBAGE_W, CABBAGE_H);
    //bump into soldier
    if (groundhog_X1 < cabbageX + CABBAGE_W && groundhog_X1 + GROUNDHOG_W > cabbageX){
      if (groundhog_Y1 == cabbageY){
        lifeLeft +=1;
        cabbageX = width;
        cabbageY = height;
    }}    
    
    //bump into soldier
    if (groundhog_X1 < soldierX + SOLDIER_W && groundhog_X1 + GROUNDHOG_W > soldierX){
      if (groundhog_Y1 == soldierY){
      groundhog_X1 = groundhog_X0;
      groundhog_Y1 = groundhog_Y0;
      lifeLeft -= 1;
    }}
    
    if (lifeLeft <= 0){
      gameState = GAME_LOSE;
    }
    break;

    case GAME_LOSE:
    //put bg
    image(gameover, 0, 0, width, height);
    image(restartNormal, buttonX, buttonY, BUTTON_W, BUTTON_H);
    
    //button
    if (mouseX > buttonX && mouseX < buttonX + BUTTON_W && mouseY > buttonY && mouseY < buttonY + BUTTON_H){
      image(restartHovered, buttonX, buttonY, BUTTON_W, BUTTON_H);
      if(mousePressed == true){
        lifeLeft = LIFE_T;
        gameState = GAME_RUN;
    }}
    
    break;
}}

void keyPressed(){
  if(key == CODED){
    switch (keyCode){
      case UP:
      up = true;
      if (groundhog_Y1 <= grid){
        groundhog_Y1 = grid;
      }else{
        groundhog_Y1 -= grid;
      }break;
      
      case DOWN:
      down = true;
      if(groundhog_Y1 >= grid*5){
        groundhog_Y1 = grid*5;
      }else{
        groundhog_Y1 += grid;
      }break;
      
      case RIGHT:
      right = true;
      if(groundhog_X1 >= width - grid){
        groundhog_X1 = width - grid;
      }else{
        groundhog_X1 += grid;
      }break;
      
      case LEFT:
      left = true;
      if(groundhog_X1 <= 0){
        groundhog_X1 = 0;
      }else{
        groundhog_X1 -= grid;
      }break;
}}}


////////
void keyReleased(){
}
