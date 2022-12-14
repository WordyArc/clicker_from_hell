import 'package:clicker_from_hell/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'listener/listener_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    var counterBloc = CounterBloc();
    var listenerBloc = ListenerBloc(counterBloc);
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => counterBloc,
        ),
        BlocProvider<ListenerBloc>(
          create: (context) => ListenerBloc(counterBloc),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(

          title: Text('Chainsaw clicker'),
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterBloc, int>(
                bloc: counterBloc,
                builder: (context, state) {
                  return Text(
                    state.toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: BlocListener<ListenerBloc, int>(
          bloc: listenerBloc,
          listener: (context, state) {
            if (state == 1) {
              Scaffold.of(context).showBottomSheet(
                      (context) =>
                      Container(
                        color: Colors.orange,
                        width: double.infinity,
                        height: 100,
                        child: const Center(
                          child: Text(
                              '??????????????: ???? 2 ???????????? ???????????????? ??????????.... ?????????? ???? ????????',
                              style: TextStyle(
                                  fontSize: 24
                              )
                          ),
                        ),
                      )
              );
            }
          },
          child: FloatingActionButton(
            onPressed: () {
              counterBloc.add(
                  CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
