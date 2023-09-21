import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app/app/screens/add_notes_screen/add_notes.dart';

import 'package:notes_app/app/screens/home_screen/componentes/notes_body.dart';
import 'package:notes_app/bloc/notes_block/add_notes_event.dart';
import 'package:notes_app/bloc/notes_block/add_notes_state.dart';
import 'package:notes_app/bloc/notes_block/notes_bloc.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/utils/app_color.dart';
import 'package:notes_app/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String route = '/home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Note> _noteList;
  bool _isGrid = true;

  @override
  void dispose() {
    closeDatabase();
    super.dispose();
  }

  void closeDatabase() => context.read<NotesBloc>().add(CloseDbEvent());

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Home",
          style: CustomTextStyle.textStyle(20),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: _size.height * 0.012,
          right: _size.height * 0.015,
          bottom: _size.height * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(_size.height * 0.012),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: _size.height * 0.01,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          'All Notes',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: AppColors.lightGray,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_isGrid) {
                        return;
                      } else {
                        context.read<NotesBloc>().add(ShowNotesGridEvent());
                      }
                    },
                    icon: const Icon(Icons.grid_on),
                  ),
                  IconButton(
                    onPressed: () {
                      if (!_isGrid) {
                        return;
                      } else {
                        context.read<NotesBloc>().add(ShowNotesListEvent());
                      }
                    },
                    icon: const Icon(Icons.list_sharp),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NotesBloc, AddToNotesState>(
                builder: (context, state) {
                  if (state is NotedLoadingState ||
                      state is NotesInitialState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.lightGreen,
                      ),
                    );
                  } else if (state is NotesLoadedState) {
                    _noteList = state.notes!;
                    return NotesBody(
                      notesList: _noteList,
                      isGrid: _isGrid,
                    );
                  } else if (state is ShowNotesGridtState) {
                    _isGrid = state.isGrid!;
                    return NotesBody(
                      notesList: _noteList,
                      isGrid: _isGrid,
                    );
                  } else if (state is ShowNotesListState) {
                    _isGrid = state.isList!;
                    return NotesBody(
                      notesList: _noteList,
                      isGrid: _isGrid,
                    );
                  } else if (state is DeleteNotesState) {
                    return NotesBody(
                      notesList: _noteList,
                      isGrid: _isGrid,
                    );
                  } else if (state is CreateNotesState) {
                    _noteList = state.notes!;
                    return NotesBody(
                      notesList: _noteList,
                      isGrid: _isGrid,
                    );
                  } else if (state is UpdateNotesState) {
                    _noteList = state.notes!;
                    return NotesBody(
                      notesList: _noteList,
                      isGrid: _isGrid,
                    );
                  } else if (state is NotesErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddNotesScreen()));
        },
        tooltip: "Tap here for add note",
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple, Colors.blue],
            ).createShader(bounds);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
