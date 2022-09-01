import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/new_cubit/base_cubit/cubit.dart';

abstract class CubitScreenState<CS extends StatefulWidget, C extends Cubit> extends State {
  @protected
  final C cubit = GetIt.instance.get<C>();

  @override
  void initState() {
    super.initState();
    cubit.initState();
  }
}