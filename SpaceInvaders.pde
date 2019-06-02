//Space Invaders
//Taha Memon
//Version 1.0 
//May 29 2019 

//variables
  //Player
  PVector pPos;
  PVector pVel; 
 

void setup(){
  size(800, 600);
  
  //Player
    pPos = new PVector(width/2, height/1.25);
    pVel = new PVector(0, 0);
    
}

void draw(){
  background(0);
  
  //UPDATE 
  pPos.add(pVel);
  
  //CHECK 
  
  
  //DRAW 
  rect(pPos.x, pPos.y, 20, 20);
  
  
  
}


void keyPressed(){
  if(keyPressed){
    if(keyCode == RIGHT){
      pVel.x = 1 ;    
    }
    else if(keyCode == LEFT){
      pVel.x = -1;
    }
    if(keyCode == UP){
    
    }
  
  }
  

}

void keyReleased(){

  if(keyCode == RIGHT){
    pVel.x = 0;
  }
  if(keyCode == LEFT){
    pVel.x = 0; 
  }
  
}
