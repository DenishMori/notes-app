import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/app/screens/home_screen/home_screen.dart';
import 'package:notes_app/bloc/notes_bloc_import.dart';
import 'package:notes_app/bloc/notes_block/notes_bloc.dart';
import 'package:notes_app/utils/routes.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NotesBloc()..add(GetAllNotesEvents()),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}
