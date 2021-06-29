import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCustomModalDialog(
  BuildContext context, {
  String title,
  String content,
  Function cancelOnPressed,
  Function submitOnPressed,
  String cancelButtonText,
  String submitButtonText,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(submitButtonText),
          onPressed: submitOnPressed,
        ),
        TextButton(
          child: Text(cancelButtonText),
          onPressed: cancelOnPressed,
        ),
      ],
    ),
    transitionBuilder: (context, anim1, anim2, child) => SlideTransition(
      transformHitTests: false,
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.linear)).animate(anim1),
      child: child,
    ),
  );
}
