import 'package:flutter/material.dart';

class CreationPageAppBar extends AppBar {
  final Widget? title;
  final Function onEdit;
  final BuildContext context;
  // final IconButton leading;

  CreationPageAppBar(
    this.context, {
    this.title,
    required this.onEdit,
    // required this.leading,
  }) : super(
          automaticallyImplyLeading: false,
          title: title,
          leading: IconButton(
              onPressed: () {
                onEdit();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        );
}
