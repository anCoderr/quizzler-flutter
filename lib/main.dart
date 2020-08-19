import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzler/quiz_Brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
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
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                quizBrain.checkAnswer(true);
                setState(() {
                  if (quizBrain.endReached) {
                    onEndAlertDialogueBuilder(context);
                  }
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                quizBrain.checkAnswer(false);
                setState(() {
                  if (quizBrain.endReached) {
                    onEndAlertDialogueBuilder(context);
                  }
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: quizBrain.scoreKeeper,
        ),
      ],
    );
  }

  onEndAlertDialogueBuilder(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Quiz Over",
      desc: "You have successfully finished the quiz.",
      buttons: [
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              quizBrain.restartQuiz();
            });
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "Quit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            SystemNavigator.pop();
          },
          width: 120,
        )
      ],
    ).show();
  }
}
