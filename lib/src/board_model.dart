import 'dart:ui';
import 'package:flutter_chess_board/src/chess_board_controller.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chess/chess.dart' as chess;

typedef Null MoveCallback(String moveNotation);
typedef Null CheckMateCallback(String winColor);

class BoardModel extends Model{

  double size;

  MoveCallback onMove;

  CheckMateCallback onCheckMate;

  VoidCallback onDraw;

  bool whiteSideTowardsUser;

  ChessBoardController chessBoardController;

  bool enableUserMoves;

  chess.Chess game = chess.Chess();

  BoardModel(this.size, this.onMove, this.onCheckMate, this.onDraw,
      this.whiteSideTowardsUser, this.chessBoardController,
      this.enableUserMoves);

  void refreshBoard() {
    notifyListeners();
  }

}