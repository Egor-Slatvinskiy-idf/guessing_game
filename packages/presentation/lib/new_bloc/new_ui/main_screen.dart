import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/entity/model_guessed_game.dart';
import 'package:presentation/new_bloc/base_bloc/bloc_screen.dart';
import 'package:presentation/new_bloc/bloc/main_bloc.dart';
import 'package:presentation/new_bloc/bloc/main_tile.dart';

class MainScreenWidget extends BlocScreen {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State createState() => _MainHomeWidgetState();
}

class _MainHomeWidgetState extends BlocScreenState<MainScreenWidget, MainBloc> {
  _MainHomeWidgetState()
      : super(
          MainBloc(
            GenerateNumUseCase(),
            CheckNumUseCase(),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainTile>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _HeaderWidget(),
                Column(
                  children: [
                    _FormWidget(
                      bloc: bloc,
                      tile: data,
                    ),
                    _TextFieldWidget(
                      bloc: bloc,
                      tile: data,
                    ),
                    _ButtonsWidget(
                      bloc: bloc,
                      tile: data,
                    ),
                  ],
                ),
                const _BottomWidget(),
              ],
            ),
          );
        });
  }
}

class _FormWidget extends StatelessWidget {
  final MainBloc bloc;
  final MainTile tile;

  const _FormWidget({
    Key? key,
    required this.bloc,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (tile.state == MainState.success) ...[
            const Text(
              'you guessed!',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
          if (tile.state == MainState.failure) ...[
            const Text(
              'unsuccessful attempt',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: 150,
            child: Text(
              'you have ${tile.counter} attempts left',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final MainBloc bloc;
  final MainTile tile;

  const _TextFieldWidget({
    Key? key,
    required this.bloc,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const styleBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
    );
    return SizedBox(
      width: 150,
      child: TextField(
        keyboardType: TextInputType.number,
        autofocus: true,
        controller: bloc.textController,
        style: const TextStyle(color: Colors.black, fontSize: 24, height: 2),
        decoration: const InputDecoration(
          labelText: '0 to 3',
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: styleBorder,
          focusedBorder: styleBorder,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  final MainBloc bloc;
  final MainTile tile;

  const _ButtonsWidget({
    Key? key,
    required this.bloc,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: tile.state == MainState.success ||
                  tile.counter == Model.initCounter &&
                      tile.state != MainState.success
              ? () {
                  bloc.guessedRestart();
                }
              : null,
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: tile.state == MainState.initial ||
                  tile.state == MainState.failure && tile.counter > 0
              ? () {
                  bloc.guessedCheckNum();
                }
              : null,
          child: const Icon(Icons.done),
        ),
      ],
    );
  }
}

class _BottomWidget extends StatelessWidget {
  const _BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(
          width: 150,
          child: Text(
            '"refresh" button - update the hidden number and the'
            ' number of attempts',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            'button "confirm" - confirm the value you have chosen',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(
        'Welcome, guess the number from zero to three',
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
  }
}
