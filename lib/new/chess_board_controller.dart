import 'package:chess/chess.dart';
import 'package:flutter/material.dart';

class ChessBoardController extends ValueNotifier<Chess> {
  late Chess game;

  factory ChessBoardController() => ChessBoardController._(Chess());

  factory ChessBoardController.fromGame(Chess game) =>
      ChessBoardController._(game);

  factory ChessBoardController.fromFEN(String fen) =>
      ChessBoardController._(Chess.fromFEN(fen));

  ChessBoardController._(Chess game)
      : game = Chess(),
        super(game);

  void resetBoard() {
    game.reset();
    notifyListeners();
  }
}
