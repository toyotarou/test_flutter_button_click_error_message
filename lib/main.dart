// main.dart
import 'package:flutter/material.dart';
import 'error_overlay.dart'; // 先ほど作成したファイルをimport

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Overlay Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _buttonKey1 = GlobalKey();
  final GlobalKey _buttonKey2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Buttons Error Sample'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              key: _buttonKey1,
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {
                  showButtonErrorOverlay(context: context, buttonKey: _buttonKey1, message: 'ボタン1でエラー');
                },
                icon: const Icon(Icons.ac_unit, color: Colors.white),
              ),
            ),
            Container(
              key: _buttonKey2,
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {
                  showButtonErrorOverlay(context: context, buttonKey: _buttonKey2, message: 'ボタン2でエラー');
                },
                icon: const Icon(Icons.ac_unit, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
