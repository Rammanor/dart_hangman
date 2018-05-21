import 'dart:html';

import 'package:english_words/english_words.dart' as EnglishWords;

import 'package:hangman/hangman_game.dart';
import 'package:hangman/ui.dart' as UI;

HangmanGame game = new HangmanGame(EnglishWords.all, UI.imageList.length - 1);

void main() {
  // set up event listeners
  game.onChange.listen(UI.updateWordDisplay);
  game.onWrong.listen(UI.updateGallowsImage);
  game.onWin.listen(win);
  game.onLose.listen(gameOver);

  UI.newGameRef.onClick.listen(newGame);

  // put the letter buttons on the screen
  UI.createLetterButtons(game);

  // start the first game
  newGame();
}

void gameOver([_]) {  
  UI.enableLetterButtons(false);
  UI.newGameRef.hidden = false;
}

void win([_]) {  
  UI.setWinImage();
  gameOver();
}

void newGame([_]) {  
  // set up the game model
  game.newGame();

  // reset the letter buttons
  UI.enableLetterButtons();

  // hide the New Game button
  UI.newGameRef.hidden = true;

  // show the first gallows image
  UI.updateGallowsImage(0);
}


