import 'package:flutter/material.dart';
import 'package:flutter_chess_board/src/board_model.dart';
import 'package:flutter_chess_board/src/board_rank.dart';
import 'package:scoped_model/scoped_model.dart';
import 'chess_board_controller.dart';

var whiteSquareList = [
  [
    "a8",
    "b8",
    "c8",
    "d8",
    "e8",
    "f8",
    "g8",
    "h8",
  ],
  [
    "a7",
    "b7",
    "c7",
    "d7",
    "e7",
    "f7",
    "g7",
    "h7",
  ],
  [
    "a6",
    "b6",
    "c6",
    "d6",
    "e6",
    "f6",
    "g6",
    "h6",
  ],
  [
    "a5",
    "b5",
    "c5",
    "d5",
    "e5",
    "f5",
    "g5",
    "h5",
  ],
  [
    "a4",
    "b4",
    "c4",
    "d4",
    "e4",
    "f4",
    "g4",
    "h4",
  ],
  [
    "a3",
    "b3",
    "c3",
    "d3",
    "e3",
    "f3",
    "g3",
    "h3",
  ],
  [
    "a2",
    "b2",
    "c2",
    "d2",
    "e2",
    "f2",
    "g2",
    "h2",
  ],
  [
    "a1",
    "b1",
    "c1",
    "d1",
    "e1",
    "f1",
    "g1",
    "h1",
  ],
];

class ChessBoard extends StatefulWidget {
  final double size;

  final MoveCallback onMove;

  final CheckMateCallback onCheckMate;

  final VoidCallback onDraw;

  final bool whiteSideTowardsUser;

  final ChessBoardController chessBoardController;

  final bool enableUserMoves;

  ChessBoard(
      {this.size = 200.0,
      this.whiteSideTowardsUser = true,
      @required this.onMove,
      @required this.onCheckMate,
      @required this.onDraw,
      this.chessBoardController,
      this.enableUserMoves = true});

  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: BoardModel(
        widget.size,
        widget.onMove,
        widget.onCheckMate,
        widget.onDraw,
        widget.whiteSideTowardsUser,
        widget.chessBoardController,
        widget.enableUserMoves,
      ),
      child: Container(
        height: widget.size,
        width: widget.size,
        child: Stack(
          children: <Widget>[
            Container(
              height: widget.size,
              width: widget.size,
              child: Image.asset(
                "images/chess_board.png",
                package: 'flutter_chess_board',
              ),
            ),
            //Overlaying draggables/ dragTargets onto the squares
            Center(
              child: Container(
                height: widget.size,
                width: widget.size,
                child: buildChessBoard(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChessBoard() {
    return Column(
      children: widget.whiteSideTowardsUser
          ? whiteSquareList.map((row) {
              return ChessBoardRank(
                children: row,
              );
            }).toList()
          : whiteSquareList.reversed.map((row) {
              return ChessBoardRank(
                children: row.reversed.toList(),
              );
            }).toList(),
    );
  }
}