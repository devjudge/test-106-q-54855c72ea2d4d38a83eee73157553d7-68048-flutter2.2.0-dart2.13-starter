// ignore: prefer_double_quotes
import 'package:flutter/foundation.dart';
// ignore: prefer_double_quotes
import 'package:flutter/material.dart';
// ignore: unused_import, prefer_double_quotes
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // IMPORTANT: Uncomment the line `enableFlutterDriverExtension();`
  // before making a submission. 
  //Failure in doing so will not execute the automated testcases.

  // enableFlutterDriverExtension();
  runApp(MyApp());
}

/// The MyApp Class
// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
      // ignore: prefer_double_quotes
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_double_quotes
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
}

/// The Homepage Class
class MyHomePage extends StatefulWidget {

  /// Title member variable
  // ignore: diagnostic_describe_all_properties
  final String title;
  
  /// Constructor
  // ignore: sort_constructors_first
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              // ignore: prefer_double_quotes
              'You have pushed the button this many times:',
            ),
            Text(
              // ignore: prefer_double_quotes
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        // ignore: prefer_double_quotes
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
}
