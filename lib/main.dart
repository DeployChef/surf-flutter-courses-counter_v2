import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Surf',
      home: MyHomePage(title: 'Counter V2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterAll = 0;
  int _counterAdd = 0;
  int _counterRemove = 0;

  final snackBar = const SnackBar(
    content: Text('Эй! Ниже нуля мы точно не пойдем!'),
  );

  void _incrementCounter() {
    setState(() {
      _counterAll++;
      _counterAdd++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counterAll <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        _counterAll--;
      }

      _counterRemove++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Значение каунтера:'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterButton(
                  counterValue: _counterRemove,
                  icon: Icons.remove,
                  onPress: _decrementCounter,
                ),
                const SizedBox(width: 10),
                Text(
                  '$_counterAll',
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(width: 10),
                CounterButton(
                  counterValue: _counterAdd,
                  icon: Icons.add,
                  onPress: _incrementCounter,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CounterButton extends StatelessWidget {
  final int counterValue;
  final Function()? onPress;
  final IconData icon;

  const CounterButton({super.key, required this.counterValue, required this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
      onPressed: onPress,
      child: SizedBox(
        width: 55,
        height: 30,
        child: Stack(
          children: [
            Center(
              child: Icon(
                icon,
                size: 26,
              ),
            ),
            Positioned.directional(
              textDirection: TextDirection.rtl,
              top: 0,
              end: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Container(
                  color: Colors.white,
                  height: 18,
                  constraints: const BoxConstraints(minWidth: 18),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        '$counterValue',
                        style: const TextStyle(color: Colors.black, fontSize: 9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
