import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String _inputValue = '';
  double _result = 0.0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clear();
      } else if (buttonText == '=') {
        _calculateResult();
      } else {
        _inputValue += buttonText;
      }
    });
  }

  void _clear() {
    _inputValue = '';
    _result = 0.0;
  }

  void _calculateResult() {
    try {
      _result = eval(_inputValue);
      _inputValue = _result.toString();
    } catch (e) {
      _inputValue = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator',style: TextStyle(color: Colors.amber),),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: Column(

        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: Text(
              _inputValue,
              style: TextStyle(fontSize: 50.0,color: Colors.white),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCalcButton('7'),
              _buildCalcButton('8'),
              _buildCalcButton('9'),
              _buildCalcButton('/'),
            ],
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCalcButton('4'),
              _buildCalcButton('5'),
              _buildCalcButton('6'),
              _buildCalcButton('*'),
            ],
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCalcButton('1'),
              _buildCalcButton('2'),
              _buildCalcButton('3'),
              _buildCalcButton('-'),
            ],
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCalcButton('C'),
              _buildCalcButton('0'),
              _buildCalcButton('='),
              _buildCalcButton('+'),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  Widget _buildCalcButton(String buttonText) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey)),
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 50.0,color: Colors.amber.shade600),
      ),
    );
  }

  double eval(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }
}
