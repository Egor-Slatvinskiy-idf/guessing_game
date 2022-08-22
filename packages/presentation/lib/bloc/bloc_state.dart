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
    required super.counter,
    required this.randomNum,
  });
}

class GuessedSuccessState extends GuessedState {
  final bool isGuessed;

  const GuessedSuccessState({
    required this.isGuessed,
    required super.counter,
  });
}

class GuessedFailureState extends GuessedState {
  final bool isGuessed;

  const GuessedFailureState({
    required this.isGuessed,
    required super.counter,
  });
}
