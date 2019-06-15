import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Space Invaders
//Taha Memon
//Version 1.0 
//May 29 2019 

//variables
  //audio
  Minim minim;
  AudioPlayer shoot;
  AudioPlayer invader;
  AudioPlayer ufo;
  //Player
    PVector pPos, pVel, pSiz;
    Player P1;
    Player P2;
    ArrayList<Player> playerList;
  //Bullet 
    ArrayList<Bullet> bulletList;
    int bulletWaitTime;
    PVector bulletVel, bulletSiz;
    ArrayList<Bullet> enemybulletlist;
    int firingMode;
  //Keys
    ArrayList<Character> keys;
    String[] P1keys;
    String[] P2keys;
    
  //Game variables  
    int time, score, gameState, timeStarted, enemytime;
  //Enemy
    ArrayList<Enemy> enemyList;
    int incr;
  //scores
    Table table;
    int highscore;
  //Powerup 
    PVector powerupPos;
    PVector powerupVel;
    PVector powerupSiz;
void setup(){
  size(800, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  reset();
}

void draw(){
  if(gameState == 0){
    background(0);
    fill(255);
    textSize(40);
    text("SpaceInvaders\nMultiplayer", width/2, height/7);
    rect(width/2, height/2.5, 100, 50, 20);
    textSize(20);
    fill(0);
    text("Play", width/2, height/2.5);
     if(mouseX > width/2 - 50 && mouseX < width/2 + 50 && mousePressed){//hitdetct for play button
        if(mouseY> height/2.5 - 25 && mouseY < height/2.5 + 25){
          
          reset();
          gameState = 1;
        }
      }
    fill(255);
    rect(width/2, height/1.5, 100, 50, 20);
    fill(0);
    text("Controls", width/2, height/1.5);
    if(mouseX > width/2 - 50 && mouseX < width/2 + 50 && mousePressed){//hit detect for controls button
        if(mouseY> height/1.5 - 25 && mouseY < height/1.5 + 25){
          gameState = 2;
        }
     }
  }
  
  if(gameState == 2){
    background(0);
    fill(255);
    textSize(30);
    text("Controls", width/2, height/8);
    fill(255);
    textSize(20);
    text("P1:\n'd' = move right\n'a' = move left\n'w' = shoot", width/2, height/3);
    text("P2:\nrightArrowKey = move right\nleftArrowKey = move left\nupArrowKey = shoot", width/2, height/1.75);
    fill(255);
    rect(width/2, height/1.25, 100, 50, 20);
    fill(0);
    text("Back", width/2, height/1.25);
    if(mouseX > width/2 - 50 && mouseX < width/2 + 50 && mousePressed){//hit detect for back button
        if(mouseY> height/1.25 - 25 && mouseY < height/1.25 + 25){
          gameState = 0;
        }
     }
  }
  
  if(gameState == 1){
  //UPDATE
    time = millis(); //updating time
    //game 
    background(0);
    enemytime++; //speed of enemy is tied to this time instead of millis() cuz it works better
    
    stroke(255);
    line(width/10, 0, width/10, height);
    line(width/10*9, 0, width/10*9, height);
    
    //player
    P1.update();
    P2.update();
    
    //poewrup
      powerupPos.add(powerupVel);
    
    //enemy
      for( Enemy enemy : enemyList){
        enemy.update();
      }
   
    //bullet
    for(int i = 0; i < bulletList.size(); i++){ //players bullets
        bulletList.get(i).updateBullet();
    }
    for(int i = 0; i < enemybulletlist.size(); i++){ //enemy bullet
        enemybulletlist.get(i).updateBullet();
    }
    
  
  
  //CHECK 
    //powerup
    if(powerupPos.x > width){ //resets powerup pos when offscreen
      powerupPos.x = -500;
    }
    poweruphitDetection(bulletList);
    if(powerupPos.x > 0 && powerupPos.x < width){ //plays sound effect when on screen
      if(!ufo.isPlaying()){
        ufo.rewind();
        
        ufo.play();
      }
      
    }
  
    //player
    
    for(Player player : playerList){
      player.checkBoundries();
      player.checkControls(keys);
    }
   
    
    //bullet
      //boundries 
        for(int i = 0; i < bulletList.size(); i++){
          if(bulletList.get(i).outsideScreen()){
            bulletList.remove(i);
          }
          
        }
      //firingmode 
        //println(abs(timeStarted-time));
        if(abs(timeStarted-time) > 5000 && firingMode != 0){ //changes firemode back to normal after 5s of using powerup
          firingMode = 0;
        }
      
      
    //enemy
      //bullet hit detections
        for(int i = 0; i < enemyList.size(); i++){
            
            enemyList.get(i).hitDetection(bulletList);//checks if player hit enemy
                
        }
      //changing enemy movement
        for(int i = 0; i < enemyList.size(); i++){
            
            enemyList.get(i).changeDirection();
                
        }
        if(enemyList.size() == 0){ //resets enemys after player has hit all of them
          incr += 50;
          for(int i = 0; i < 11; i++){
            PImage[] enemysprites3 = {loadImage("Alien301.png"),loadImage("Alien302.png")};
            PImage[] enemysprites2 = {loadImage("Alien201.png"),loadImage("Alien202.png")};
            PImage[] enemysprites1 = {loadImage("Alien101.png"),loadImage("Alien102.png")};
             enemyList.add(new Enemy(new PVector(200 + (i * 40), 125 + incr), new PVector(10, 0), new PVector(20, 20),enemyList, 30, enemysprites3));
            enemyList.add(new Enemy(new PVector(200 + (i * 40), 150 + incr), new PVector(10, 0), new PVector(20, 20),enemyList, 20, enemysprites2));
            enemyList.add(new Enemy(new PVector(200 + (i * 40), 175 + incr), new PVector(10, 0), new PVector(20, 20),enemyList, 20, enemysprites2));
            enemyList.add(new Enemy(new PVector(200 + (i * 40), 200 + incr), new PVector(10, 0), new PVector(20, 20),enemyList, 10, enemysprites1));
            enemyList.add(new Enemy(new PVector(200 + (i * 40), 225 + incr), new PVector(10, 0), new PVector(20, 20),enemyList, 10, enemysprites1));
                
          }
        }
        for(Enemy bullet : enemyList){ //enemy fires bullets 
           bullet.fireBullet();
        }
        for(Enemy enemy : enemyList){ //ends game if enemy reaches player
           if(enemy.pos.y >= P1.pos.y){
             gameState = 5;
             TableRow newRow = table.addRow();
             newRow.setInt("scores", score);
             saveTable(table, "scores.csv"); //saves to csv
             
           }
        }
        if(playerList.size() == 0){ //ends gamme if there are no players
           gameState = 5;
             TableRow newRow = table.addRow();
             newRow.setInt("scores", score); //adds scores
             saveTable(table, "scores.csv"); //saves it to csv
        }
    
        for(int i = 0; i < playerList.size(); i++){ //removes player if hit 
          playerList.get(i).hitDetection(enemybulletlist);
        }
    
  //DRAW 
    
    //bullet
      for(Bullet bullet : bulletList){
      
        bullet.drawBullet();
        
      }
       for(Bullet bullet : enemybulletlist){
      
        bullet.drawBullet();
        
      }
      
    //Player
      for(int i = 0; i < playerList.size(); i++){
        playerList.get(i).drawPlayer();
      }
    //enemy
      for( Enemy enemy : enemyList){
        enemy.draw();
      }
    //UI
      fill(255);
      textSize(15);
      text("Score: " + score, width/1.25, height/9);
      text("HighScore: " + highscore, width/2, height/9);
    //powerup
      image(loadImage("spaceship.png"), powerupPos.x, powerupPos.y);
      
  }
  
  if(gameState == 5){
    background(0);
    textSize(20);
    text("GAME OVER", width/2, height/8);
    int[] scores = new int[table.getRowCount()];
    int i = 0;
    for(TableRow row : table.rows()){ //puts scores in array 
      scores[i] = row.getInt("scores");
      i++;
    }
    textSize(12);
    bubblesort(scores); //sorting highest to lowest
    if(score > highscore){
      textSize(20);
      text("New High Score!", width/2, height/6);
      text(score, width/2, height/4);
    } else {
      text("Score: " + score, width/2, height/6);
      text("Top Five scores:", width/2, height/4);
      int numOfScores = 0;
      if(scores.length > 5){ //makes it so only 5 or less scores show up
        numOfScores = 5;
      } else {
        numOfScores = scores.length;
      }

      for(int j = 0; j < numOfScores; j++){ // displays top 5 scores from csv file
        text(scores[j], width/2, height/3 + (50 * j)); 
       // println(scores[j]);
      }
    }
    text("Click anywhere on the screen to continue", width/2, height/1.2);
    if(mousePressed){
      gameState = 0;
    }
    
  }
}


void keyPressed(){
    
    char keypressed = key; 
  
    //checks if arrow keys are pressed then maps them to keys
    if(keyCode == UP){
      keypressed = 'i';
    } 
    else if(keyCode == DOWN){
      keypressed = 'k';
    }
    else if(keyCode == RIGHT){
      keypressed = 'l';
    } 
    else if(keyCode == LEFT){
      keypressed = 'j';
    }
    
    //adds keypressed to keys list if not already in it 
    if(!keys.contains(keypressed)){
      keys.add(keypressed);
    
    }

}

void keyReleased(){
    char keyreleased = key;
    
    //checks if arrows keys are pressed
    if(keyCode == UP){
       keyreleased = 'i';  
    } 
    else if(keyCode == DOWN){
      keyreleased = 'k';
    }
    else if(keyCode == RIGHT){
      keyreleased = 'l';
    } 
    else if(keyCode == LEFT){
      keyreleased = 'j';
    }
    
    //checks if the key released is in the list then removes it 
    for(int i = 0; i < keys.size(); i++){
      
      if(keyreleased == keys.get(i)){
        keys.remove(i);
        break;
      }
      
    }
       
  
}

void bubblesort(int[] array){

  boolean sorted =  false;

        while(!sorted) {
            sorted = true;
            //swaps neighbouring numbers if one is less than other
            for (int i = 0; i < array.length - 1; i++) {
                if (array[i] < array[i + 1]) {
                    int smallTemp = array[i + 1];
                    int bigTemp = array[i];
                    array[i + 1] = bigTemp;
                    array[i] = smallTemp;
                    sorted = false;
                }
            }
          }
  
}

void poweruphitDetection(ArrayList<Bullet> bulletList){
    //checks if bullet is touching powerup then removes itself from bulletlist 
    for(int i = 0; i < bulletList.size(); i++){
      if(abs(powerupPos.x - bulletList.get(i).pos.x) < bulletList.get(i).siz.x/2 + powerupSiz.x/2){
        if(abs(powerupPos.y - bulletList.get(i).pos.y) < bulletList.get(i).siz.y/2 + powerupSiz.y/2){
      
          powerupPos.sub(powerupVel);
          float random = random(10);
          if(random > 5){ //selects firingmode
            firingMode = 1;
          } else if(random < 5){
            firingMode = 2;
          }
          
          timeStarted = millis(); //records time so firingmode can be changed after a couple secs
          powerupPos.x = -600; //resets pos
          bulletList.remove(i);
          invader.rewind();
          invader.play();
        }
    
      }
    }
    
    
    
  }
  
void reset(){
gameState = 0;
  //Bullet
    bulletList = new ArrayList<Bullet>();
    enemybulletlist = new ArrayList<Bullet>();
    bulletSiz = new PVector(1, -7);
    bulletVel = new PVector(0, -5);
    bulletWaitTime = 15; //limits how long you need to wait before firing
    firingMode = 0; 
  //Player
    pVel = new PVector(0, 0);
    pSiz = new PVector(13, 15);
    P1 = new Player(new PVector(width/4, height/1.15), pVel.copy(), pSiz.copy(), bulletWaitTime, loadImage("P1.png"));
    P2 = new Player(new PVector(width/4*3, height/1.15), pVel.copy(), pSiz.copy(), bulletWaitTime, loadImage("P2.png"));
    playerList = new ArrayList<Player>(); //stores players
    playerList.add(P1);
    playerList.add(P2);
    
  //keys
    keys = new ArrayList<Character>(4);
    
    String[] P1keys = {"w", "a", "s", "d"};
    String[] P2keys = {"i", "j", "k", "l"};
    P1.setKeys(P1keys);
    P2.setKeys(P2keys);
  //game  
    time = millis();
    score = 0;
    timeStarted = 0;
    enemytime = 0;
  //enemy
    //creates the enemies and lloads sprites
    enemyList = new ArrayList<Enemy>();
    PImage[] enemysprites3 = {loadImage("Alien301.png"),loadImage("Alien302.png")};
    PImage[] enemysprites2 = {loadImage("Alien201.png"),loadImage("Alien202.png")};
    PImage[] enemysprites1 = {loadImage("Alien101.png"),loadImage("Alien102.png")};
    for(int i = 0; i < 11; i++){
      enemyList.add(new Enemy(new PVector(200 + (i * 40), 125), new PVector(10, 0), new PVector(20, 20),enemyList, 30, enemysprites3));
      enemyList.add(new Enemy(new PVector(200 + (i * 40), 150), new PVector(10, 0), new PVector(20, 20),enemyList, 20, enemysprites2));
      enemyList.add(new Enemy(new PVector(200 + (i * 40), 175), new PVector(10, 0), new PVector(20, 20),enemyList, 20, enemysprites2));
      enemyList.add(new Enemy(new PVector(200 + (i * 40), 200), new PVector(10, 0), new PVector(20, 20),enemyList, 10, enemysprites1));
      enemyList.add(new Enemy(new PVector(200 + (i * 40), 225), new PVector(10, 0), new PVector(20, 20),enemyList, 10, enemysprites1));
          
    }
    incr = 0; //used to get enemies close after players defeat a wave 
  //scores
    table = loadTable("scores.csv", "header"); //loads scores into a table
    //println(table.getRowCount());
    int[] scores = new int[table.getRowCount()];
    int i = 0;
    for(TableRow row : table.rows()){//records the scores then finds the highscore
      println(row.getInt("scores"));
      scores[i] = row.getInt("scores");
      i++;
    }
    bubblesort(scores);
    highscore = scores[0];
    
  //audio 
    minim = new Minim(this);
   //sound effects
    shoot = minim.loadFile("shoot.wav");
    invader = minim.loadFile("invaderkilled.wav");
    ufo = minim.loadFile("ufo_lowpitch.wav");
    
  //powerup 
    powerupPos = new PVector(-500, width/8);
    powerupVel = new PVector(1, 0);
    powerupSiz = new PVector(16, 16);
}
