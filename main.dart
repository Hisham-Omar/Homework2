import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  double firstNum = 0;
  double secondNum = 0;
  String result = '';
  String operator = '';
  String previousOperator = '';

  void onNumberClick(String value) {
    setState(() {
      if (result != '' && operator == '') {
        displayText = value;
        result = '';
      } else {
        displayText += value;
      }
    });
  }

  void onOperatorClick(String op) {
    setState(() {
      if (operator.isEmpty) {
        firstNum = double.parse(displayText);
      } else {
        secondNum = double.parse(displayText);
        calculateResult();
      }
      operator = op;
      displayText = '';
    });
  }

  void calculateResult() {
    switch (operator) {
      case '+':
        result = (firstNum + secondNum).toString();
        break;
      case '-':
        result = (firstNum - secondNum).toString();
        break;
      case '*':
        result = (firstNum * secondNum).toString();
        break;
      case '/':
        result = secondNum == 0
            ? 'Error'
            : (firstNum / secondNum).toStringAsFixed(2);
        break;
    }
    firstNum = double.parse(result);
  }

  void onClearClick() {
    setState(() {
      displayText = '0';
      firstNum = 0;
      secondNum = 0;
      result = '';
      operator = '';
      previousOperator = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display Area
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              displayText,
              style: TextStyle(color: Colors.white, fontSize: 48),
            ),
          ),
          // Button Rows
          buildButtonRow(['7', '8', '9', '/']),
          buildButtonRow(['4', '5', '6', '*']),
          buildButtonRow(['1', '2', '3', '-']),
          buildButtonRow(['0', 'C', '=', '+']),
        ],
      ),
    );
  }

  // Helper function to build a row of buttons
  Widget buildButtonRow(List<String> buttonTexts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonTexts.map((text) {
        return InkWell(
          onTap: () {
            if (text == 'C') {
              onClearClick();
            } else if (text == '=') {
              setState(() {
                secondNum = double.parse(displayText);
                calculateResult();
                operator = '';
                displayText = result;
              });
            } else if ('+-*/'.contains(text)) {
              onOperatorClick(text);
            } else {
              onNumberClick(text);
            }
          },
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              shape: BoxShape.circle,
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        );
      }).toList(),
    );
  }
}
