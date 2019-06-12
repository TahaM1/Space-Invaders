class Enemy{

  PVector pos, vel, siz;
  PImage img;
  ArrayList<Enemy> list;
  int gapBetweenEnemies = 10;
 
   Enemy(PVector pos, PVector vel, PVector siz, ArrayList<Enemy> list){
    this(pos, vel, siz, list, null);
  }
  
  Enemy(PVector pos, PVector vel, PVector siz, ArrayList<Enemy> list, PImage img){
    this.pos = pos;
    this.vel = vel;
    this.siz = siz;
    this.list = list;
    
    if(img != null){ 
     img.resize((int)siz.x, (int)siz.y);
    }
    this.img = img;
  }
  
  void update(){
    
    if(time % 50 == 0){
      pos.add(vel);
      
    }
    
    
    
  }
  
  void draw(){
  
    if(img == null){
    
      rect(pos.x, pos.y, siz.x, siz.y); 
      
    } else { 
    
      image(img, pos.x, pos.y);
    
    }
    
  }
  
  void hitDetection(ArrayList<Bullet> bulletList){
    //checks if bullet is touching enemy then removes itself from bulletlist 
    for(int i = 0; i < bulletList.size(); i++){
      if(abs(pos.x - bulletList.get(i).pos.x) < bulletList.get(i).siz.x/2 + siz.x/2){
        if(abs(pos.y - bulletList.get(i).pos.y) < bulletList.get(i).siz.y/2 + siz.y/2){
      
          pos.sub(vel);
          list.remove(this);
          bulletList.remove(i);
        
        }
    
      }
    }
    
    
    
  }
  
  void changeDirection(){
    
    
    if(pos.x < (width/8) - siz.x/2){
        float offset = abs((width/8 - siz.x/2) - pos.x); 
        
        for(int i = 0; i < list.size(); i++){
          list.get(i).pos.x += offset;
          list.get(i).pos.y += siz.x*2;  
          list.get(i).vel.x *= -1;
        }
       
      }
      else if(pos.x > (width/8)*7 + siz.x/2){
        float offset = abs((width/8*7 - siz.x/2) - pos.x); 
        
         for(int i = 0; i < list.size(); i++){
          list.get(i).pos.x -= offset;
          list.get(i).pos.y += siz.x*2;  
          list.get(i).vel.x *= -1;
        }
        
      }
  
  }
}
