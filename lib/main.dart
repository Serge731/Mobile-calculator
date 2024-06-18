// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String operator = '';
  bool isNewCalculation = true;

  void calculation(String btnText) {
    if (btnText == 'AC') {
      resetCalculator();
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      handleOperator(btnText);
    } else if (btnText == '%') {
      handlePercentage();
    } else if (btnText == '.') {
      handleDecimal();
    } else if (btnText == '+/-') {
      handleNegation();
    } else {
      handleNumberInput(btnText);
    }

    setState(() {
      displayText = result;
    });
  }

  void resetCalculator() {
    displayText = '0';
    numOne = 0;
    numTwo = 0;
    result = '0';
    operator = '';
    isNewCalculation = true;
  }

  void handleOperator(String btnText) {

    if (operator.isNotEmpty && btnText != '=') {
      calculateResult();
    } else if (btnText == '=') {
      calculateResult();
      operator = '';
    } else {
      numOne = double.parse(result);
    }
    operator = btnText;
    result = result;
    isNewCalculation = true;
  }

  void handlePercentage() {
    result = (double.parse(result) / 100).toString();
    numOne = double.parse(result);
    operator = '';
  }

  void handleDecimal() {
    if (!result.contains('.')) {
      result += '.';
    }
  }

  void handleNegation() {
    if (result.startsWith('-')) {
      result = result.substring(1);
    } else {
      result = '-' + result;
    }
  }

  void handleNumberInput(String btnText) {
    if (isNewCalculation) {
      result = btnText;
      isNewCalculation = false;
    } else {
      result +=btnText;
    }
  }

  void calculateResult() {
    numTwo = double.parse(result);
    switch (operator) {
      case '+':
        result = (numOne + numTwo).toString();
        break;
      case '-':
        result = (numOne - numTwo).toString();
        break;
      case 'x':
        result = (numOne * numTwo).toString();
        break;
      case '/':
        result = (numOne / numTwo).toString();
        break;
    }
    numOne = double.parse(result);
    result = formatResult(result);
    isNewCalculation = true;
  }

  String formatResult(String result) {
    if (result.contains('.')) {
      List<String> parts = result.split('.');
      if (int.parse(parts[1]) == 0) {
        return parts[0];
      }
    }
    return result;
  }

  Widget calcButton(String btnText, Color btnColor, Color txtColor) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 75,
        height: 75,
        child: ElevatedButton(
          onPressed: () {
            calculation(btnText);
          },
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 25,
              color: txtColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: btnColor,
            padding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // calculator display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                ),
              ],
            ),
            // Buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('8', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('9', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('x', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('5', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('6', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('-', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('2', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('3', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('+', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.grey[850],
                    padding: EdgeInsets.fromLTRB(34, 10, 125, 10),
                  ),
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
                calcButton('.', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('=', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

