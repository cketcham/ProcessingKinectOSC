import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

int NUM_PARTICLES = 40;

VerletPhysics2D physics;
AttractionBehavior[] attractors = new AttractionBehavior[8];
Vec2D[] hands = new Vec2D[8];

OpenNI openNI;

void setup() {
  size(1280, 768, P3D);

  openNI = new OpenNI();

  physics = new VerletPhysics2D();
  physics.setDrag(0.05f);
  physics.setWorldBounds(new Rect(0, 0, width, height));
}

void setupHandGravity(Skeleton sk) {
  if (attractors[sk.user] == null) {
    hands[sk.user] = new Vec2D(sk.get("l_hand").x, sk.get("l_hand").y);
    hands[sk.user+4] = new Vec2D(sk.get("r_hand").x, sk.get("r_hand").y);
    attractors[sk.user] = new AttractionBehavior(hands[sk.user], 350, 1.0f);
    attractors[sk.user+4] = new AttractionBehavior(hands[sk.user+4], 350, 1.0f);
    physics.addBehavior(attractors[sk.user]);
    physics.addBehavior(attractors[sk.user+4]);
  } 
  else {
    hands[sk.user].set(sk.get("l_hand").x, sk.get("l_hand").y);
    hands[sk.user+4].set(sk.get("r_hand").x, sk.get("r_hand").y);
  }
}

void removeHandGravity(Skeleton sk) {
  if (attractors[sk.user] != null) {
    physics.removeBehavior(attractors[sk.user]);
    physics.removeBehavior(attractors[sk.user+4]);
    attractors[sk.user] = null;
    attractors[sk.user+4] = null;
  }
}

void addParticle() {
  VerletParticle2D p = new VerletParticle2D(Vec2D.randomVector().scale(5).addSelf(width / 2, 0));
  physics.addParticle(p);
  // add a negative attraction force field around the new particle
  physics.addBehavior(new AttractionBehavior(p, 20, -1.2f, 0.01f));
}

void draw() {
  background(192);
  noStroke();
  fill(255);
  if (physics.particles.size() < NUM_PARTICLES) {
    addParticle();
  }
  physics.update();
  for (VerletParticle2D p : physics.particles) {
    fill(76, 150, 130 + random(40, 80), random(100, 120));
    ellipse(p.x, p.y, random(22, 28), random(22, 28));
  }

  fill(255);
  for (Skeleton sk : openNI.getSkeletons()) {
    if (sk.visible) {

      for (String name : sk.mJoints.keySet()) {
        Joint j = sk.mJoints.get(name);
        ellipse(j.x, j.y, 15, 15);
      }

      setupHandGravity(sk);
    } 
    else {
      removeHandGravity(sk);
    }
  }

  //  saveFrame("output-####.tga"); // will save each frame with the frameCount
}

