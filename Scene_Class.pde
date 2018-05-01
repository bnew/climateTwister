class Scene {
  SoundFile audio;
  String instructions;
  boolean sceneStart = true;
  int columnIndex;
  int buttonCount;
  float sceneStartTime;

  Scene(String i, SoundFile a) {
    instructions = i;
    audio = a;
    audio.rate(.5);
    columnIndex = -1;
    buttonCount = 1;
  }
  
  Scene(String i, SoundFile a, int column) {
    columnIndex = column;
    instructions = i;
    audio = a;
    audio.rate(.5);  
    buttonCount = 2;
  }

  void play() {
    if (audio != null && sceneStart) {
      audio.play();
    }if(sceneStart){
      sceneStart = false;
      sceneStartTime = millis();
    }
    rectMode(CENTER);
    fill(255);
    textSize(width/50);
    textAlign(CENTER);
    text(instructions, width/2, height*2/3, width*3/4, height);
  }

  boolean isDone() {

    if (millis() - sceneStartTime < 2000) return false; //this is a delay to let some time between presses, largely helps with testing and maybe could be removed in production


    if (columnIndex >= 0)  return readButtons(columnIndex, buttonCount, true); 
    else {
      //this looks for button presses anywhere
      for (int i = 0; i < 4; i++) {
        boolean check = readButtons(i, 1, false);
        if (check)return true;
      } 
      return false;
    }
  }
}

//this is for the generated result screens, scenes 6-9, where the users get a prediction from their selections
class resultScene extends Scene {
  resultScene(String s, SoundFile a) {
    super(s, a);
  }
    resultScene(String s, SoundFile a, int c) {
    super(s, a, c);
  }
  
  void play(){
    super.play();
    if(columnIndex != -1){
    image(buttonImages[columnIndex][answers[columnIndex][0]], width*0.222, height*6/11, width/5, width/5);
    image(buttonImages[columnIndex][answers[columnIndex][1]], width*0.582, height*6/11, width/5, width/5);
    }
  }

  boolean isDone() {
    if (millis() - sceneStartTime > audio.duration()*1000) {
      return true;
    } else return false;
  }
}



//this is for the page that goes 'Generating user results

class generatingScene extends Scene{
    generatingScene(String s, SoundFile a) {
    super(s, a);
  }

  boolean isDone() {
    if (millis() - sceneStartTime > this.audio.duration()*1000) {
      return true;
    } else return false;
  }
}
//this is for the game play scenes where users are actually playing twister.
class gameplayScene extends Scene {
  gameplayScene(String s, SoundFile a, int c) {
    super(s, a, c);
  }

  void play() {
    //imageMode(CENTER);
    if (currentPresses[0] != -1) image(buttonImages[columnIndex][currentPresses[0]], width*0.222, height*6/11, width/5, width/5);
    if (currentPresses[1] != -1) image(buttonImages[columnIndex][currentPresses[1]], width*0.582, height*6/11, width/5, width/5);
    super.play();
  }
}


class intro extends Scene{
  PImage firstPerson;
  PImage secondPerson;
  intro(String s, SoundFile a){
    super(s,a);
    firstPerson = loadImage("images/face1.png");
    secondPerson = loadImage("images/face2.png");
  }
  void play(){
    super.play();
    image(firstPerson,width*0.222, height*6/11, width/5, width/5);
    image(secondPerson, width*0.582, height*6/11, width/5, width/5);
  }
}
