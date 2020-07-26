import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 42.0;
  double resultFontSize = 68.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equationFontSize = 42.0;
        resultFontSize = 68.0;
      } else if (buttonText == '⌫') {
        equationFontSize = 68.0;
        resultFontSize = 42.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 42.0;
        resultFontSize = 68.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('—', '-');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error!';
        }
      } else {
        equationFontSize = 68.0;
        resultFontSize = 42.0;

        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText,
    double buttonHeight,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * .10 * buttonHeight,
      margin: EdgeInsets.all(5),
      child: RaisedButton(
          color: Colors.grey[800],
          shape: CircleBorder(),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          )),
    );
  }

  //upper button
  Widget buildUpButton(
    String buttonText,
    double buttonHeight,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * .10 * buttonHeight,
      margin: EdgeInsets.all(5),
      child: RaisedButton(
          color: Colors.grey[400],
          shape: CircleBorder(),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          )),
    );
  }

  //side button
  Widget buildSideButton(
    String buttonText,
    double buttonHeight,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * .10 * buttonHeight,
      margin: EdgeInsets.all(5),
      child: RaisedButton(
          color: Colors.amber[800],
          shape: CircleBorder(),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          )),
    );
  }

  // Widget buildEqButton(
  //   String buttonText,
  //   double buttonHeight,
  // ) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * .10 * buttonHeight,
  //     margin: EdgeInsets.all(5),
  //     child: RaisedButton(
  //         color: Colors.redAccent,
  //         shape: CircleBorder(),
  //         onPressed: () => buttonPressed(buttonText),
  //         child: Text(
  //           buttonText,
  //           style: TextStyle(
  //             fontSize: 40.0,
  //             fontWeight: FontWeight.normal,
  //             color: Colors.white,
  //           ),
  //         )),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 35,
                  left: 5,
                ),
                width: MediaQuery.of(context).size.width * .72,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildUpButton('C', 1),
                        buildUpButton('⌫', 1),
                        buildUpButton('%', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1),
                        buildButton('8', 1),
                        buildButton('9', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1),
                        buildButton('5', 1),
                        buildButton('6', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1),
                        buildButton('2', 1),
                        buildButton('3', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('0', 1),
                        buildButton('00', 1),
                        buildButton('.', 1),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 35, right: 5),
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildSideButton('÷', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildSideButton('×', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildSideButton('—', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildSideButton('+', 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildSideButton('=', 1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
