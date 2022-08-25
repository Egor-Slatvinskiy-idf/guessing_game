import 'package:domain/use_case/check_use_case.dart';
import 'package:domain/use_case/generate_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/bloc/bloc.dart';
import 'package:presentation/bloc/bloc_event.dart';
import 'package:presentation/bloc/bloc_state.dart';
import 'package:presentation/entity/model_guessed_game.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GuessedBloc(
        counter: Model.initCounter,
        checkUseCase: CheckNumUseCase(),
        randomNum: Model.initRandomNum,
        generateNumUseCase: GenerateNumUseCase(),
      )..add(const GuessedStartEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _HeaderWidget(),
            Column(
              children: const [
                _FormWidget(),
                _TextFieldWidget(),
                _ButtonsWidget(),
              ],
            ),
            const _BottomWidget(),
          ],
        ),
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuessedBloc, GuessedState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is GuessedSuccessState) ...[
                const Text(
                  'you guessed!',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
              if (state is GuessedFailureState) ...[
                const Text(
                  'unsuccessful attempt',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
              const SizedBox(height: 10),
              SizedBox(
                width: 150,
                child: Text(
                  'you have ${state.counter} attempts left',
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
      },
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  const _TextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GuessedBloc>();
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
        controller: model.numController,
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
  const _ButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuessedBloc, GuessedState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: state is GuessedSuccessState ||
                      state.counter == Model.initCounter &&
                          state is! GuessedSuccessState
                  ? () {
                      context.read<GuessedBloc>().add(
                            const GuessedStartEvent(),
                          );
                    }
                  : null,
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: state is GuessedInitialState ||
                      state is GuessedFailureState && state.counter > 0
                  ? () {
                      context
                          .read<GuessedBloc>()
                          .add(const GuessedCheckEvent());
                    }
                  : null,
              child: const Icon(Icons.done),
            ),
          ],
        );
      },
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
