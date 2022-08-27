import 'package:domain/entity/number.dart';
import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/new_bloc/base_bloc/bloc.dart';
import 'package:presentation/new_bloc/bloc/main_tile.dart';

abstract class MainBloc extends Bloc {
  factory MainBloc(
    GenerateNumUseCase generateNumUseCase,
    CheckNumUseCase checkNumUseCase,
  ) =>
      MainBlocImpl(
        checkNumUseCase,
        generateNumUseCase,
      );

  void guessedRestart();
  void guessedCheckNum();
  TextEditingController get textController;
}

class MainBlocImpl extends BlocImpl implements MainBloc {
  final _tile = MainTile.init();
  final _textController = TextEditingController();
  final CheckNumUseCase _checkUseCase;
  final GenerateNumUseCase _generateUseCase;
  int copyCounter = 3;
  String? randomNum;

  MainBlocImpl(
    this._checkUseCase,
    this._generateUseCase,
  );

  @override
  void initState() {
    super.initState();
    _updateData(_tile);
  }

  _updateData(
    MainTile data,
  ) {
    randomNum = _generateUseCase();
    copyCounter = data.counter;
    handleData(
      state: data.state,
      counter: data.counter,
      randomNum: randomNum,
    );
  }

  @override
  void guessedRestart() {
    randomNum = _generateUseCase();
    _updateData(_tile);
  }

  @override
  void guessedCheckNum() {
    final enteredNum = _textController.text;
    final params = Num(enteredNum: enteredNum, randomNum: randomNum);
    final isGuessSuccess = _checkUseCase(params);
    if (isGuessSuccess) {
      handleData(state: MainState.success, counter: --copyCounter, randomNum: randomNum);
    } else {
      handleData(state: MainState.failure, counter: --copyCounter, randomNum: randomNum);
    }
  }

  @override
  TextEditingController get textController => _textController;
}
