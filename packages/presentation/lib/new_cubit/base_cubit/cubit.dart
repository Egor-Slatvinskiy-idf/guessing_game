import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentation/new_cubit/base_cubit/data/tile_wrapper.dart';

abstract class Cubit<D> {
  Stream<TileWrapper<D>> get dataStream;

  void initState();
}

abstract class CubitImpl<D> implements Cubit<D> {
  final _data = StreamController<TileWrapper<D>>();
  var _blocTile = TileWrapper<D>();

  @override
  Stream<TileWrapper<D>> get dataStream => _data.stream;

  @protected
  void handleData({D? tile}) {
    _blocTile = _blocTile.copyWith(data: tile);
    _data.add(_blocTile);
  }

  @override
  void initState() {}
}
