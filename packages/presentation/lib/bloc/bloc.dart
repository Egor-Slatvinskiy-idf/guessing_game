import 'package:bloc/bloc.dart';
import 'package:domain/entity/number.dart';
import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/bloc/bloc_event.dart';
import 'package:presentation/bloc/bloc_state.dart';

const _initCounter = 3;

class GuessedBloc extends Bloc<GuessedEvent, GuessedState> {
  final _checkUseCase = CheckNumUseCase();
  late int _counter;
  late String _randomNum;
  late bool _isGuessed;
  final numController = TextEditingController();

  GuessedBloc(this._counter)
      : super(
          GuessedInitialState(randomNum: '', counter: _counter),
        ) {
    on<GuessedStartEvent>(_onGuessedStartEvent);
    on<GuessedCheckEvent>(_onGuessedCheckEvent);
    on<GuessedRefreshEvent>(_onGuessedRefreshEvent);
  }

  void _onGuessedRefreshEvent(
      GuessedRefreshEvent event, Emitter<GuessedState> emit) {
    emit(
      GuessedInitialState(
        randomNum: _randomNum,
        counter: _initCounter,
      ),
    );
  }

  void _onGuessedStartEvent(
      GuessedStartEvent event, Emitter<GuessedState> emit) {
    _randomNum = GenerateNumUseCase().call();
    _counter = _initCounter;
    emit(
      GuessedInitialState(
        randomNum: _randomNum,
        counter: _counter,
      ),
    );
  }

  void _onGuessedCheckEvent(
      GuessedCheckEvent event, Emitter<GuessedState> emit) {
    final enteredNum = numController.text;
    final params = Num(guessedNum: enteredNum, randomNum: _randomNum);
    final compare = _checkUseCase(params);
    if (compare) {
      _isGuessed = true;
      _counter--;
      emit(
        GuessedSuccessState(isGuessed: _isGuessed, counter: _counter),
      );
    } else {
      _isGuessed = false;
      _counter--;
      emit(
        GuessedFailureState(isGuessed: _isGuessed, counter: _counter),
      );
    }
  }
}
