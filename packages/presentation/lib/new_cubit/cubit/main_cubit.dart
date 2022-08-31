import 'package:domain/entity/parameters_check.dart';
import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/entity/initial_numbers.dart';
import 'package:presentation/new_cubit/base_cubit/cubit.dart';
import 'package:presentation/new_cubit/cubit/main_tile.dart';

@injectable
abstract class MainCubit extends Cubit<MainTile> {
  @factoryMethod
  factory MainCubit(
    GenerateNumUseCase generateNumUseCase,
    CheckNumUseCase checkNumUseCase,
  ) =>
      MainCubitImpl(
        checkNumUseCase,
        generateNumUseCase,
      );

  Function()? onRefreshClick();

  Function()? onDoneClick();

  TextEditingController get textController;
}

class MainCubitImpl extends CubitImpl<MainTile> implements MainCubit {
  var _tile = MainTile.init();
  final _textController = TextEditingController();
  final CheckNumUseCase _checkUseCase;
  final GenerateNumUseCase _generateUseCase;

  @override
  TextEditingController get textController => _textController;

  MainCubitImpl(
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
    _tile.randomNum = _generateUseCase();
    handleData(tile: _tile);
  }

  void guessedRestart() {
    _tile = _tile.copyWith(
      counter: InitialNumbers.maxCounter,
      randomNum: _generateUseCase(),
      state: MainState.initial,
    );
    handleData(tile: _tile);
  }

  void guessedCheckNum() {
    final enteredNum = _textController.text;
    final params = ParametersToCheck(
      enteredNum: enteredNum,
      randomNum: _tile.randomNum,
    );
    final isGuessSuccess = _checkUseCase(params);
    _tile = _tile.copyWith(counter: _tile.counter - 1);
    if (isGuessSuccess) {
      _tile = _tile.copyWith(
        state: MainState.success,
      );
    } else {
      _tile = _tile.copyWith(
        state: MainState.failure,
      );
    }
    handleData(tile: _tile);
  }

  @override
  Function()? onDoneClick() => _tile.state == MainState.initial ||
          _tile.state == MainState.failure && _tile.counter > 0
      ? () {
          guessedCheckNum();
        }
      : null;

  @override
  Function()? onRefreshClick() => _tile.state == MainState.success ||
          _tile.counter == InitialNumbers.initCounter &&
              _tile.state != MainState.success
      ? () {
          guessedRestart();
        }
      : null;
}
