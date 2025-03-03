import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;
  bool _isError = false;

  void _checkCode() {
    final code = _controller.text;
    if (code.length == 9 && code.contains(RegExp(r'^[0-9]+$'))) {
      setState(() {
        _isValid = true;
        _isError = false;
      });
    } else {
      setState(() {
        _isValid = false;
        _isError = true;
      });

      // Сбрасываем ошибку через 1 секунду
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
    return Scaffold(
      appBar: AppBar(
        title: Text('DSD App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isValid)
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Введите код реквизита',
                  errorText: _isError ? 'Пожалуйста, введите 9 цифр' : null,
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _checkCode(),
              ),
            if (!_isValid)
              SizedBox(height: 20),
            if (!_isValid)
              ElevatedButton(
                onPressed: _checkCode,
                child: Text('Подключить'),
              ),
            if (_isValid)
              Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 100),
                  SizedBox(height: 20),
                  Text('working ...', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _reset,
                    child: Text('Отключить'),
                  ),
                ],
              ),
          ],
        ),
      ),
      backgroundColor: _isError ? Colors.red : Colors.white,
    );
  }
}
