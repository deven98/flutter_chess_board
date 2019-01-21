import 'package:flutter/material.dart';
import 'package:flutter_chess_board/src/board_square.dart';

class ChessBoardRank extends StatelessWidget {
  final List<String> children;

  ChessBoardRank({this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: children
            .map(
              (squareName) => BoardSquare(squareName: squareName),
            )
            .toList(),
      ),
    );
  }
}
