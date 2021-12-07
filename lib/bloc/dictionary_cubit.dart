import 'package:bloc_basics/model/dic_response.dart';
import 'package:bloc_basics/repo/word_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final WordRepository _repository;

  DictionaryCubit(this._repository) : super(NoWordSearchedState());

  final queryController = TextEditingController();

  Future getWordSearched() async {
    emit(WordSearchingState());

    try {
      final words =
          await _repository.getWordsFromDictionary(queryController.text);

      if (words == []) {
        emit(ErrorState("There is some issue"));
      } else {
        print(words.toString());
        emit(WordSearchedState(words));
        emit(NoWordSearchedState());
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class DictionaryState {}

class NoWordSearchedState extends DictionaryState {}

class WordSearchingState extends DictionaryState {}

class WordSearchedState extends DictionaryState {
  final List<DicRespose> words;

  WordSearchedState(this.words);
}

class ErrorState extends DictionaryState {
  final message;

  ErrorState(this.message);
}
