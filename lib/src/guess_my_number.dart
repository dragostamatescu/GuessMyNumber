import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const GuessMyNumberApp());

class GuessMyNumberApp extends StatelessWidget {
  const GuessMyNumberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  String result = '';
  String buttonLabel = 'Guess';
  int randomNumber = Random().nextInt(99) + 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            child: Text('Guess my number'),
            alignment: Alignment.center,
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text(
                "I'm thinking of a number between 1 and 100.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const Text(
              "It's your turn to guess my number!",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              result,
              textScaleFactor: 1.5,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 300,
              child: Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        'Try a number!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: controller,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: false),
                        decoration: InputDecoration(
                          suffix: IconButton(
                            iconSize: 23,
                            onPressed: () => controller.clear(),
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                      child: OutlinedButton(
                        onPressed: () {
                          if (buttonLabel == 'Reset') {
                            setState(() {
                              randomNumber = Random().nextInt(99) + 1;
                              result = '';
                              controller.clear();
                              buttonLabel = 'Guess';
                            });
                          }
                          else {
                            int myNumber = int.parse(controller.text);
                            if (myNumber == randomNumber) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('You guessed right'),
                                      content: Text('It was $randomNumber'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Try again!'),
                                          onPressed: () {
                                            setState(
                                                  () {
                                                randomNumber =
                                                    Random().nextInt(99) + 1;
                                                result = '';
                                                controller.clear();
                                              },
                                            );
                                            Navigator.pop(context, 'Try again');
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            setState(() {
                                              buttonLabel = 'Reset';
                                              controller.clear();
                                            });
                                            Navigator.pop(context, 'OK');
                                          },
                                        ),
                                      ],
                                    ),
                              );
                              FocusManager.instance.primaryFocus?.unfocus();
                            } else if (myNumber < randomNumber) {
                              setState(() =>
                              result = 'You tried $myNumber.\nTry higher!');
                            } else if (myNumber > randomNumber) {
                              setState(() =>
                              result = 'You tried $myNumber.\nTry smaller!');
                            }
                          }
                        },
                        child: Text(buttonLabel, textScaleFactor: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
