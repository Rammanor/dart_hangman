import 'dart:html';
import 'hangman_game.dart';

const List<String> imageList = const [
  "https://i.imgur.com/kReMv94.png",
  "https://i.imgur.com/UFP8RM4.png",
  "https://i.imgur.com/9McnEXg.png",
  "https://i.imgur.com/vNAW0pa.png",
  "https://i.imgur.com/8UFWc9q.png",
  "https://i.imgur.com/rHCgIvU.png",
  "https://i.imgur.com/CtvIEMS.png",
  "https://i.imgur.com/Z2mPdX0.png"
];

const String winImage = "https://i.imgur.com/QYKuNwB.png";

final ImageElement gallowsRef = querySelector("#gallows");
final DivElement wordRef = querySelector("#word");  
final DivElement lettersRef = querySelector("#letters");  
final ButtonElement newGameRef = querySelector("#new-game");

void updateWordDisplay(String word) {  
  wordRef.text = word;
}

void updateGallowsImage(int wrongGuesses) {  
  gallowsRef.src = imageList[wrongGuesses];
}

void enableLetterButtons([bool enable = true]) {  
  // enable/disable all letter buttons
  lettersRef.children.forEach((Element btn) =>
    (btn as ButtonElement).disabled = !enable);
}

setWinImage() {
  gallowsRef.src = winImage;
}

List<String> generateAlphabet() {  
  // get the character code for a capital 'A'
  int startingCharCode = 'A'.codeUnits.first;

  // create a list of 26 character codes (from 'A' to 'Z')
  List<int> charCodes = new List<int>.generate(26, (int index) =>
    startingCharCode + index);

  // map character codes into a list of actual strings
  return charCodes.map((int code) =>
    new String.fromCharCode(code)).toList();
}

void createLetterButtons(HangmanGame game) {  
  // add letter buttons to the DOM
  generateAlphabet().forEach((String letter) {
    lettersRef.append(new ButtonElement()
      ..classes.add("letter-btn")
      ..text = letter
      ..onClick.listen((MouseEvent event) {
        (event.target as ButtonElement).disabled = true;
        game.guessLetter(letter);
      })
    );
  });
}