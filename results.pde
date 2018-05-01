//this file handles all loading of the generated 'results' from the users selections //<>// //<>//

String[][] foodResults;
SoundFile[][] foodResultsVO;

String[][] funResults;
SoundFile[][] funResultsVO;

String[][] jobResults;
SoundFile[][] jobResultsVO;

String[][] commuteResults;
SoundFile[][] commuteResultsVO;

void loadResults() {
  foodResults = new String[10][10];
  foodResultsVO = new SoundFile[10][10];
  Table f = loadTable("foodResults.csv", "header");
  //to get the results in the proper format, pass the data table, plus the arrays for strings + audio
  parseResults(f, foodResults, foodResultsVO); 


  funResults = new String[10][10];
  funResultsVO = new SoundFile[10][10];
  Table e = loadTable("funResults.csv", "header");
  parseResults(e, funResults, funResultsVO);

  jobResults = new String[10][10];
  jobResultsVO = new SoundFile[10][10];
  Table j = loadTable("jobResults.csv", "header");
  parseResults(j, jobResults, jobResultsVO);

  commuteResults = new String[10][10];
  commuteResultsVO = new SoundFile[10][10];
  Table c = loadTable("commuteResults.csv", "header");
  parseResults(c, commuteResults, commuteResultsVO);
}

//pick the right 'result' given the proper category
resultScene getResult(String[][] results, SoundFile[][] vo, int answerIndex) {
  return new resultScene(results[answers[answerIndex][0]][answers[answerIndex][1]], vo[answers[answerIndex][0]][answers[answerIndex][1]], answerIndex);
}


//takes the results tables and makes a diagonal data set of answer combinations
//it assumes that the first answer is in  the first column, and the second answer is the second
//and the table is always sorted low button index to high button index
void parseResults(Table t, String[][] text, SoundFile[][] vo) {
  for (int r=0; r <10; r++) {
    int first = t.getInt(r, 0);
    int second = t.getInt(r, 1);
    text[first][second] = t.getString(r, 2);
    String filename = t.getString(r, 3);
    vo[first][second] = new SoundFile(this, trim(filename));
  }
}
