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
  
    if(img == null){ //draws rectangle if image wasnt provided
    
      rect(pos.x, pos.y, siz.x, siz.y);
      
    } else {
    
      image(img, pos.x, pos.y);
      
    }
  
  }
  

  void updateBullet(){
  
    pos.add(vel);
    
    
  
  }
  
  void hitDetection(ArrayList<Bullet> list, PVector comparedPos, PVector comparedVel, PVector comparedSiz){
    //checks if bullet is touching enemy then removes itself from bulletlist 
    if(abs(pos.x - comparedPos.x) < comparedSiz.x/2 + siz.x/2){
      if(abs(pos.y - comparedPos.y) < comparedSiz.y/2 + siz.y/2){
      
        pos.sub(vel);
        list.remove(this);
        
      }
    
    }
    
    
  }
  
  boolean outsideScreen(){
  
    if(pos.x > width - siz.x/2 || pos.x < siz.x/2){
      return true;
    }
    if(pos.y > height - siz.y/2|| pos.y < siz.y/2){
      return true;
    }
    return false;
    
  }

}
