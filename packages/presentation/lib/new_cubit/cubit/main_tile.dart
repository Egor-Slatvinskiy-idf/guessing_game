import 'package:presentation/entity/initial_numbers.dart';

enum MainState {
  initial,
  success,
  failure,
}

class MainTile {
  final int counter;
  MainState state;
  String randomNum;

  MainTile({
    required this.randomNum,
    required this.counter,
    required this.state,
  });

  MainTile copyWith({
    MainState? state,
    int? counter,
    String? randomNum,
  }) =>
      MainTile(
        randomNum: randomNum ?? this.randomNum,
        counter: counter ?? this.counter,
        state: state ?? this.state,
      );

  factory MainTile.init() => MainTile(
        randomNum: InitialNumbers.initRandomNum,
        state: MainState.initial,
        counter: 3,
      );
}
