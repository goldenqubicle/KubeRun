class ENV {

  int fade;
  float finish;
  color color1, color2, color3, color4;

  ENV() {
    // target colors
    color1 = color(255, 153, 51);
    color2 = color(255, 255, 51);
    color3 = color(153, 255, 51);
    color4 = color(51, 255, 51);
    // red fail state
    fade = 255;
  }

  void spotlight() {
    float x, y;
    x = 320;
    y=320;
    if (state.hit == false) {
      x = mouseX;
      y = mouseY;
    }
    spotLight(128, 128, 128, x, y, state.Zplane+state.PushBack, 0, 0, -1, 360, 250); // center spotlight
  }

  void walls() {
    //ambient(10,10,10);

    lightFalloff(0.00001, 0.00001, 0.000001);
    ambientLight(32, 32, 64, width/2, height/2, 0);
    ambientLight(32, 32, 64, 0, height, -state.Zplane);
    ambientLight(32, 32, 64, width, 0, -state.Zplane);
    ambientLight(32, 32, 64, width, height, -state.Zplane);


    fill(124, 180, 255, 128); // dynamic color on basis off level

    // pull walls backwards
    pushMatrix();
    translate(0, 0, state.Zplane);

    //noStroke();
    //strokeWeight(2);
    // left & right
    pushMatrix();
    rotateY(TAU/4);   
    emissive(10, 10, 10);
    rect(0, 0, width*8, height); // replace in here, preset the walls to finish distance? 
    pushMatrix();
    translate(0, 0, width);
    rect(0, 0, width*8, height); // replace in here
    popMatrix();
    popMatrix();

    // up & down
    pushMatrix();
    rotateX(-TAU/4);
    rect(0, 0, width, height*8); // replace in here
    pushMatrix();
    translate(0, 0, height);
    rect(0, 0, width, height*8); // replace in here
    popMatrix();
    popMatrix();

    popMatrix();
  }


  void target() {
    pushMatrix();
    rectMode(CORNER);
    noStroke();
    fill(color1);
    rect(0, 0, width, height);  
    fill(color2);
    rect(width/8, height/8, 3*(width/4), 3*(height/4)); 
    fill(color3);
    rect(width/4, height/4, 2*(width/4), 2*(height/4));
    fill(color4);
    rect(1.5*(width/4), 1.5*(height/4), 2*(width/8), 2*(height/8));
    popMatrix();
  }

  int RedFade() {
    return fade;
  }
}