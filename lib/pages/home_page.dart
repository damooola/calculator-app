import 'package:calculatorx/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  bool isOperator(String button) {
    return button == '%' ||
            button == '/' ||
            button == '*' ||
            button == '-' ||
            button == '+' ||
            button == '='
        ? true
        : false;
  }

  buttonTapped(int index) {
    setState(() {
      userQuestion += buttons[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return MyButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      onTap: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      });
                } else if (index == 1) {
                  return MyButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                    onTap: () => setState(() {
                      userQuestion =
                          userQuestion.substring(0, userQuestion.length - 1);
                    }),
                  );
                } else if (index == buttons.length - 1) {
                  return MyButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                    onTap: () => setState(() {
                      equalSignPressed();
                    }),
                  );
                } else if (index == buttons.length - 2) {
                  return MyButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                    onTap: () => setState(() {
                      ansPreseed();
                    }),
                  );
                } else {
                  return MyButton(
                    color:
                        isOperator(buttons[index]) ? Colors.black : Colors.grey,
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.black,
                    buttonText: buttons[index],
                    onTap: () => buttonTapped(index),
                  );
                }
              },
            )),
          )
        ],
      ),
    );
  }

  void equalSignPressed() {
    String getUserQuestion = userQuestion;

    //in case x was used instead of asterisk * for multiplication
    // userQuestionGet = userQuestionGet.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(getUserQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }

  void ansPreseed() {
    userQuestion = userAnswer;
  }
}
