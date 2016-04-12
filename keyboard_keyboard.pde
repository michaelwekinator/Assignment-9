/**
* This sends 1 continuous input values to port 6448 using message /wek/inputs
**/

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

PFont f;

void setup() {
  f = createFont("Courier", 16);
  textFont(f);

  size(480, 180, P2D);
  noStroke();
  smooth();
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,9000);
  dest = new NetAddress("127.0.0.1",6448);
  
}

void draw() {
  background(0);
  fill(255);
  if(frameCount % 2 == 0) {
    sendOsc();
  }
  text("Continuously sends qwerty notes to Wekinator\nUsing message /wek/inputs, to port 6448", 10, 30);
  String j = "";
  char[] qwerty = { 'q','w','e','r','t','y' };
  for (int i = 0; i < qwerty.length; i++) {
    if(qwerty[i] == key)
    {
      j = "key=" + key;
    }
  }
   text(j, 10, 80);
   noStroke();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  float val = 1.0;
  if (keyPressed) {
    if (key == 'q') {
      val = 1.1;
    }
    else if (key == 'w') {
      val = 1.2;
    }
    else if (key == 'e') {
      val = 1.3;
    }
    else if (key == 'r') {
      val = 1.4;
    }
    else if (key == 't') {
      val = 1.5;
    }
    else if (key == 'y') {
      val = 1.6;
    }
  } else {
     val = 1.0;
  }
  msg.add(val);
  println("Value:" + val);
  oscP5.send(msg, dest);
}