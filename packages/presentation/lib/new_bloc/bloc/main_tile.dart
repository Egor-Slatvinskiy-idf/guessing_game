import 'package:presentation/entity/model_guessed_game.dart';

enum MainState { initial, success, failure }

class MainTile {
  MainState state;
  int counter;
  String randomNum;

  MainTile(
    this.randomNum,
    this.counter,
    this.state,
  );

  factory MainTile.init() => MainTile(
        Model.initRandomNum,
        3,
        MainState.initial,
      );

  MainTile copy() => MainTile(randomNum, counter, state);

  void updateParams(
    MainState? state,
    int? counter,
    String? randomNum,
  ) {
    if (counter != null) this.counter = counter;
    if (randomNum != null) this.randomNum = randomNum;
    if (state != null) this.state = state;
  }
}
