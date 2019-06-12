class Enemy{

  PVector pos, vel, siz;
  PImage img;
  ArrayList<Enemy> list;
 
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
  
    pos.add(vel);
    if(pos.x < (width/8) || pos.x > (width/8)*7){
      pos.y += siz.x*2;
      vel.x *= -1;
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
  
  
}
