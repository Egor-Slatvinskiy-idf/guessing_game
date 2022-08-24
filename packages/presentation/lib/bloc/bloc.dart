import 'package:bloc/bloc.dart';
import 'package:domain/entity/number.dart';
import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/bloc/bloc_event.dart';
import 'package:presentation/bloc/bloc_state.dart';

const _initCounter = 3;

class GuessedBloc extends Bloc<GuessedEvent, GuessedState> {
  final numController = TextEditingController();
  final GenerateNumUseCase generateNumUseCase;
  final CheckNumUseCase checkUseCase;
  int counter;
  String randomNum;

  GuessedBloc({
    required this.generateNumUseCase,
    required this.counter,
    required this.checkUseCase,
    required this.randomNum,
  }) : super(
          const GuessedInitialState(),
        ) {
    on<GuessedStartEvent>(_onGuessedStartEvent);
    on<GuessedCheckEvent>(_onGuessedCheckEvent);
    on<GuessedRefreshEvent>(_onGuessedRefreshEvent);
  }

  void _onGuessedRefreshEvent(
    GuessedRefreshEvent event,
    Emitter<GuessedState> emit,
  ) {
    emit(
      GuessedInitialState(
        randomNum: randomNum,
        counter: _initCounter,
      ),
    );
  }

  void _onGuessedStartEvent(
    GuessedStartEvent event,
    Emitter<GuessedState> emit,
  ) {
    randomNum = generateNumUseCase();
    counter = _initCounter;
    emit(
      GuessedInitialState(
        randomNum: randomNum,
        counter: counter,
      ),
    );
  }

  void _onGuessedCheckEvent(
    GuessedCheckEvent event,
    Emitter<GuessedState> emit,
  ) {
    final enteredNum = numController.text;
    final params = Num(guessedNum: enteredNum, randomNum: randomNum);
    final isGuessSuccess = checkUseCase(params);
    if (isGuessSuccess) {
      counter--;
      emit(
        GuessedSuccessState(counter: counter),
      );
    } else {
      counter--;
      emit(
        GuessedFailureState(counter: counter),
      );
    }
  }
}
