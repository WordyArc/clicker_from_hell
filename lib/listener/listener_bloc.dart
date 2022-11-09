import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../counter/counter_bloc.dart';

part 'listener_event.dart';
part 'listener_state.dart';

class ListenerBloc extends Bloc<ListenerEvent, int> {
  final CounterBloc counterBloc;
  late final StreamSubscription counterBlocSubscription;

  ListenerBloc(this.counterBloc) : super(0) {
    on<CounterListenerEvent>(_onCounterListener);

    counterBlocSubscription = counterBloc.stream.listen((state) {
      if (state == 10) {
        add(CounterListenerEvent());
      }
    });
  }

  _onCounterListener(event, Emitter<int> emit) {
    emit(state + 1);
  }

  @override
  Future<void> close() async{
    counterBlocSubscription.cancel();
    return super.close();
  }
}


