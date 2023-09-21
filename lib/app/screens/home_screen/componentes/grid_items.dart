import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/utils/app_color.dart';
import 'package:notes_app/utils/helper_widget.dart';

class NotesGridItem extends StatelessWidget {
  NotesGridItem({
    Key? key,
    required this.note,
    required this.onLongPress,
    required this.onPress,
  }) : super(key: key);

  final Random random = Random();
  final Note note;
  final void Function()? onLongPress;
  final void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.list[random.nextInt(AppColors.list.length)],
      child: InkWell(
        onTap: onPress,
        enableFeedback: true,
        splashColor: AppColors.white,
        onLongPress: onLongPress,
        child: LayoutBuilder(builder: (context, innerConstraints) {
          return Padding(
            padding: EdgeInsets.all(innerConstraints.maxHeight * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title ?? '',
                  maxLines: 4,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: innerConstraints.maxHeight * 0.115,
                      ),
                ),
                addVerticalSpace(innerConstraints.maxHeight * 0.08),
                Text(
                  note.note ?? '',
                  maxLines: 4,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: innerConstraints.maxHeight * 0.115,
                      ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
