import 'package:flutter/material.dart';
import 'package:presentation/new_cubit/base_cubit/cubit_screen.dart';
import 'package:presentation/new_cubit/base_cubit/data/tile_wrapper.dart';
import 'package:presentation/new_cubit/cubit/main_cubit.dart';
import 'package:presentation/new_cubit/cubit/main_tile.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State createState() => _HomeWidgetState();
}

class _HomeWidgetState extends CubitScreenState<HomeWidget, MainCubit> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TileWrapper<MainTile>>(
        stream: cubit.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          final tile = data?.data;
          if (data == null || tile == null || data.isLoading) {
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
                      cubit: cubit,
                      tile: tile,
                    ),
                    _TextFieldWidget(
                      cubit: cubit,
                      tile: tile,
                    ),
                    _ButtonsWidget(
                      cubit: cubit,
                      tile: tile,
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
  final MainCubit cubit;
  final MainTile tile;

  const _FormWidget({
    Key? key,
    required this.cubit,
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
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ],
          if (tile.state == MainState.failure) ...[
            const Text(
              'unsuccessful attempt',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
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
  final MainCubit cubit;
  final MainTile tile;

  const _TextFieldWidget({
    Key? key,
    required this.cubit,
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
        controller: cubit.textController,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          height: 2,
        ),
        decoration: const InputDecoration(
          labelText: '0 to 3',
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: styleBorder,
          focusedBorder: styleBorder,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
        ),
      ),
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  final MainCubit cubit;
  final MainTile tile;

  const _ButtonsWidget({
    Key? key,
    required this.cubit,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: cubit.onRefreshClick(),
          child: const Icon(
            Icons.refresh,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        ElevatedButton(
          onPressed: cubit.onDoneClick(),
          child: const Icon(
            Icons.done,
          ),
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
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
    );
  }
}
