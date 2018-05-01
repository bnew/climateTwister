import processing.sound.*; //<>//

Scene[] scenes;
Scene scene;
int currentScene = 0;
int sceneCount = 11;
int gameplayStart = 1; //the index for the first scene that is the actual game
int gameplayEnd = 4;


void setup() {
  //size(displayWidth, displayHeight);

  fullScreen();
  scenes = new Scene[sceneCount];
  loadData();
  initializeArduino();
  setUpGame();
  scene = scenes[currentScene]; 
  answers = new int[4][2];
  currentPresses = new int[2];
}

//add all of the scenes we know about to the array when the game starts
//everything is re-instantiated at game start
void setUpGame() {
  scenes[0] = new intro("Hello and welcome to climate twister. Come play and get your fortune told.\nPress any button to begin.\n\n\n\nThis is a two player game.", new SoundFile(this, "start.mp3") );
  scenes[1] = pickFrom(food, foodVO, 0);
  scenes[2] = pickFrom(fun, funVO, 1);
  scenes[3] = pickFrom(job, jobVO, 2);
  scenes[4] = pickFrom(commute, commuteVO, 3);
  scenes[5] = new generatingScene("You survived, good job. Feel free to get up now.\nPlease wait while we process your selections and generate a prediction for the year 2100...", new SoundFile(this, "generatingResults.mp3"));
}

Scene pickFrom(String[] scenario, SoundFile[] vo, int column) {
  int choice = (int)random(scenario.length);
  return new gameplayScene(scenario[choice], vo[choice], column);
}

void draw() {
  //if we are starting a new scene, delay a bit so we can see our answers on screen and have time between rounds
  if (scene.sceneStart)delay(3000); 
  
  background(35,25,22);
  scene.play();
  if (scene.isDone())
  {
    scene.play(); //hack to show the second button press, since it is read in the isDone function 
    advanceScene();
  }
}

void advanceScene() {
  //the current presses array manages which button selections we show as feedback for the users
  //it resets each advance to ensure things don't linger
  currentPresses[0] = -1;
  currentPresses[1] = -1;
  
  if (currentScene >= gameplayStart && currentScene <= gameplayEnd) {
    int answerIndex = currentScene-gameplayStart;

    //insert the result scene in based on the users answers 
    //this annoying switch statement determines which results array we pull from.
    switch(currentScene)
    {
      //each of these inserts a scene @ currentScene + 5 because 5 scenes later, the corresponding outcome will show
      
    case 1: //foodPosition in scenes
      scenes[currentScene+5] = getResult(foodResults, foodResultsVO, answerIndex);
      break;
    case 2: //fun position in scenes
      scenes[currentScene+5] = getResult(funResults, funResultsVO, answerIndex);
      break;
    case 3: //job
      scenes[currentScene+5] = getResult(jobResults, jobResultsVO, answerIndex);
      break;
    case 4://commute
      scenes[currentScene+5] = getResult(commuteResults, commuteResultsVO, answerIndex);
      
      //now that we have all of our results, generate the final screen.
      String[] txt = {"Thank you for playing. Here is your prediction for the year 2100\n",scenes[6].instructions, scenes[7].instructions, scenes[8].instructions, scenes[9].instructions};
      String fullText = join(txt,"\n\n");
      scenes[10] = new Scene(fullText, new SoundFile(this, "restart.mp3")); 
      break;
    }
  }

  currentScene++;
  //reset our button states at the end to try and fix some shit. Not sure its necessary but ill leave it
  if(currentScene == 10){
    for(int i = 0; i<4; i++){
    buttons[i].resetStates();
    }
  }
  
  //reset game
  if (currentScene >= sceneCount) {
    currentScene = 0;
    setUpGame();
  }

  //update our scene pointer
  scene = scenes[currentScene];
  println("current scene is " + currentScene);
}
