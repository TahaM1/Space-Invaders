//Space Invaders
//Taha Memon
//Version 1.0 
//May 29 2019 

//variables
  //Player
    PVector pPos, pVel, pSiz;
    Player P1;
    Player P2;
    ArrayList<Player> playerList;
  //Bullet 
    ArrayList<Bullet> bulletList;
    int bulletWaitTime;
    PVector bulletVel, bulletSiz;
  //Keys
    ArrayList<Character> keys;
    String[] P1keys;
    String[] P2keys;
    
  //Game variables  
    int time, score;
  //Enemy
    ArrayList<Enemy> enemyList;

void setup(){
  size(800, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  
  //Bullet
    bulletList = new ArrayList<Bullet>();
    bulletSiz = new PVector(5, -5);
    bulletVel = new PVector(0, -5);
    bulletWaitTime = 30;
  //Player
    pPos = new PVector(width/2, height/1.25);
    pVel = new PVector(0, 0);
    pSiz = new PVector(20, 20);
    P1 = new Player(new PVector(width/4, height/1.25), pVel.copy(), pSiz.copy(), bulletWaitTime);
    P2 = new Player(new PVector(width/4*3, height/1.25), pVel.copy(), pSiz.copy(), bulletWaitTime);
    playerList = new ArrayList<Player>();
    playerList.add(P1);
    playerList.add(P2);
    
  //keys
    keys = new ArrayList<Character>(4);
    
    String[] P1keys = {"w", "a", "s", "d"};
    String[] P2keys = {"i", "j", "k", "l"};
    P1.setKeys(P1keys);
    P2.setKeys(P2keys);
  //game  
    time = bulletWaitTime;
    score = 0;
  //enemy
    enemyList = new ArrayList<Enemy>();
    for(int i = 0; i < 20; i++){
      enemyList.add(new Enemy(new PVector(100 + (i * 25), 100), new PVector(1, 0), new PVector(20, 20),enemyList));
      enemyList.add(new Enemy(new PVector(100 + (i * 25), 200), new PVector(1, 0), new PVector(20, 20),enemyList));

    }
}

void draw(){

  //UPDATE 
    //game 
    background(0);
    time++;  
    
    //player
    P1.update();
    P2.update();
    
    //enemy
      for( Enemy enemy : enemyList){
        enemy.update();
      }
   
    //bullet
    for(int i = 0; i < bulletList.size(); i++){
        bulletList.get(i).updateBullet();
    }
      
    
  
  
  //CHECK 
    //player
    P1.checkBoundries();
    P2.checkBoundries();
    P1.checkControls(keys);
    P2.checkControls(keys);
    
    //bullet
      //boundries 
        for(int i = 0; i < bulletList.size(); i++){
          if(bulletList.get(i).outsideScreen()){
            bulletList.remove(i);
          }
          
        }
    
    //enemy
      //bullet hit detections
        for(int i = 0; i < enemyList.size(); i++){
            
            enemyList.get(i).hitDetection(bulletList);
            println(enemyList.size());
        }
    
  //DRAW 
    
    //bullet
      for(Bullet bullet : bulletList){
      
        bullet.drawBullet();
        
      }
    //Player
      P1.drawPlayer();
      P2.drawPlayer();
    //enemy
      for( Enemy enemy : enemyList){
        enemy.draw();
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
