class Bullet{

  PVector pos, vel, siz;
  PImage img; 

  
  Bullet(PVector pos, PVector vel, PVector siz){
  
    this(pos, vel, siz, null);
    
  }
  

  Bullet(PVector pos, PVector vel, PVector siz,  PImage img){
  
    this.pos = pos;
    this.vel = vel;
    this.siz = siz;
    this.img = img;
  
  }

  void drawBullet(){
  
    if(img != null){
    
      rect(pos.x, pos.y, siz.x, siz.y);
      
    } else {
    
      image(img, pos.x, pos.y);
      
    }
  
  }
  

  void updateBullet(){
  
    pos.add(vel);
  
  }
  
  void hitDetection(PVector comparedPos, PVector comparedVel, PVector comparedSiz){
  
    if(abs(pos.x - comparedPos.x) < comparedSiz.x/2 + siz.x/2){
      if(abs(pos.y - comparedPos.y) < comparedSiz.y/2 + siz.y/2){
      
      }
    
    }
    
    
  }

}
