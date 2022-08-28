import 'package:flutter/material.dart';
import 'package:presentation/new_cubit/base_cubit/cubit.dart';

abstract class CubitScreen extends StatefulWidget {
  const CubitScreen({Key? key}) : super(key: key);
}

abstract class CubitScreenState<CS extends CubitScreen, C extends Cubit> extends State<CS> {
  CubitScreenState(Cubit this.cubit);
  @protected
  final cubit;

  @override
  void initState() {
    super.initState();
    cubit.initState();
  }

}