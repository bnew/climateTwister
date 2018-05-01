int[][] answers; //<>//
int[] currentPresses;

//read buttons takes a column of buttons to read
//and the number of buttons needed to be pressed, 
//as well as whether to store the button presses as 'answers'

//it then reads the relevant buttons using firmata
//updates currentPresses & answers
//and returns true or false

boolean readButtons(int column, int numButtons, boolean storeAnswers) {
  //store last rounds button presses so we can pay attention to them.
  int lastPress0 = currentPresses[0];
  int lastPress1 = currentPresses[1];
   //these display the button currently pressed as user feedback, so we reset it every time
  currentPresses[0] = -1;
  currentPresses[1] = -1;
  
  int count = 0;
  int[] a = new int[numButtons];
  for (int i = 0; i < 5; i++) //loop through each button in the list
  {
    arduino.digitalWrite(buttons[column].pins[i], Arduino.HIGH); //pullup - write it high
    int reading = arduino.digitalRead(buttons[column].pins[i]); //read the button
    
    buttons[column].states[i] = splice(buttons[column].states[i], reading, 0); //splices into the first position, seems to keep the array at 4 elements.
    //println("Update: " + thisButtonStates.length);


    if (debounce(buttons[column].states[i])) //if all previous reads were low
    {
      a[count] = i; //store the answer position (var i means which button was pressed)
      currentPresses[count] = i; //this stores the answer for display 
      //try to compare against last presses and only play a blip if its a new button
      if(count == 0 && lastPress0 != i)blip.play(); 
      else if(count==1 && lastPress1 != i) blip.play();
      count++;
      println("In column: " + column + " button pressed: " + i + " button count: " + count);
      if (count >= numButtons) {
        if (storeAnswers)answers[column] = sort(a); //sort the answers from lowest button to high and store it cuz our results are structured to take the answers in this form
        return true;
      }
    }
  }
  return false;
}

boolean debounce(int[] b) {
  for (int i = 0; i < 4; i++) {
    if(b[i] !=0) return false;
  }
  return true;
}


//represents a column of buttons
class buttonList {
  int[] pins;
  int[][] states; //multi dimensional to save past button states to do some debouncing
  String[] lables;

  buttonList(int pinRow1, int pinRow2, int pinRow3, int pinRow4, int pinRow5) {
    pins = new int[5];
    states = new int[5][4];
    pins[0] = pinRow1;
    pins[1] = pinRow2;
    pins[2] = pinRow3;
    pins[3] = pinRow4;
    pins[4] = pinRow5;
    resetStates();
  }

  void resetStates() {
    for (int i = 0; i <5; i ++) {
      for (int r = 0; r<4; r++) states[i][r] = 1;
    }
  }
}
