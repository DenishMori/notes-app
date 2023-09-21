import 'package:flutter/material.dart';
import 'package:notes_app/app/screens/add_notes_screen/add_notes.dart';
import 'package:notes_app/app/screens/home_screen/home_screen.dart';
import 'package:notes_app/app/screens/see_notes_screen/see_notes_screen.dart';

Map<String, WidgetBuilder> routes = {
  AddNotesScreen.route: (_) => const AddNotesScreen(),
  HomeScreen.route: (_) => const HomeScreen(),
  SeeNotesScreen.route: (_) => const SeeNotesScreen()
};
