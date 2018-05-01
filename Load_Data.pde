String[] food;
SoundFile[] foodVO;

String[] commute;
SoundFile[] commuteVO;

String[] fun;
SoundFile[] funVO;

String[] job;
SoundFile[] jobVO;

SoundFile blip;

PImage[][] buttonImages;

void loadData() {
  Table f = loadTable("food.csv", "header");
  food = csvStringsToArray(f);
  foodVO = csvSoundFilesToArray(f);

  Table e = loadTable("fun.csv", "header");
  fun = csvStringsToArray(e);
  funVO = csvSoundFilesToArray(e);

  Table c = loadTable("commute.csv", "header");
  commute = csvStringsToArray(c);
  commuteVO = csvSoundFilesToArray(c);

  Table j = loadTable("job.csv", "header");
  job = csvStringsToArray(j);
  jobVO = csvSoundFilesToArray(j);  
  
  blip = new SoundFile(this, "blip.wav");

  loadResults();

  //load images for our buttons
  loadButtonImages();
}

String[] csvStringsToArray(Table t) {
  int rowCount = t.getRowCount();
  String[] output = new String[rowCount];
  for (int i = 0; i < rowCount; i++) {
    output[i] = t.getString(i, 0); //get the row's first column (the text);
    ////add new lines to make formatting nicer
    //String[] s = splitTokens(t.getString(i, 0), ". "); 
    //output[i] = join(s, "\n");
  }

  return output;
}

SoundFile[] csvSoundFilesToArray(Table t) {
  int rowCount = t.getRowCount();
  println(rowCount);
  SoundFile[] output = new SoundFile[rowCount];
  for (int i = 0; i < rowCount; i++) {
    String filename = t.getString(i, 1); //get the row's second column (the audio file path); 

    output[i] = new SoundFile(this, trim(filename));
  }

  return output;
}


void loadButtonImages() {
  //reference https://docs.google.com/spreadsheets/d/14cAZlkmrMGYc6YPOJknBkTSdG5hcPCquqia1o2lCFK0/edit#gid=1269240244
  
  buttonImages = new PImage[4][5];
  buttonImages[0][0] = loadImage("images/F1.png");
  buttonImages[0][1] = loadImage("images/F2.png");
  buttonImages[0][2] = loadImage("images/F3.png");
  buttonImages[0][3] = loadImage("images/F4.png");
  buttonImages[0][4] = loadImage("images/F5.png");

  buttonImages[1][0] = loadImage("images/E1.png");
  buttonImages[1][1] = loadImage("images/E2.png");
  buttonImages[1][2] = loadImage("images/E3.png");
  buttonImages[1][3] = loadImage("images/E4.png");
  buttonImages[1][4] = loadImage("images/E5.png");

  buttonImages[2][0] = loadImage("images/J1.png");
  buttonImages[2][1] = loadImage("images/J2.png");
  buttonImages[2][2] = loadImage("images/J3.png");
  buttonImages[2][3] = loadImage("images/J4.png");
  buttonImages[2][4] = loadImage("images/J5.png");

  buttonImages[3][0] = loadImage("images/C1.png");
  buttonImages[3][1] = loadImage("images/C2.png");
  buttonImages[3][2] = loadImage("images/C3.png");
  buttonImages[3][3] = loadImage("images/C4.png");
  buttonImages[3][4] = loadImage("images/C5.png");
}
