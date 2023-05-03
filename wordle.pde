import java.io.File;
import java.io.FileNotFoundException;
import java.util.Arrays;
import java.util.Locale;
import java.util.Random;
import java.util.Scanner;
BufferedReader reader;
int wordSize=5;
int gridSize = width/(wordSize+2);
int grid = wordSize+2;
String[][] input= new String[5][5];
String[] input2= new String[5];
int x =0;
int y =0;
String[] words = new String[14855];


final int MAX_TURN = 5;
String answer ;
int turn =0;

void setup() {
  size(900, 900);
  reader = createReader("words.txt");
  String line = null;
  try {
    int i = 0;
    while ((line = reader.readLine()) != null) {
      words[i++] = line;
    }
  }
  catch (IOException e) {
    e.printStackTrace();
  }


  answer = numberSelector(words); //generate a word


  System.out.println(answer); //test
}

void draw() {
  rectDraw();
}


void rectDraw() {
  for (int i = 1; i < (wordSize+1); i++) {
    for (int j = 1; j < (wordSize+1); j++) {
      strokeWeight(1);
      noFill();
      rect((width/(wordSize+2)) * i, (height/(wordSize+2)) * j, height/grid, width/grid, 15);
    }
  }
}

void keyTyped() {
  if (key >= 'a' && key <= 'z'&& y<5) {
    
    input2[y] =Character.toString(key);
    fill(255);
    rect((width/(wordSize+2)) * (y+1), (height/(wordSize+2)) * (x+1), height/grid, width/grid, 15);
    textAlign(CENTER, CENTER);
    fill(0);
    text(input2 [y], (width/grid) * (y+1) + width/grid/2, (height/grid) * (x+1)   + height/grid/2);

    if (y<5) {
      y++;
    }
  }

  //if (key >= 'A' && key <= 'Z') {
  //  input[x][y] = Character.toString(key);
  //  fill(255);
  //  rect((width/7) * (y+1), (height/7) * (x+1), height/grid, width/grid, 15);
  //  textAlign(CENTER, CENTER);
  //  fill(0);
  //  text(input[x][y], (width/grid) * (y+1) + width/grid/2, (height/grid) * (x+1)   + height/grid/2);

  //  if (y<4) {
  //    y++;
  //  }
  //}
}

void keyPressed() {
  if ( keyPressed && key == ENTER & y==5) {
    logic();
    y=0;
    x++;
  }

  if ( keyPressed && key == BACKSPACE && y>0) {
    y--;
    fill(255);
    rect((width/(wordSize+2)) * (y+1), (height/(wordSize+2)) * (x+1), height/grid, width/grid, 15);
  }
}

void logic() {


  if (turn<MAX_TURN) {
    char[] output = new char[answer.length()];
    String userInput = "";

    for (int k = 0; k<5; k++) {
      userInput += input2[k];
    }

    //if (checkInputValidation(userInput, answer, words)) {
    //  j--;
    //  continue;
    //}
    answerChecker(userInput, answer, output);

    if (userInput.equals(answer)) {
      System.out.println("You nailed it!");
      //exit();
    }

    if (turn==(MAX_TURN -1))System.out.println("you are a loser!");
  }
  turn++;
}




String numberSelector(String[] words) {
  Random random = new Random();
  int luckyNumber = random.nextInt(words.length);
  String correctAnswer = words[luckyNumber];
  return correctAnswer;
}

char[] answerChecker(String input, String answer, char[] output) {
  int[] alphabet = new int[26];

  for (int f = 0; f < answer.length(); f++) {
    int ascii = answer.charAt(f);
    alphabet[(ascii - 97)]++; //for how many of how many char we have
  }

  for (int i = 0; i < answer.length(); i++) {
    if (input.charAt(i) == answer.charAt(i)) {

      fill(0, 255, 0);
      rect((width/(wordSize+2)) * (i+1), (height/(wordSize+2)) * (x+1), height/grid, width/grid, 15);
      textAlign(CENTER, CENTER);
      fill(0);
      text(input2[i], (width/grid) * (i+1) + width/grid/2, (height/grid) * (x+1)   + height/grid/2);

      output[i] = 't';
      alphabet[(input.charAt(i) - 97)]--;
    } else {
      output[i] = 'f';
      fill(255, 0, 0);
      rect((width/(wordSize+2)) * (i+1), (height/(wordSize+2)) * (x+1), height/grid, width/grid, 15);
      textAlign(CENTER, CENTER);
      fill(0);
      text(input2[i], (width/grid) * (i+1) + width/grid/2, (height/grid) * (x+1)   + height/grid/2);
    }
  }


  for (int j = 0; j < 26; j++) {
    if (alphabet[j] > 0) {
      for (int k = 0; k < answer.length(); k++) {
        if (alphabet[j] > 0 && (char) (j + 97) == input.charAt(k)) {
          fill(255, 255, 0);
          rect((width/(wordSize+2)) * (k+1), (height/(wordSize+2)) * (x+1), height/grid, width/grid, 15);
          textAlign(CENTER, CENTER);
          fill(0);
          text(input2[k], (width/grid) * (k+1) + width/grid/2, (height/grid) * (x+1)   + height/grid/2);
          output[k] = '!';
          alphabet[(input.charAt(k) - 97)]--;
        }
      }
    }
  }
  System.out.println(printAnswer(output));
  return output;
}

// method to validate the user's input and return true if it is valid or not
boolean checkInputValidation(String input, String answer, String[] words) {
  boolean invalidNumber = true;
  boolean invalidDigit = true;
  if (!(isAtoZ(input)) || !(isWord(input, words))) {
    x =0;
    y =0;
    System.err.println("Invalid input. Please enter a valid word!");
    noLoop();
    return invalidNumber;
  } else if (!(input.length() == answer.length())) {
    System.err.printf("Invalid input. Please enter a valid %d-letter word!\n", answer.length());
    return invalidDigit;
  } else {
    return !invalidNumber;
  }
}

boolean isAtoZ(String input) {
  boolean atoz = true;
  for (int i = 0; i < input.length(); i++) {
    if (input.isEmpty() || !(input.charAt(i) > 96 && input.charAt(i) < 123)) {
      atoz = false;
      break;
    }
  }
  return atoz;
}

String printAnswer (char[] output) {
  String print ="";
  for (int i = 0; i < output.length; i++) {
    print += output[i];
  }
  return print;
}
boolean isWord(String input, String[] words) {
  boolean isWords = false;
  for (int i = 0; i < words.length; i++) {
    if (words[i].equals(input)) {
      isWords = true;
    }
  }
  return isWords;
}
