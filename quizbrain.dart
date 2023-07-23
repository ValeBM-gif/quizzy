//import 'dart:html';

import 'question.dart';
import 'package:flutter/material.dart';

class QuizBrain {
  bool _gameResolution = true;
  int _questionNumber = 0;
  bool _gameOver = false;
  List<Icon> scoreKeeper = [];
  final List<Question> _questionBank = [
    Question('Sharks are mammals.', false),
    Question(
        'Sea otters have a favorite rock they use to break open food.', true),
    Question('The blue whale is the biggest animal to have ever lived.', true),
    Question('The hummingbird egg is the world\'s smallest bird egg.', true),
    Question(
        'Pigs roll in the mud because they don’t like being clean.', false),
    Question('Bats are blind.', false),
    Question('A dog sweats by panting its tongue.', false),
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
  ];

  checkAnswer(bool answerGiven) {
    if (getQuestionAnswer() == answerGiven) {
      printIcon(true);
    } else {
      _gameResolution = false;
      printIcon(false);
    }
  }

  void printIcon(bool isItCorrect) {
    if (_gameOver) {
    } else {
      if (isItCorrect == true) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    }
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    } else {
      _gameOver = true;
    }
  }

  void restartGame() {
    scoreKeeper.clear();
    _gameResolution = true;
    _questionNumber = 0;
    _gameOver = false;
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool getGameState() {
    return _gameOver;
  }

  bool getGameResolution() {
    return _gameResolution;
  }
}
