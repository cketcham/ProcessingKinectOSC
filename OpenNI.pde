import oscP5.*;

class OpenNI {

  OscP5 oscP5;
  private ArrayList<Skeleton> mSkeletons = new ArrayList<Skeleton>(4);

  public OpenNI() {
    oscP5 = new OscP5(this, 12345);
    for(int i=0;i<4;i++) {
      mSkeletons.add(new Skeleton(i)); 
    }
  }

  public ArrayList<Skeleton> getSkeletons() {
    return mSkeletons;
  }

  public Skeleton getSkeleton(int user) {
    for (Skeleton sk : mSkeletons) {
      if (sk.user == user)
        return sk;
    }
    return null;
  }

  private Skeleton ensureSkeleton(int user) {
    Skeleton sk = getSkeleton(user);
    if (sk == null) {
      sk = new Skeleton(user);
      mSkeletons.add(sk);
    }
    sk.visible = true;
    return sk;
  }
  
  private void removeSkeleton(int user) {
    Skeleton sk = getSkeleton(user);
    sk.visible = false;
  }

  /* incoming osc message. */
  void oscEvent(OscMessage theOscMessage) {
//    print("### received an osc message."+theOscMessage);
//    print(" addrpattern: "+theOscMessage.addrPattern());
//    println(" typetag: "+theOscMessage.typetag());

    String addr = theOscMessage.addrPattern();

    if ("/joint".equals(addr)) {
      String joint = theOscMessage.get(0).stringValue();

      int user = theOscMessage.get(1).intValue();
      Skeleton sk = ensureSkeleton(user);

      sk.updateJoint(joint, new Joint(theOscMessage));
    }
    else if ("/new_user".equals(addr) || "/reenter_user".equals(addr)) {
      int user = theOscMessage.get(0).intValue();
      ensureSkeleton(user);
    } else if("/lost_user".equals(addr) || "/exit_user".equals(addr)) {
      int user = theOscMessage.get(0).intValue();
      removeSkeleton(user);
    }
  }
}

