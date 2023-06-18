import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class Word {
  final String word;
  final bool isFavorite;

  const Word({required this.word, this.isFavorite = false});

  Word copyWith({String? word, bool? isFavorite}) {
    return Word(
        word: word ?? this.word, isFavorite: isFavorite ?? this.isFavorite);
  }
}

class WordNotifier extends StateNotifier<List<Word>> {
  WordNotifier() : super([]);

  void add() {
    state = [
      ...state,
      Word(word: WordPair.random().asLowerCase),
    ];
  }

  void toggleFavorite({required String target}) {
    state = [
      for (final w in state)
        if (w.word == target) w.copyWith(isFavorite: !w.isFavorite) else w
    ];
  }
}

final wordProvider = StateNotifierProvider<WordNotifier, List<Word>>((ref) {
  return WordNotifier();
});
