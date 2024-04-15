import 'package:bayan_task/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:bayan_task/views/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit()..createDatabase(),
      child: MaterialApp(

        home: SignInScreen(),
      ),
    );
  }
}

