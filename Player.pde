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
   
   if(img != null){
     img.resize((int)siz.x, (int)siz.y);
   }
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
  
  void update(ArrayList<Character> keys){
  
    time++;
    
    checkControls(keys);
      
    pos.add(vel);
    
  }
  
  void checkControls(ArrayList<Character> keys){
      if(keys.contains(definedkeys[3].charAt(0))){
        vel.x = 1;
        
      } 
      else if (keys.contains(definedkeys[1].charAt(0))){
        vel.x = -1;
      } else { 
        vel.x = 0;
      }
      
      if(keys.contains(definedkeys[0].charAt(0))){
         
         if(time > bulletTime){
           bulletList.add(new Bullet(pPos.copy(), bulletVel, bulletSiz));
           time = 0;
         }
         
      }
  
  }
  
}
