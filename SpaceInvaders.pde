//Space Invaders
//Taha Memon
//Version 1.0 
//May 29 2019 

//variables
  //Player
    PVector pPos, pVel, pSiz;
    Player P1;
    Player P2;
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


void setup(){
  size(800, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  
  //Bullet
    bulletList = new ArrayList<Bullet>();
    bulletSiz = new PVector(5, -5);
    bulletVel = new PVector(0, -1);
    bulletWaitTime = 60;
  //Player
    pPos = new PVector(width/2, height/1.25);
    pVel = new PVector(0, 0);
    pSiz = new PVector(20, 20);
    P1 = new Player(pPos.copy(), pVel.copy(), pSiz.copy(), bulletWaitTime);
    P2 = new Player(pPos.copy(), pVel.copy(), pSiz.copy(), bulletWaitTime);
    
  //keys
    keys = new ArrayList<Character>(4);
    
    String[] P1keys = {"w", "a", "s", "d"};
    String[] P2keys = {"i", "j", "k", "l"};
    P1.setKeys(P1keys);
    P2.setKeys(P2keys);
  //game  
    time = bulletWaitTime;
    score = 0;
}

void draw(){

  //UPDATE 
    //game 
    background(0);
    time++;  
    
    //player
    P1.update();
    P2.update();
   
    //bullet
    for(int i = 0; i < bulletList.size(); i++){
    
      if(bulletList.get(i).outsideScreen()){
        bulletList.remove(i);
      } else {
        bulletList.get(i).updateBullet();
      }
      
    }
  
  
  //CHECK 
    //player
    P1.checkBoundries();
    P2.checkBoundries();
    P1.checkControls(keys);
    P2.checkControls(keys);
    
  //DRAW 
    
    //bullet
      for(Bullet bullet : bulletList){
      
        bullet.drawBullet();
        
      }
    //Player
      P1.drawPlayer();
      P2.drawPlayer();
    
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
