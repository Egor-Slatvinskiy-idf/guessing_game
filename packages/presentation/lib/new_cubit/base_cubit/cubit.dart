import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentation/new_cubit/cubit/main_tile.dart';

abstract class Cubit {
  Stream<MainTile> get dataStream;

  void initState();
}

abstract class CubitImpl implements Cubit {
  final _data = StreamController<MainTile>();
  final _cubitTile = MainTile.init();

  @override
  Stream<MainTile> get dataStream => _data.stream;

  @protected
  void handleData({
    MainState? state,
    int? counter,
    String? randomNum,
  }) {
    _cubitTile.updateParams(
      state,
      counter,
      randomNum,
    );
    _data.add(_cubitTile.copy());
  }

  @override
  void initState() {}
}
