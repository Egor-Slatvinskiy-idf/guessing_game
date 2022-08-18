import 'package:flutter/material.dart';
import 'package:untitled1/home_widget/home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool checkCounter = true;
  int counter = 3;
  final model = HomeModel();

  void decrementCounter() {
    model.guessed();
    setState(() {
      counter--;
      if (counter == 0) {
        checkCounter = false;
      }
      if (counter == 3) {
        checkCounter = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    model.generateNum();
  }

  void updateCounter() {
    setState(() {
      counter = 3;
      model.generateNum();
      checkCounter = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _HeaderWidget(),
          _FormWidget(),
          const _BottomWidget(),
        ],
      ),
    );
  }

  Center _FormWidget() {
    const styleBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
    );
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (model.isGuessed == true) ...[
                const Text(
                  'unsuccessful attempt',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
              if (model.isGuessed == false) ...[
                const Text(
                  'you guessed!',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 150,
                child: Text(
                  'you have $counter attempts left',
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
              _ButtonsWidget(),
            ],
          ),
        );
  }

  Row _ButtonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: updateCounter,
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: checkCounter ? decrementCounter : null,
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
