class Target {
  PVector Pos;
  float MoveT, Score, Curve, Size, SizeR, SizeRN, Trigger, Distance, totalscore;
  boolean sight = false;
  boolean Last = false;
  boolean detect = false;
  int R;

  Target(float size, int ranges, float xpos, float ypos, float trigger, float distance, float score, boolean finish, float curve) { // pass scores as well? 
    Size =  size;
    R = ranges;
    SizeR = size/ranges;
    Pos = new PVector(norm(xpos, 0, width), norm(ypos, 0, height));
    Trigger = trigger;
    Distance = distance;
    Score = score;
    Last = finish;
    Curve = curve;
    // calculate normalised width of target range
    SizeRN = (norm(size, 0, 640)/(ranges));
    SizeRN = SizeRN/2;
  }  

  void move() {
    if (state.dist > Trigger) {
      MoveT += design.Speed;
      if (Last == true) {
        translate(0, 0, MoveT*state.acc); // equalize finish target speed
      }
      translate(0, 0, MoveT);
      display();
    }
  }

  void display() {

    stroke(design.TargetStroke);
    fill(design.TargetColor);
    emissive(design.TargetEmission);
    shininess(2);
    specular(128);

    pushMatrix(); 
    translate(Pos.x*width, Pos.y*height, -Distance); 
    rectMode(CENTER);
    for (int i = 0; i <= R; i++) {
      
      if (Last == true) {
        stroke(128, 128, 128);
        emissive(115+25*i, 100+20*i, 25+5*i);
      }
      rect(0, 0, Size-(SizeR*i), Size-(SizeR*i), Curve);
    }
    popMatrix();
  }

  boolean detection() {
    if (sight == true) {
      totalscore = 0;
      for (int i = 1; i <= R; i++) {
        if ((controls.mouseXY.x > (Pos.x-SizeRN*i)) && (controls.mouseXY.x < Pos.x+(SizeRN*i)) && 
          (controls.mouseXY.y > (Pos.y-SizeRN*i)) && (controls.mouseXY.y < Pos.y+(SizeRN*i)) ) {
          detect = true;        
          totalscore = totalscore + round((Score/i)/state.run);
        }
      }
    } else {
      totalscore = totalscore + 0;
      detect = false;
    }
    return detect;
  }

  boolean Sight() {
    if (Last == false && MoveT > Distance+state.Zplane) {
      sight = true;
    } else if (Last == true && MoveT > (Distance*state.acc-state.Zplane)+50) {
      sight = true;
      state.finish = true;
    } else if (Last == true && state.level == 3 && MoveT > (Distance*state.acc-state.Zplane)-3650) {
      sight = true;
      state.finish = true;
    } else {  
      sight = false;
    }
    return sight;
  }
}