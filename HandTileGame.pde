import de.voidplus.leapmotion.*;

Grid g;

LeapMotion leap;

boolean startGettingData = true;
float prevXPos;
float prevYPos;

void setup() {
  size(800, 600, P3D);
  frameRate(30);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  g = new Grid();
  leap = new LeapMotion(this);
}

void draw() {
  background(0);
  for (Hand h : leap.getHands()) {
    if (h.isRight()) { 
        g.setMovementSignal(0);
        
        float pitch = h.getPitch();
        float roll = h.getRoll();
        
        rotateX(-pitch * (PI / 180));
        rotateY(roll * (PI / 180));
        
        g.setMovementSignal(0);
        if (pitch < 15 && pitch > -15 && roll < 15 && roll > -15) {
          startGettingData = true;
          background(0, 255, 0);
        }
        
        if (!startGettingData) break;
        
        if (h.getPitch() > 20) {
            g.setMovementSignal(4);
            startGettingData = false;
        }
        if (h.getPitch() < -20) {
          g.setMovementSignal(3);
          startGettingData = false;
        }
        if (h.getRoll() > 20) {
          g.setMovementSignal(2);
          startGettingData = false;
        }
        if (h.getRoll() < -20) {
          g.setMovementSignal(1); 
          startGettingData = false;
        }
    }
    else g.setMovementSignal(0);
  }
  
  g.update();
}

void keyPressed()
{
  switch(key)
  {
    case 'w':
      g.setMovementSignal(3);
    break;
    case 's':
      g.setMovementSignal(4);
    break;
    case 'a':
      g.setMovementSignal(1);
    break;
    case 'd':
      g.setMovementSignal(2);
    break;
  }
}

void keyReleased()
{
  switch(key)
  {
    case 'w':
      g.setMovementSignal(0);
    break;
    case 's':
      g.setMovementSignal(0);
    break;
    case 'a':
      g.setMovementSignal(0);
    break;
    case 'd':
      g.setMovementSignal(0);
    break;
  }
}
