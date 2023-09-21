import 'package:flutter/material.dart';
import 'package:notes_app/utils/helper_widget.dart';

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    super.key,
    required this.size,
    required this.color,
    required this.icon,
    required this.title,
  });

  final Size size;
  final Color color;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      margin: EdgeInsets.all(size.height * 0.0080),
      padding: EdgeInsets.all(size.height * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          addHorizontalSpace(size.width * 0.008),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
