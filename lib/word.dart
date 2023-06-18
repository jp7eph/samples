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

  void toggleFavorite({required Word target}) {
    state = [
      for (final word in state)
        if (word == target)
          word.copyWith(isFavorite: !word.isFavorite)
        else
          word
    ];
  }
}

final wordProvider = StateNotifierProvider<WordNotifier, List<Word>>((ref) {
  return WordNotifier();
});
