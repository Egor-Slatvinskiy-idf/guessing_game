import 'package:equatable/equatable.dart';

abstract class GuessedState extends Equatable {
  final int counter;

  const GuessedState({required this.counter});

  @override
  List<Object?> get props => [counter];
}

class GuessedInitialState extends GuessedState {
  final String randomNum;

  const GuessedInitialState({
    super.counter = 0,
    this.randomNum = '',
  });
}

class GuessedSuccessState extends GuessedState {

  const GuessedSuccessState({
    required super.counter,
  });
}

class GuessedFailureState extends GuessedState {

  const GuessedFailureState({
    required super.counter,
  });
}
