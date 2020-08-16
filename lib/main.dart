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
    return MaterialApp(title: 'Welcome to Flutter', home: RandomWords());
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
  final List<WordPair> _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    /*
        Scaffold is a widget from Material Library that provides
        a default app bar, title and body. The body holds the widget tree for
        Home Screen
      */
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      /*
        The itemBuilder callback is called once per suggested
        word pairing, and places each suggestion into a ListTile
        row. For even rows, the function adds a ListTile row for
        the word pairing. For odd rows, the function adds a
        Divider widget to visually separate the entries. Note that
        the divider may be difficult to see on smaller devices.
      */
      itemBuilder: (BuildContext _context, int i) {
        /*
          Add a one-pixel-high divider widget before each row
          in the ListView.
        */
        if (i.isOdd) {
          return Divider();
        }
        /*
          The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          This calculates the actual number of word pairings
          in the ListView,minus the divider widgets.
        */
        final int index = i ~/ 2;
        /* If we reach the end of the available word pair.. */
        if (index >= _suggestions.length) {
          /*...then we generate 10 more and add them to suggestion list */
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext) {
          final tiles = _saved.map((WordPair pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          });
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  /* This function display each new pair in a List Tile */
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.blueGrey : null,
      ),
      onTap: () {
        /*
          In Flutter's reactive style framework, calling setState() triggers
          a call to the build() method for the State object,
          resulting in an update to the UI.
        */
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
