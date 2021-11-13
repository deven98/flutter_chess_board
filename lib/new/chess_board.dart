import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart' hide Color;
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:chess/chess.dart';

const ranks = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

/// Enum which stores board types
enum BoardColor {
  brown,
  darkBrown,
  orange,
  green,
}

enum PlayerColor {
  white,
  black,
}

class ChessBoard extends StatelessWidget {
  /// An instance of [ChessBoardController] which holds the game and allows
  /// manipulating the board programmatically.
  final ChessBoardController controller;

  /// Size of chessboard
  final double? size;

  /// A boolean which checks if the user should be allowed to make moves
  final bool enableUserMoves;

  /// The color type of the board
  final BoardColor boardColor;

  final PlayerColor boardOrientation;

  const ChessBoard({
    Key? key,
    required this.controller,
    this.size,
    this.enableUserMoves = true,
    this.boardColor = BoardColor.brown,
    this.boardOrientation = PlayerColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          AspectRatio(
            child: _getBoardImage(boardColor),
            aspectRatio: 1.0,
          ),
          GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemBuilder: (context, index) {
              var row = index ~/ 8;
              var column = index % 8;
              var boardRank = boardOrientation == PlayerColor.black ? '${row + 1}' : '${(7 - row) + 1}';
              var boardFile = boardOrientation == PlayerColor.white ? '${ranks[column]}' : '${ranks[7 - column]}';

              var squareName = '$boardFile$boardRank';

              return _getImageToDisplay(squareName, controller);
            },
            itemCount: 64,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  /// Returns the board image
  Image _getBoardImage(BoardColor color) {
    switch (color) {
      case BoardColor.brown:
        return Image.asset(
          "images/brown_board.png",
          package: 'flutter_chess_board',
          fit: BoxFit.cover,
        );
      case BoardColor.darkBrown:
        return Image.asset(
          "images/dark_brown_board.png",
          package: 'flutter_chess_board',
          fit: BoxFit.cover,
        );
      case BoardColor.green:
        return Image.asset(
          "images/green_board.png",
          package: 'flutter_chess_board',
          fit: BoxFit.cover,
        );
      case BoardColor.orange:
        return Image.asset(
          "images/orange_board.png",
          package: 'flutter_chess_board',
          fit: BoxFit.cover,
        );
    }
  }

  /// Get image to display on square
  Widget _getImageToDisplay(
      String squareName, ChessBoardController controller) {
    late Widget imageToDisplay;
    var game = controller.game;
    var square = game.get(squareName);

    if (controller.game.get(squareName) == null) {
      return Container();
    }

    String piece = (square?.color == Color.WHITE ? 'W' : 'B') +
        (square?.type.toUpperCase() ?? 'P');

    switch (piece) {
      case "WP":
        imageToDisplay = WhitePawn();
        break;
      case "WR":
        imageToDisplay = WhiteRook();
        break;
      case "WN":
        imageToDisplay = WhiteKnight();
        break;
      case "WB":
        imageToDisplay = WhiteBishop();
        break;
      case "WQ":
        imageToDisplay = WhiteQueen();
        break;
      case "WK":
        imageToDisplay = WhiteKing();
        break;
      case "BP":
        imageToDisplay = BlackPawn();
        break;
      case "BR":
        imageToDisplay = BlackRook();
        break;
      case "BN":
        imageToDisplay = BlackKnight();
        break;
      case "BB":
        imageToDisplay = BlackBishop();
        break;
      case "BQ":
        imageToDisplay = BlackQueen();
        break;
      case "BK":
        imageToDisplay = BlackKing();
        break;
      default:
        imageToDisplay = WhitePawn();
    }

    return imageToDisplay;
  }
}
