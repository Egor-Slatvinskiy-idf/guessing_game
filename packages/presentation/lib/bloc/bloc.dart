import 'package:bloc/bloc.dart';
import 'package:domain/entity/number.dart';
import 'package:domain/usecase/check_usecase.dart';
import 'package:domain/usecase/generate_usecase.dart';
import 'package:flutter/material.dart';
import 'package:presentation/bloc/bloc_event.dart';
import 'package:presentation/bloc/bloc_state.dart';

class GuessedBloc extends Bloc<GuessedEvent, GuessedState> {
  final _checkUseCase = CheckNumUseCase();
  late int _counter;
  late String _rNumber;
  late bool _isGuessed;
  final numController = TextEditingController();

  GuessedBloc(this._counter)
      : super(
          GuessedInitialState(rNumber: '', counter: _counter),
        ) {
    on<GuessedStartEvent>(_onGuessedStartEvent);
    on<GuessedCheckEvent>(_onGuessedCheckEvent);
    on<GuessedRefreshEvent>(_onGuessedRefreshEvent);
  }

  void _onGuessedRefreshEvent(
      GuessedRefreshEvent event, Emitter<GuessedState> emit) {
    emit(
      GuessedInitialState(
        rNumber: _rNumber,
        counter: 3,
      ),
    );
  }

  void _onGuessedStartEvent(
      GuessedStartEvent event, Emitter<GuessedState> emit) {
    _rNumber = GenerateNumUseCase().call();
    _counter = 3;
    emit(
      GuessedInitialState(
        rNumber: _rNumber,
        counter: _counter,
      ),
    );
  }

  void _onGuessedCheckEvent(
      GuessedCheckEvent event, Emitter<GuessedState> emit) {
    final enteredNum = numController.text;
    final params = Num(guessedNum: enteredNum, randomNum: _rNumber);
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
