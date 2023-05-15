import 'package:flutter/material.dart';

pushTo(Widget page, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

pop(BuildContext context) {
  Navigator.pop(context);
}