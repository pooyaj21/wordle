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
String vKeyBoardS[] = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"};
char vKeyBoardC[] = {'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M'};
String outputv [] =new String[26];





final int MAX_TURN = 5;
String answer ;
int turn =0;

void setup() {
  size(700, 900);
  background(18, 18, 19, 255);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("Wordle", width/2, height/24);
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
  virtualKeyBoard();
}


void rectDraw() {
  for (int i = 1; i < (wordSize+1); i++) {
    for (int j = 1; j < (wordSize+1); j++) {
      strokeWeight(1);
      noFill();
      rect((width/(wordSize+2)) * i, (((height/8)*6.5)/(wordSize+2)) * j, width/grid, width/grid, 15);
    }
  }
}

void keyTyped() {
  if (key >= 'a' && key <= 'z'&& y<5) {

    input2[y] =Character.toString(key);
    fill(18, 18, 19, 255);
    rect((width/(wordSize+2)) * (y+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text(input2 [y].toUpperCase(), (width/grid) * (y+1) + width/grid/2, (((height/8)*6.5)/grid) * (x+1)   + width/grid/2);
    if (y<5) {
      y++;
    }
  }

  if (key >= 'A' && key <= 'Z'&& y<5) {
    input2[y] =Character.toString(key);
    fill(18, 18, 19, 255);
    rect((width/(wordSize+2)) * (y+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);

    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text(input2 [y], (width/grid) * (y+1) + width/grid/2, (((height/8)*6.5)/grid) * (x+1)   + width/grid/2);

    if (y<5) {
      y++;
    }
  }
}

void keyPressed() {
  if ( keyPressed && key == ENTER && y==5) {
    logic();
    virtualKeyBoardchanges();

    y=0;
    if (x<4)x++;
    println(outputv);
  }

  if ( keyPressed && key == BACKSPACE && y>0) {
    y--;
    fill(18, 18, 19, 255);
    rect((width/(wordSize+2)) * (y+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);
  }
}

void mousePressed() {
  float xStart = (width - ((width / 4) * 2.3)) / 2;
  int yStart = height - ((height / 8) * 2);
  for (int i = 0; i < 26; i++) {
    // calculate the x and y coordinates of the current key
    int j;
    float k;
    if (i <= 9) { // first row
      j = 1;
      k = i;
    } else if (i <= 18) { // second row
      j = 2;
      k = i - 9.5;
    } else { // third row
      j = 3;
      k = i - 17.5;
    }
    float keyX = xStart + (((width / 4) * 2 / 9) * k);
    float keyY = yStart + (((height / 8) * 3 / 9) * j);

    if (mouseX > keyX && mouseX < keyX + 35 && mouseY > keyY && mouseY < keyY + 30 && y<5) {
      input2[y] =vKeyBoardS[i];
      fill(18, 18, 19, 255);
      rect((width/(wordSize+2)) * (y+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);

      textAlign(CENTER, CENTER);
      textSize(50);
      fill(255);
      text(input2 [y], (width/grid) * (y+1) + width/grid/2, (((height/8)*6.5)/grid) * (x+1)   + width/grid/2);

      if (y<5) {
        y++;
      }
    }
  }
  if (mouseX> xStart + (((width / 4) * 2 / 9) * -0.5) && mouseX< xStart + (((width / 4) * 2 / 9) * -0.5)+70 && mouseY>yStart + (((height / 8) * 2.8 / 9) * 3) + 30/2 + 2 && mouseY<yStart + (((height / 8) * 2.8 / 9) * 3) + 30/2 + 32 && y==5) {
    logic();
    virtualKeyBoardchanges();

    y=0;
    if (x<4)x++;
  }

  if (mouseX> xStart + (((width / 4) * 2 / 9) * 8.5) && mouseX< xStart + (((width / 4) * 2 / 9) * 8.5)+70 && mouseY>yStart + (((height / 8) * 3 / 9) * 3) && mouseY<yStart + (((height / 8) * 3 / 9) * 3) + 32&& y>0) {
    y--;
    fill(18, 18, 19, 255);
    rect((width/(wordSize+2)) * (y+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);
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


void virtualKeyBoard() {
  float xStart = (width - ((width / 4) * 2.3)) / 2;
  int yStart = height - ((height / 8) * 2);
  for (int i = 0; i < 26; i++) {
    int j;
    float k;
    if (i <= 9) { // first row
      j = 1;
      k = i;
    } else if (i <= 18) { // second row
      j = 2;
      k = i - 9.5;
    } else { // third row
      j = 3;
      k = i - 17.5;
    }
    noFill();
    rect(xStart + (((width / 4) * 2 / 9) * k), yStart + (((height / 8) * 3 / 9) * j), 35, 30, 15);
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(255);
    text(vKeyBoardS[i], xStart + (((width / 4) * 2 / 9) * k) + 35/2, yStart + (((height / 8) * 2.8 / 9) * j) + 30/2 + 2);
  }

  noFill();
  rect(xStart + (((width / 4) * 2 / 9) * -0.5), yStart + (((height / 8) * 3 / 9) * 3), 73, 30, 15);
  textAlign(CENTER, CENTER);
  textSize(18);
  fill(255);
  text("Enter", xStart + (((width / 4) * 2 / 9) * -0.5) + 70/2, yStart + (((height / 8) * 2.8 / 9) * 3) + 30/2 + 2);

  noFill();
  rect(xStart + (((width / 4) * 2 / 9) * 8.5), yStart + (((height / 8) * 3 / 9) * 3), 73, 30, 15);
  textAlign(CENTER, CENTER);
  textSize(18);
  fill(255);
  text("Back", xStart + (((width / 4) * 2 / 9) * 8.5) + 70/2, yStart + (((height / 8) * 2.8 / 9) * 3) + 30/2 + 2);
}


void virtualKeyBoardchanges() {

  float xStart = (width - ((width / 4) * 2.3)) / 2;
  int yStart = height - ((height / 8) * 2);
  for (int i = 0; i < 26; i++) {
    int j;
    float k;
    if (i <= 9) { // first row
      j = 1;
      k = i;
    } else if (i <= 18) { // second row
      j = 2;
      k = i - 9.5;
    } else { // third row
      j = 3;
      k = i - 17.5;
    }

    if (outputv[i]=="F") {
      fill(58, 58, 60, 255);
      rect(xStart + (((width / 4) * 2 / 9) * k), yStart + (((height / 8) * 3 / 9) * j), 35, 30, 15);
      textAlign(CENTER, CENTER);
      textSize(20);
      fill(255);
      text(vKeyBoardS[i], xStart + (((width / 4) * 2 / 9) * k) + 35/2, yStart + (((height / 8) * 2.8 / 9) * j) + 30/2 + 2);
    }

    if (outputv[i]=="W") {
      fill(181, 159, 59, 255);
      rect(xStart + (((width / 4) * 2 / 9) * k), yStart + (((height / 8) * 3 / 9) * j), 35, 30, 15);
      textAlign(CENTER, CENTER);
      textSize(20);
      fill(255);
      text(vKeyBoardS[i], xStart + (((width / 4) * 2 / 9) * k) + 35/2, yStart + (((height / 8) * 2.8 / 9) * j) + 30/2 + 2);
    }

    if (outputv[i]=="T") {
      fill(83, 141, 78, 255);
      rect(xStart + (((width / 4) * 2 / 9) * k), yStart + (((height / 8) * 3 / 9) * j), 35, 30, 15);
      textAlign(CENTER, CENTER);
      textSize(20);
      fill(255);
      text(vKeyBoardS[i], xStart + (((width / 4) * 2 / 9) * k) + 35/2, yStart + (((height / 8) * 2.8 / 9) * j) + 30/2 + 2);
    }
  }
}




String numberSelector(String[] words) {
  Random random = new Random();
  int luckyNumber = random.nextInt(words.length);
  String correctAnswer = words[luckyNumber];
  return correctAnswer;
}

char[] answerChecker(String input3, String answer, char[] output) {
  int[] alphabet = new int[26];
  String input = input3.toLowerCase();
  for (int f = 0; f < answer.length(); f++) {
    int ascii = answer.charAt(f);
    alphabet[(ascii - 97)]++; //for how many of how many char we have
  }

  for (int i = 0; i < answer.length(); i++) {
    if (input.charAt(i) == answer.charAt(i)) {

  
      fill(83, 141, 78, 255);
      rect((width/(wordSize+2)) * (i+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);
      textAlign(CENTER, CENTER);
      textSize(50);
      fill(255);
      text(input2[i].toUpperCase(), (width/grid) * (i+1) + width/grid/2, (((height/8)*6.5)/grid) * (x+1)   + width/grid/2);

      output[i] = 't';

   


      alphabet[(input.charAt(i) - 97)]--;
            
  for (int g = 0; g < 26; g++) {
        if (vKeyBoardC[g] == input.charAt(i)) {
          outputv[g]="T";
        }
       }
       
       
    } else {
      output[i] = 'f';

      fill(58, 58, 60, 255);
      rect((width/(wordSize+2)) * (i+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);
      textAlign(CENTER, CENTER);
      textSize(50);
      fill(255);
      text(input2[i].toUpperCase(), (width/grid) * (i+1) + width/grid/2, (((height/8)*6.5)/grid) * (x+1)   + width/grid/2);
    }
    for (int h = 0; h < 26; h++) {
      if (vKeyBoardS[h]==input2[i].toUpperCase()) {
        outputv[h]="F";
      }
    }
  }


  for (int j = 0; j < 26; j++) {
    if (alphabet[j] > 0) {
      for (int k = 0; k < answer.length(); k++) {
        if (alphabet[j] > 0 && (char) (j + 97) == input.charAt(k)) {
          fill(181, 159, 59, 255);
          rect((width/(wordSize+2)) * (k+1), (((height/8)*6.5)/(wordSize+2)) * (x+1), width/grid, width/grid, 15);
          textAlign(CENTER, CENTER);
          textSize(50);
          fill(255);
          text(input2[k].toUpperCase(), (width/grid) * (k+1) + width/grid/2, (((height/8)*6.5)/grid) * (x+1)   + width/grid/2);
          output[k] = '!';
          for (int i = 0; i < 26; i++) {
            if (vKeyBoardS[i] == input2[k].toUpperCase()) {
              outputv[i]="W";
            }
          }

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
