import processing.serial.*;

import cc.arduino.*;
Arduino arduino;
buttonList[] buttons;

void initializeArduino() {
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  definePins();
  for (int b=0; b<4; b++) {
    for (int i =0; i < 5; i++) {
      arduino.pinMode(buttons[b].pins[i], Arduino.INPUT);
    }
  }
};

void definePins() {
  buttons = new buttonList[4]; //creates an array of each column of buttons
  buttons[0] = new buttonList(26, 27, 28, 29, 30); // food
  buttons[1] = new buttonList(31, 32, 33, 34, 9); //entertainment
  buttons[2] = new buttonList(36, 37, 38, 39, 40); //job
  buttons[3] = new buttonList(41, 42, 43, 44, 45); //commute
}
