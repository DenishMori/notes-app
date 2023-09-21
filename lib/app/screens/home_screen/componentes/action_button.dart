import 'package:flutter/material.dart';
import 'package:notes_app/utils/app_color.dart';

Widget actionButton(
  BuildContext context, {
  String? text,
  Widget? icon,
  required VoidCallback onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(
      top: 8.0,
      bottom: 8.0,
    ),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: AppColors.darkGray,
      borderRadius: BorderRadius.circular(12),
    ),
    alignment: Alignment.center,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: text != null && text.isNotEmpty ? 15.0 : 8.0,
          ),
          child: text != null && text.isNotEmpty
              ? Text(
                  text,
                  style: const TextStyle(color: AppColors.white, fontSize: 15),
                )
              : icon,
        ),
      ),
    ),
  );
}
