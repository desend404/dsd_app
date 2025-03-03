import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('DSD App')),
        body: CodeInputScreen(),
      ),
    );
  }
}

class CodeInputScreen extends StatefulWidget {
  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;
  bool _isError = false;

  void _checkCode() {
    final code = _controller.text;
    if (code.length == 9) {
      setState(() {
        _isValid = true;
        _isError = false;
      });
    } else {
      setState(() {
        _isValid = false;
        _isError = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isError = false;
          _controller.clear();
        });
      });
    }
  }

  void _reset() {
    setState(() {
      _isValid = false;
      _isError = false;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_isValid)
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Код реквизита',
                errorText: _isError ? 'Пожалуйста, введите корректные реквизиты' : null,
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _checkCode(),
            ),
          if (!_isValid)
            ElevatedButton(
              onPressed: _checkCode,
              child: Text('Подключить'),
            ),
          if (_isValid)
            Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 100),
                Text('working ...', style: TextStyle(fontSize: 24)),
                ElevatedButton(
                  onPressed: _reset,
                  child: Text('Отключить'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
