import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentation/new_bloc/bloc/main_tile.dart';

abstract class Bloc {
  Stream<MainTile> get dataStream;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<MainTile>();
  final _blocTile = MainTile.init();

  @override
  Stream<MainTile> get dataStream => _data.stream;

  @protected
  void handleData({
    MainState? state,
    int? counter,
    String? randomNum,
  }) {
    _blocTile.updateParams(
      state,
      counter,
      randomNum,
    );
    _data.add(_blocTile.copy());
  }

  @override
  void initState() {}
}
