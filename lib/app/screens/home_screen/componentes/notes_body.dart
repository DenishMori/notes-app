import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notes_app/app/screens/home_screen/componentes/dismissible_background.dart';
import 'package:notes_app/app/screens/home_screen/componentes/grid_items.dart';
import 'package:notes_app/app/screens/home_screen/componentes/list_items.dart';
import 'package:notes_app/app/screens/home_screen/componentes/note_delete_alert_dialog.dart';
import 'package:notes_app/app/screens/see_notes_screen/see_notes_screen.dart';
import 'package:notes_app/bloc/notes_block/add_notes_event.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/utils/text_styles.dart';

import '../../../../bloc/notes_block/notes_bloc.dart';

class NotesBody extends StatelessWidget {
  final List<Note> notesList;
  final bool isGrid;

  const NotesBody({
    super.key,
    required this.notesList,
    required this.isGrid,
  });

  VoidCallback onNoteLongPress(int index, BuildContext context) {
    return () async {
      bool $wantToDelete = await showDeleteNoteDialog(context);

      if ($wantToDelete) {
        Future.delayed(Duration.zero, () {
          context
              .read<NotesBloc>()
              .add(DeleteNoteEvent(id: notesList[index].id));
        });
        $wantToDelete = false;
      }
    };
  }

  ConfirmDismissCallback deleteListItem(BuildContext context, int id) {
    return (direction) async {
      bool $wantToDelete = await showDeleteNoteDialog(context);
      if ($wantToDelete) {
        Future.delayed(Duration.zero, () {
          context.read<NotesBloc>().add(DeleteNoteEvent(id: notesList[id].id));
        });
        $wantToDelete = false;
        return true;
      }
      return false;
    };
  }

  VoidCallback onItemTap(int index, BuildContext context) {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return SeeNotesScreen(
          note: notesList[index],
        );
      }));
    };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    if (notesList.isEmpty) {
      return Center(
        child: Text(
          "No Notes",
          style: CustomTextStyle.textStyle(20),
        ),
      );
    } else if (isGrid) {
      return AnimationLimiter(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: size.height * 0.01,
            crossAxisSpacing: size.height * 0.01,
          ),
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              duration: const Duration(milliseconds: 500),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: NotesGridItem(
                    note: notesList[index],
                    onPress: onItemTap(index, context),
                    onLongPress: onNoteLongPress(index, context),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return AnimationLimiter(
        child: ListView.builder(
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ObjectKey(notesList[index]),
              direction: DismissDirection.startToEnd,
              confirmDismiss: deleteListItem(context, index),
              background: DismissibleBackground(
                size: size,
                color: Colors.red.withOpacity(0.8),
                icon: Icons.delete,
                title: 'Delete',
              ),
              child: AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: size.width * 0.01),
                      child: SizedBox(
                        width: double.infinity,
                        child: NotesListItem(
                            size: size,
                            note: notesList[index],
                            onTap: onItemTap(index, context)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
