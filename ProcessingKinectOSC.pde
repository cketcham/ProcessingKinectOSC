OpenNI openNI;
 
void setup() {
  size(1024, 640, P2D);
  colorMode(RGB, 255);
  background(192);
  smooth(8);
  
  openNI = new OpenNI();
}
 
void draw() {
  frame.setTitle(frameRate + "fps");
  background(192);

  for(Skeleton sk : openNI.getSkeletons()) {
    if (sk.visible) {
      ellipse(sk.get("head").x, sk.get("head").y, 40, 60);
      fill(255, 50, 50);
      ellipse(sk.get("l_hand").x, sk.get("l_hand").y, 30, 30);
      fill(50, 50, 255);
      ellipse(sk.get("r_hand").x, sk.get("r_hand").y, 30, 30);
      
      for(String name : sk.mJoints.keySet()) {
        Joint j = sk.mJoints.get(name);
        ellipse(j.x,j.y, 15, 15);
      }
    }
  }
}
