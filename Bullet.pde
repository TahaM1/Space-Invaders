class Bullet{

  PVector pos, vel, siz;
  PImage img; 
  ArrayList<Bullet> list;
  
  Bullet(PVector pos, PVector vel, PVector siz, ArrayList<Bullet> list){
  
    this(pos, vel, siz, null, list);
    
  }
  

  Bullet(PVector pos, PVector vel, PVector siz,  PImage img, ArrayList<Bullet> list){
  
    this.pos = pos;
    this.vel = vel;
    this.siz = siz;
    this.img = img;
    this.list = list;
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
  
  void hitDetection(ArrayList<Enemy> enemyList){
    //checks if bullet is touching enemy then removes itself from bulletlist 
    for(int i = 0; i < enemyList.size(); i++){
      if(abs(pos.x - enemyList.get(i).pos.x) < enemyList.get(i).siz.x/2 + siz.x/2){
        if(abs(pos.y - enemyList.get(i).pos.y) < enemyList.get(i).siz.y/2 + siz.y/2){
      
          pos.sub(vel);
          list.remove(this);
          enemyList.remove(i);
        
        }
    
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
