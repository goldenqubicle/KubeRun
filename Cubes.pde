class Cubes {

  PVector size, pos, cubeW, cubeH;
  boolean Z = false;
  //float pX, pY;
  color cubeC, Stroke, Emissive, Specular;
  float S = 0;

  Cubes(int size_min, int size_max, int spawn_min, int spawn_max, color colorkube, color stroke, color emissive, color specular) {
    // spawn position & size cubes
    pos = new PVector(random(0, width), random(0, height), random(spawn_min, spawn_max)); 
    size = new PVector(random(size_min, size_max), random(size_min, size_max), random(size_min, size_max));
    // normalise position & volume of cube for collision
    cubeW = new PVector(norm(pos.x-(size.x), 0, width), norm(pos.x+(size.x), 0, width));
    cubeH = new PVector(norm(pos.y-(size.y), 0, height), norm(pos.y+(size.y), 0, height));
    // color 
    cubeC = color (colorkube);
    
    Stroke = stroke;
    Emissive = emissive;
    Specular = specular;
    
  }

  void move() {    
    pos.z += design.Speed;
    if (state.hit == true) {
      display(); 
      design.Speed = 0;
      state.start = false;
    }
    if (state.start == true) {
      display();
    }
  }

  void display() {
    // set color & outline cubes
    pushMatrix();
    translate(0, 0, -state.PushBack);
    translate(pos.x, pos.y, pos.z); 
    stroke(Stroke);
      if(state.level == 3 && design.T2.sight == true){
       noStroke(); 
      }
    emissive(Emissive);
    specular(Specular);
    fill(cubeC);
    box(size.x, size.y, size.z);
    popMatrix();
  }

  boolean OutOfSight() {
    // check if Kube is behind Zplane
    if (pos.z/state.acc-size.z > state.Zplane+size.z) { 
      Z = true;
    }
    return Z;
  }

  void collision() {
    // check if cube is on Zplane
    if ((pos.z/state.acc)-size.z/2 >= state.Zplane+size.z/2) { 
      if ( (controls.mouseXY.x > cubeW.x) && (controls.mouseXY.x < cubeW.y) && (controls.mouseXY.y > cubeH.x) && (controls.mouseXY.y < cubeH.y) ) { // new collision detection
        state.hit = true;
        state.start = false;
      }
    }
  }
}