/* 
 BIG RIG JOB
 setup walls & lighting // partially done
  
 DESIGN STUFF
 formalise color schemes
 design UI in PS - keep start & continue button in middle!
 
 GAMEPLAY TWEAKS
 random seed when a level is started, however, NOT on reset - proves really quite difficult for now 
 
 increasing speed per level, and higher overall speed between levels
 
 all levels one after another, and more targets
 level 1 = 2 targets
 level 2 = 3 targets
 level 3 = 4 targets
 special message if runs==3 && level==3, hyperrun!
 
 idea: move target into own class, so its ONE object with hit detection  
 which I already have in score so to call on it per level
 
 */


//video capture
//import com.hamoid.*; 
//VideoExport LightingRig2; 


Controls controls;
ENV env;
Score score;
State state;

int struct;

void setup() {
  size(640, 640, P3D); 

  controls = new Controls();
  env = new ENV();
  score = new Score();
  state = new State();
  struct = 1;
  
//video capture
//LightingRig2 = new VideoExport(this, "LightingRig2.mp4");
}

void draw() {
  background (0);  

  switch(struct) {

  case 0:
    cursor();
    //gui.buttons();
    break;

  case 1: 
    state.gameloop();
    break;
  }
  //LightingRig2.saveFrame();
}

void mouseClicked() {
}

void keyPressed() {

  controls.reset();
  //controls.menu();
}