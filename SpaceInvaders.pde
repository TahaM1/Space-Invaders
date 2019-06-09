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
    P1 = new Player(pPos, pVel, pSiz, bulletWaitTime);
    P2 = new Player(pPos, pVel, pSiz, bulletWaitTime);
    
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
    P1.update(keys);
    P2.update(keys);
  
    //bullet
    for(int i = 0; i < bulletList.size(); i++){
    
      if(bulletList.get(i).outsideScreen()){
        bulletList.remove(i);
      } else {
        bulletList.get(i).updateBullet();
      }
      
    }
  
  
  //CHECK 
    
  
  //DRAW 
    //Player
      P1.drawPlayer();
      P2.drawPlayer();
    //bullet
      for(Bullet bullet : bulletList){
      
        bullet.drawBullet();
        
      }
    
}


void keyPressed(){
  
    if(keyCode == UP){
      keys.add('i');
    } 
    else if(keyCode == DOWN){
      keys.add('k');
    }
    else if(keyCode == RIGHT){
      keys.add('l');
    } 
    else if(keyCode == LEFT){
      keys.add('j');
    }
    else {
      keys.add(key);
    }

}

void keyReleased(){

  
    if(keyCode == UP){
      keys.remove('i');
    } 
    else if(keyCode == DOWN){
      keys.remove('k');
    }
    else if(keyCode == RIGHT){
      keys.remove('l');
    } 
    else if(keyCode == LEFT){
      keys.remove('j');
    }
    else {
      for(int i = 0; i < keys.size(); i ++){
      
        if(key == i){
        
          keys.remove(i);
          break;
        }
      
      }
    }
  
}
