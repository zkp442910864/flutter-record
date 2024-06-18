import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';

class MyAppState extends ChangeNotifier {
  var favorites = <WordPair>[];

  var current = WordPair.random();
  final _limit = 100;
  final cache = <WordPair>[];

  MyAppState() {
    // current = WordPair.random();
    // cache.add(current);
    getNext();
  }

  WordPair _readCacheValueOrGetNewValue() {
    if (cache.length >= _limit) {
      final index = cache.indexOf(current);
      return index == -1 || index >= _limit - 1 ? cache[0] : cache[index + 1];
    }

    return WordPair.random();
  }

  void getNext() {
    current = _readCacheValueOrGetNewValue();
    if (!cache.contains(current)) {
      cache.add(current);
    }

    notifyListeners();
  }

  void toggleFavorite([WordPair? outCurrent]) {
    final value = outCurrent ?? current;

    if (favorites.contains(value)) {
      favorites.remove(value);
    } else {
      favorites.add(value);
    }

    notifyListeners();
  }
}
