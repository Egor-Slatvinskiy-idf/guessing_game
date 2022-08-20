import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/bloc.dart';
import 'package:untitled1/bloc/bloc_event.dart';
import 'package:untitled1/bloc/bloc_state.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GuessedBloc(1)..add(const GuessedStartEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _HeaderWidget(),
            Column(
              children: const [
                _FormWidget(),
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
    final model = context.watch<GuessedBloc>();
    const styleBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
    );
    return BlocBuilder<GuessedBloc, GuessedState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is GuessedSuccessState) ...[
                if (state.isGuessed == true) ...[
                  const Text(
                    'you guessed!',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ],
              if(state is GuessedFailureState) ...[
                if (state.isGuessed == false) ...[
                  const Text(
                    'unsuccessful attempt',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ],
              const SizedBox(
                height: 10,
              ),
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 150,
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  controller: model.numController,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 24, height: 2),
                  decoration: const InputDecoration(
                    labelText: 'random num',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: styleBorder,
                    focusedBorder: styleBorder,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
            if (state is GuessedInitialState) ...[
              const ElevatedButton(
                onPressed: null,
                child: Icon(Icons.refresh),
              ),
              ElevatedButton(
                onPressed: () => context.read<GuessedBloc>().add(
                      const GuessedCheckEvent(),
                    ),
                child: const Icon(Icons.done),
              ),
            ],
            if (state is GuessedSuccessState) ...[
              ElevatedButton(
                onPressed: () => context.read<GuessedBloc>().add(
                      const GuessedStartEvent(),
                    ),
                child: const Icon(Icons.refresh),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Icon(Icons.done),
              ),
            ],
            if (state is GuessedFailureState && state.counter > 0) ...[
              const ElevatedButton(
                onPressed: null,
                child: Icon(Icons.refresh),
              ),
              ElevatedButton(
                onPressed: () => context.read<GuessedBloc>().add(
                  const GuessedCheckEvent(),
                ),
                child: const Icon(Icons.done),
              ),
            ],
            if(state.counter == 0 && state is !GuessedSuccessState) ...[
              ElevatedButton(
                onPressed: () => context.read<GuessedBloc>().add(
                  const GuessedStartEvent(),
                ),
                child: const Icon(Icons.refresh),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Icon(Icons.done),
              ),
            ],
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
