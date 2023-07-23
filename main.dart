import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzy());

class TrueColor extends MaterialStateColor {
  const TrueColor() : super(_defaultColor);

  static const int _defaultColor = 0xFFFFB74D;
  static const int _pressedColor = 0xFFFFA726;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

class FalseColor extends MaterialStateColor {
  const FalseColor() : super(_defaultColor);

  static const int _defaultColor = 0xffffab91;
  static const int _pressedColor = 0xFFFF8A65;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

class Quizzy extends StatelessWidget {
  const Quizzy({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(247, 234, 204, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    String finalMessage = '';
    if (quizBrain.getGameResolution()) {
      finalMessage = 'You won!';
    } else {
      finalMessage = 'You lost!';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: TrueColor(),
                textStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.white),
                ),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  quizBrain.checkAnswer(true);
                  quizBrain.nextQuestion();
                  if (quizBrain.getGameState()) {
                    Alert(
                      context: context,
                      type: AlertType.none,
                      title: "Game Over",
                      desc: "$finalMessage",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Try Again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              quizBrain.restartGame();
                            });
                          },
                          width: 120,
                          color: Color.fromRGBO(236, 170, 61, 1),
                        )
                      ],
                    ).show();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(backgroundColor: FalseColor()),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  quizBrain.checkAnswer(false);
                  quizBrain.nextQuestion();
                  if (quizBrain.getGameState()) {
                    Alert(
                      context: context,
                      type: AlertType.none,
                      title: "Game Over",
                      desc: "$finalMessage",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Try Again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          color: Color.fromRGBO(236, 170, 61, 1),
                        )
                      ],
                    ).show();
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: quizBrain.scoreKeeper,
        )
      ],
    );
  }
}
