import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'constants.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() =>
      _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String displayText = '0';
  String resultText = '';

  void _evaluateExpression() {
    try {
      String expression = displayText;
      expression = expression.replaceAll('x', '*');

      Parser p = Parser();
      Expression exp = p.parse(expression);

      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      resultText = eval.toString();
    } catch (e) {
      resultText = 'error';

    }
  }

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = '';
        resultText = '';
      } else if (value == '<') {
        if (displayText.isNotEmpty) {
          displayText = displayText.substring(
            0,
            displayText.length - 1,
          );
        }
      } else if (value == '=') {
        _evaluateExpression();
      } else {
        displayText += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF414141),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Calculator',
            style: TextStyle(
              fontSize: 28.0,
              fontFamily: 'Inconsolata',
            ),
          ),
        ),
        backgroundColor: Color(0xFF414141),
      ),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            width: double.infinity,
            height: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFF5A5858),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    displayText,
                    style: TextStyle(fontSize: 50),
                  ),

                  Text(
                    resultText,
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.0,),
          Row(
            children: [
              buildCalcButton('C',(){onButtonPressed('C');},calculatorButtonStyle),
              buildCalcButton('^',(){onButtonPressed('^');},calculatorButtonStyle),
              buildCalcButton('%',(){onButtonPressed('%');},calculatorButtonStyle),
              buildCalcButton('/',(){onButtonPressed('%');},calculatorButtonStyle),
            ],
          ),

          Row(
            children: [
              buildCalcButton('7',(){onButtonPressed('7');},calculatorButtonStyle2),
              buildCalcButton('8',(){onButtonPressed('8');},calculatorButtonStyle2),
              buildCalcButton('9',(){onButtonPressed('9');},calculatorButtonStyle2),
              buildCalcButton('x',(){onButtonPressed('');},calculatorButtonStyle),
            ],
          ),

          Row(
            children: [
              buildCalcButton('6',(){onButtonPressed('6');},calculatorButtonStyle2),
              buildCalcButton('5',(){onButtonPressed('5');},calculatorButtonStyle2),
              buildCalcButton('4',(){onButtonPressed('4');},calculatorButtonStyle2),
              buildCalcButton('-',(){onButtonPressed('-');},calculatorButtonStyle),
            ],
          ),

          Row(
            children: [
              buildCalcButton('3',(){onButtonPressed('3');},calculatorButtonStyle2),
              buildCalcButton('2',(){onButtonPressed('2');},calculatorButtonStyle2),
              buildCalcButton('1',(){onButtonPressed('1');},calculatorButtonStyle2),
              buildCalcButton('+',(){onButtonPressed('+');},calculatorButtonStyle),
            ],
          ),

          Row(
            children: [
              buildCalcButton('0',(){onButtonPressed('0');},calculatorButtonStyle2),
              buildCalcButton('.',(){onButtonPressed('.');},calculatorButtonStyle2),
              buildCalcButton('=', () {_evaluateExpression();onButtonPressed('=');}, calculatorButtonStyle),
              buildCalcButton('<',(){onButtonPressed('<');},calculatorButtonStyle),
            ],
          ),
        ],
      ),
    );
  }


  Expanded buildCalcButton(String label, VoidCallback onTap,
      ButtonStyle style) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onTap,
          style: style,
          child: Text(
            label,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
