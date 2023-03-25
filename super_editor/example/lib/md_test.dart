import 'package:dart_markdown/dart_markdown.dart';

class MarkdownParser {
  List<Node> parse(String markdownContent) {
    final markdown = Markdown(
      // The options with default value `true`.
      enableAtxHeading: true,
      enableBlankLine: true,
      enableBlockquote: true,
      enableIndentedCodeBlock: true,
      enableFencedBlockquote: true,
      enableFencedCodeBlock: true,
      enableList: true,
      enableParagraph: true,
      enableSetextHeading: true,
      enableTable: true,
      enableHtmlBlock: true,
      enableLinkReferenceDefinition: true,
      enableThematicBreak: true,
      enableAutolinkExtension: true,
      enableAutolink: true,
      enableBackslashEscape: true,
      enableCodeSpan: true,
      enableEmoji: true,
      enableEmphasis: true,
      enableHardLineBreak: true,
      enableImage: true,
      enableLink: true,
      enableRawHtml: true,
      enableSoftLineBreak: true,
      enableStrikethrough: true,

      // The options with default value `false`.
      enableHeadingId: false,
      enableHighlight: false,
      enableFootnote: false,
      enableTaskList: false,
      enableSubscript: false,
      enableSuperscript: false,
      enableKbd: false,
      forceTightList: false,

      // Customised syntaxes.
      extensions: const <Syntax>[],
    );

    // AST nodes.
    return markdown.parse(markdownContent);
  }
}