import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy2/modules/counter/cubit/cubit.dart';
import 'package:udemy2/modules/counter/cubit/states.dart';
import 'package:udemy2/shared/components/components.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterMinusState) print("minus state ${state.counter}");
          if (state is CounterPlusState) print("plus state ${state.counter}");
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter Screen'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DefaultButton(
                    function: () {
                      CounterCubit.get(context).minus();
                    },
                    text: "-",
                    width: 60.0,
                  ),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                  DefaultButton(
                    function: () {
                      CounterCubit.get(context).plus();
                    },
                    text: "+",
                    width: 60.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
