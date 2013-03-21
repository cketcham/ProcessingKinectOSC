class Joint {
  float x, y, z;

  public Joint() {
    x = 0;
    y = 0;
    z = 0;
  }

  public Joint(float x_, float y_, float z_) {
    x = x_;
    y = y_;
    z = z_;
  }

  public Joint(OscMessage theOscMessage) {
    x=theOscMessage.get(2).floatValue()*width;
    y=theOscMessage.get(3).floatValue()*height;
    z=theOscMessage.get(4).floatValue();
  }
}

