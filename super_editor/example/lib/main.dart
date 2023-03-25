import 'package:dart_markdown/dart_markdown.dart';
import 'package:example/demos/demo_attributed_text.dart';
import 'package:example/demos/styles/demo_doc_styles.dart';
import 'package:example/demos/super_document/demo_super_reader.dart';
import 'package:example/md_test.dart';
import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_markdown/super_editor_markdown.dart';
import 'package:super_text_layout/super_text_layout.dart';
import 'package:markdown/markdown.dart' as md;

/// Demo of a basic text editor, as well as various widgets that
/// are available in this package.
Future<void> main() async {
  runApp(SuperEditorDemoApp());
}

class SuperEditorDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Editor Demo App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}

/// Displays various demos that are selected from a list of
/// options in a drawer.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late DocumentEditor editor;
  @override
  void initState() {
    final myDoc = MutableDocument(
      nodes: [
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          text: AttributedText(text: 'This is a header'),
          metadata: {
            'blockType': header1Attribution,
          },
        ),
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          text: AttributedText(text: 'This is the first paragraph'),
        ),
      ],
    );

    editor = DocumentEditor(document: myDoc);
    editor.document.addListener(thing);
  }

  void thing() {
    editor.document.removeListener(thing);
    for (var node in editor.document.nodes) {
      print(node.runtimeType);
      if (node is ParagraphNode) {
        var attrText = (node as ParagraphNode).text;
        attrText.clearAttributions(SpanRange(start: 0, end: attrText.text.length - 1));
        print("-----------------------");
        print(attrText.text);
        List<Node>? nodes;

        try {
          nodes = MarkdownParser().parse(attrText.text);
          for (var node in nodes) {
            handleNode(attrText, node);
          }
        } catch (_) {}
      }
    }
    editor.document.addListener(thing);
  }

  void handleNode(AttributedText source, Node node) {
    if (node is BlockElement) {
      for (var child in (node as BlockElement).children) {
        handleNode(source, child);
      }
    }

    if (node is InlineElement) {
      var inline = node as InlineElement;
      switch (inline.type) {
        case "emphasis":
          source.addAttribution(italicsAttribution, SpanRange(start: inline.start.offset, end: inline.end.offset - 1));
          break;
        case "strongEmphasis":
          source.addAttribution(boldAttribution, SpanRange(start: inline.start.offset, end: inline.end.offset - 1));
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuperEditor(
        stylesheet: defaultStylesheet.copyWith(addRulesAfter: []),
        editor: editor,
      ),
    );
  }
}
