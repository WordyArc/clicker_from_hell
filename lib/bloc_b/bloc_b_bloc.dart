import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../counter/counter_bloc.dart';

part 'bloc_b_event.dart';
part 'bloc_b_state.dart';

class BBloc extends Bloc<BEvent, BState> {
  final CounterBloc CountBloc;

  BBloc(this.CountBloc) : super(BInitial()) {
    on<BEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
