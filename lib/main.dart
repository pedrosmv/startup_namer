import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Arrow notation is used for one-line function and methods
void main() => runApp(MyApp());

/*
  In Flutter, everything is a widget, including the app itself. Thus we extend
  the class Stateless Widget
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      /*
        Scaffold is a widget from Material Library that provides
        a default app bar, title and body. The body holds the widget tree for
        Home Screen
      */
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome Home'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

/*
  Prefixing an indentifier with underscore efoncers privact in Dart. This is
  a best practice recommended for State objects.

  The app logics reside in this class. It will maintain the state for our
  Random Words widget.

  The class will save the list of generated word pairs.
*/
class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    /*
      Since wordpair is generated inside build method, everytime we hot reload
      the method runs agaain, creating a new wordpair
    */
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
