class Enemy{

  PVector pos, vel, siz;
  PImage[] img;
  ArrayList<Enemy> list;
  int gapBetweenEnemies = 10;
  int pointsWorth;
  int frame = 0;
  int speed = 100;
  
 
   Enemy(PVector pos, PVector vel, PVector siz, ArrayList<Enemy> list, int points){
    this(pos, vel, siz, list, points, null);
  }
  
  Enemy(PVector pos, PVector vel, PVector siz, ArrayList<Enemy> list, int points, PImage[] img){
    this.pos = pos;
    this.vel = vel;
    this.siz = siz;
    this.list = list;
    this.pointsWorth = points;
    
    
    this.img = img;
  }
  
  void update(){
    if(list.size() < 40){ //increases rate of movement based on the # of enemies
      speed = 50;
    }
    if(list.size() < 25){
      speed = 25;
    } 
    if(list.size() < 10) {
      speed = 10;
    
    } 
    if(list.size() < 5){
      speed = 3;
    }
    
    if(enemytime % speed == 0){
      
      pos.add(vel);
      frame++; //cycles through sprites
      
    }
    
    if(frame >= img.length){ //goes back to the first sprite
      frame = 0; 
    } 
    
    
  }
  
  void draw(){
  
    if(img == null){
    
      rect(pos.x, pos.y, siz.x, siz.y); 
      
    } else { 
    
      image(img[frame], pos.x, pos.y);
    
    }
    
  }
  
  void hitDetection(ArrayList<Bullet> bulletList){
    //checks if bullet is touching enemy then removes itself from bulletlist 
    for(int i = 0; i < bulletList.size(); i++){
      if(abs(pos.x - bulletList.get(i).pos.x) < bulletList.get(i).siz.x/2 + siz.x/2){
        if(abs(pos.y - bulletList.get(i).pos.y) < bulletList.get(i).siz.y/2 + siz.y/2){
      
          pos.sub(vel);
          list.remove(this); //removes enemy
          bulletList.remove(i); //removes bulley
          score += pointsWorth; //adds points
          invader.rewind();
          invader.play();
        }
    
      }
    }
    
    
    
  }
  
  void changeDirection(){
    
    
    if(pos.x < (width/10) + siz.x/2){
        float offset = abs((width/10 - siz.x/2) - pos.x);  
        //if any enemy is past the boundires move all them back then shift their y pos down
        //then reverse vel
        for(int i = 0; i < list.size(); i++){
          list.get(i).pos.x += offset;
          list.get(i).pos.y += siz.x*2;  
          list.get(i).vel.x *= -1;
        }
       
      }
      else if(pos.x > (width/10)*9 - siz.x/2){
        float offset = abs((width/10*9 - siz.x/2) - pos.x); 
        //same as above but for the left side of scren
         for(int i = 0; i < list.size(); i++){
          list.get(i).pos.x -= offset;
          list.get(i).pos.y += siz.x*2;  
          list.get(i).vel.x *= -1;
        }
        
      }
  
  }
  
  void fireBullet(){
    boolean fireBullet = true;
    for(int i = 0; i < list.size(); i++){
      if(pos.x == list.get(i).pos.x){
        if(pos.y < list.get(i).pos.y){
          fireBullet = false;
        }
      }
    }
    if(fireBullet){
      if(random(10) < 0.02){
        enemybulletlist.add(new Bullet(pos.copy(), new PVector(0, 5), bulletSiz, loadImage("playerbullet.png"), enemybulletlist ));
      }
    }
    
  }
}
