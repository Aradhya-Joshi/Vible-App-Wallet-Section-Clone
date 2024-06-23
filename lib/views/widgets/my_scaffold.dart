//  Widget to make custom modefied Scaffold if needed.

import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  final AppBar myAppBar;
  final Widget myBody;
  const MyScaffold({super.key, required this.myAppBar, required this.myBody});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.myAppBar,
      body: widget.myBody,
    );
  }
}
