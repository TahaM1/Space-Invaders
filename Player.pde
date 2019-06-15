class Player{

  PVector pos, vel, siz;
  PImage img;
  int bulletTime, time;
  String[] definedkeys;
  
  
  Player(PVector pos, PVector vel, PVector siz, int bulletTime){
  
    this(pos, vel, siz, bulletTime, null);
   
  }
  
  void setKeys(String[] newKeys){
  
    this.definedkeys = newKeys;
  
  }
    
    
  Player(PVector pos, PVector vel, PVector siz, int bulletTime, PImage img){
  
   this.pos = pos;
   this.vel = vel;
   this.siz = siz;
   
  
   this.img = img;
   this.bulletTime = bulletTime;
   time = bulletTime;
   
  }
  
  void drawPlayer(){
  
    if(img == null){
    
      rect(pos.x, pos.y, siz.x, siz.y); 
      
    } else { 
    
      image(img, pos.x, pos.y);
    
    }
    
  }
  
  void update(){
  
    time++;
      
    pos.add(vel);
    
  }
  
  void checkControls(ArrayList<Character> keys){ //checks if the any of the set keys for this player are pressed
      if(keys.contains(definedkeys[3].charAt(0))){ //moves right
        vel.x = 3;
        
      } 
      else if (keys.contains(definedkeys[1].charAt(0))){ //moves left
        vel.x = -3; 
      } else { 
        vel.x = 0;
      }
      
      if(keys.contains(definedkeys[0].charAt(0))){ //shoots bullets
         
         if(time > bulletTime){ //checks if a certain amount of time has passed before shooting another bullet
           if(firingMode == 1){
             bulletList.add(new Bullet(pos.copy(), bulletVel, bulletSiz, loadImage("playerbullet.png"), bulletList));
             bulletList.add(new Bullet(pos.copy(), new PVector(1, -5), bulletSiz, loadImage("playerbullet.png"), bulletList));
             bulletList.add(new Bullet(pos.copy(),new PVector(-1, -5), bulletSiz, loadImage("playerbullet.png"), bulletList));

           } else if(firingMode == 2){
            bulletList.add(new Bullet(pos.copy().sub(new PVector(10, 0)), bulletVel, bulletSiz, loadImage("playerbullet.png"), bulletList));
             bulletList.add(new Bullet(pos.copy(), bulletVel, bulletSiz, loadImage("playerbullet.png"), bulletList));
             bulletList.add(new Bullet(pos.copy().sub(new PVector(-10, 0)), bulletVel, bulletSiz, loadImage("playerbullet.png"), bulletList));

           }
           
           else{
           bulletList.add(new Bullet(pos.copy(), bulletVel, bulletSiz, loadImage("playerbullet.png"), bulletList));
           
           }
           
           shoot.rewind(); //plays sound effect
           shoot.play();
           time = 0;
         }
         
      }
  
  }
  
  
  void checkBoundries(){ //restricts pos
  
    if(pos.x > width/10*9 - siz.x/2){
    
       pos.x = width/10*9 - siz.x/2;
    
    } else if (pos.x < width/10 + siz.x/2){
    
      pos.x = width/10 + siz.x/2;
      
    }
    
    if(pos.y > height - siz.y/2){
    
       pos.y = height - siz.y/2;
    
    } else if (pos.y < siz.y/2){
    
      pos.y = siz.y/2;
      
    }
    
    
  }
  
  void hitDetection(ArrayList<Bullet> bulletList){
    //checks if bullet is touching player then removes itself from bulletlist 
    for(int i = 0; i < bulletList.size(); i++){
     // println(abs(pos.x - bulletList.get(i).pos.x) + " " +(bulletList.get(i).siz.x/2 + siz.x/2));
      if(abs(pos.x - bulletList.get(i).pos.x) < bulletList.get(i).siz.x/2 + siz.x/2){
        if(abs(pos.y - bulletList.get(i).pos.y) < bulletList.get(i).siz.y/2 + siz.y/2){
      
          pos.sub(vel);
          playerList.remove(this);
          bulletList.remove(i);
          
        }
    
      }
    }
    
    
    
  }
  
}
