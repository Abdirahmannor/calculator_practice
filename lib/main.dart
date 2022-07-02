// ignore_for_file: prefer_const_constructors

import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

import 'package:calculator_practice/bottons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userQuestion = '';
  var userAnswers = '';
  final List<dynamic> buttons = [
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
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff051923),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            userQuestion,
                            style: TextStyle(
                                color: Color(
                                  0xfffefae0,
                                ),
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            userAnswers,
                            style: TextStyle(
                                color: Color(
                                  0xfffefae0,
                                ),
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, index) {
                        if (buttons[index] == 'C') {
                          return MyButtons(
                            buttonText: buttons[index],
                            coolor: Colors.green,
                            textColor: Colors.white,
                            clicked: () {
                              setState(() {
                                userQuestion = '';
                              });
                            },
                          );
                        } else if (buttons[index] == 'DEL') {
                          return MyButtons(
                            buttonText: buttons[index],
                            coolor: Colors.red,
                            textColor: Colors.white,
                            clicked: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                          );
                        }

                        // Equal Button
                        else if (buttons[index] == '=') {
                          return MyButtons(
                            buttonText: buttons[index],
                            coolor: Color(0xff457b9d),
                            textColor: Colors.white,
                            clicked: () {
                              setState(() {
                                equalpressed();
                              });
                            },
                          );
                        } else {
                          return MyButtons(
                              clicked: () {
                                setState(() {
                                  userQuestion += buttons[index].toString();
                                });
                              },
                              buttonText: buttons[index],
                              coolor: Isoperator(buttons[index]) == true
                                  ? Color(0xff3b6064)
                                  : Color(0xff3c5233),
                              textColor: Isoperator(buttons[index]) == true
                                  ? Color(0xfff8f7ff)
                                  : Color.fromARGB(255, 39, 20, 163));
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool Isoperator(x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  equalpressed() {
    var finalanswer = userQuestion;
    finalanswer = finalanswer.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalanswer);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswers = eval.toString();
  }
}
