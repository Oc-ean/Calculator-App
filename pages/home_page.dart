import 'package:flutter/material.dart';
import 'package:free_ui/cal_buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var userQuestion = '';
var userAnswer = '';

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'C',
    'DEl',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'Ans',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    // clear button

                    return CalButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {});
                        userQuestion = '';
                        userAnswer = '';
                      },
                    );
                  } else if (index == 1) {
                    // delete button
                    return CalButton(
                      buttonTapped: () {
                        setState(() {});
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  } else if (index == buttons.length - 1) {
                    return CalButton(
                      buttonTapped: () {
                        setState(() {});
                        equalPressed();
                      },
                      color: Colors.orange[300],
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  } else {
                    return CalButton(
                        buttonTapped: () {
                          setState(() {});
                          userQuestion += buttons[index];
                        },
                        color: isOperator(buttons[index])
                            ? Colors.orange[300]
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                        buttonText: buttons[index]);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String inputQuestion = userQuestion;
    inputQuestion = inputQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(inputQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
