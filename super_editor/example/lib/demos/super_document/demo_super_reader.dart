import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_editor/super_editor.dart';

import 'example_document.dart';

class SuperReaderDemo extends StatefulWidget {
  const SuperReaderDemo({Key? key}) : super(key: key);

  @override
  State<SuperReaderDemo> createState() => _SuperReaderDemoState();
}

class _SuperReaderDemoState extends State<SuperReaderDemo> {
  late final Document _document;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SuperReader(
      document: createInitialDocument(),
    );
  }
}
