import java.util.HashMap;

class Skeleton {
  int user;
  boolean visible = false;

  HashMap<String, Joint> mJoints = new HashMap<String, Joint>();

  String[] jointNames = new String[] {
    "head", "neck", "torso", "waist", "l_collar", "l_shoulder",
    "l_elbow", "l_wrist", "l_hand", "l_fingertip", "r_collar", "r_shoulder",
    "r_elbow", "r_wrist", "r_hand", "r_fingertip", "l_hip", "l_knee",
    "l_ankle", "l_foot", "r_hip", "r_knee", "r_ankle", "r_foot"
  };

  public Skeleton(int user) {
    this.user = user;
    for(String name : jointNames) {
      updateJoint(name, new Joint());
    }
  }

  public void updateJoint(String name, Joint j) {
    mJoints.put(name, j);
  }

  public Joint get(String name) {
    Joint j = mJoints.get(name);
    return (j == null) ? new Joint() : j;
  }
}

