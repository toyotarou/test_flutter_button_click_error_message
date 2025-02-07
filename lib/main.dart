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
            // ボタン1
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                key: _buttonKey1,
                onPressed: () {
                  showButtonErrorOverlay(context: context, buttonKey: _buttonKey1, message: 'ボタン1でエラー');
                },
                child: const Text('ボタン1'),
              ),
            ),

            // ボタン2
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                key: _buttonKey2,
                onPressed: () {
                  showButtonErrorOverlay(context: context, buttonKey: _buttonKey2, message: 'ボタン2でエラー');
                },
                child: const Text('ボタン2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
