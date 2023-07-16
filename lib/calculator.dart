import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Calculator extends StatelessWidget {
  Calculator({super.key});
  final TextEditingController _controller = TextEditingController();
  late double total;
  String operation = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              enabled: false,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 40, color: Colors.black),
              minLines: 2,
              maxLines: 2,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: numberButton('7')),
                  Expanded(child: numberButton('8')),
                  Expanded(child: numberButton('9')),
                  Expanded(child: operationButton('/', () {
                    if (_controller.text != '') {
                      total = double.parse(_controller.text);
                      _controller.text = '';
                      operation = '/';
                    }
                  })),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: numberButton('4')),
                  Expanded(child: numberButton('5')),
                  Expanded(child: numberButton('6')),
                  Expanded(
                      child: operationButton('X', () {
                    if (_controller.text != '') {
                      total = double.parse(_controller.text);
                      _controller.text = '';
                      operation = 'X';
                    }
                  })),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: numberButton('1')),
                  Expanded(child: numberButton('2')),
                  Expanded(child: numberButton('3')),
                  Expanded(child: operationButton('-', () {
                    if (_controller.text != '') {
                      total = double.parse(_controller.text);
                      _controller.text = '';
                      operation = '-';
                    }
                  })),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: operationButton('.', () {
                    if (!_controller.text.contains('.')) {
                      _controller.text = _controller.text == '' ? '0.' : '${_controller.text}.';
                    }
                  })),
                  Expanded(child: numberButton('0')),
                  Expanded(child: numberButton('00')),
                  Expanded(
                      child: operationButton('+', () {
                    if (_controller.text != '') {
                      total = double.parse(_controller.text);
                      _controller.text = '';
                      operation = '+';
                    }
                  })),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: operationButton('CLEAR', () {
                    _controller.text = '';
                    total = 0;
                    operation = '';
                  })),
                  Expanded(
                      child: operationButton('=', () {
                    _controller.text = operation == '' ? operation : calculateTotal().toString();
                    total = 0;
                  })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget numberButton(String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: TextButton(
          onPressed: () {
            _controller.text = '${_controller.text}$value';
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(55, 158, 158, 158),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 25),
          )),
    );
  }

  Widget operationButton(String value, VoidCallback callback) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: TextButton(
          onPressed: callback,
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(55, 158, 158, 158),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 25),
          )),
    );
  }
  double calculateTotal() {
    double value = 0;
    switch (operation) {
      case '+':
        value = total + double.parse(_controller.text);
        break;
      case '-':
      value = total - double.parse(_controller.text);
      break;
      case '/':
      value = total / double.parse(_controller.text);
      break;
      case 'X':
      value = total * double.parse(_controller.text);
      break;
    }
    return value;
  }
}
