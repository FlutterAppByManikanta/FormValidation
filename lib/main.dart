import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RegisterationForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Registeration Form Validation",
      home: RegisterationForm(),
    );
  }

}