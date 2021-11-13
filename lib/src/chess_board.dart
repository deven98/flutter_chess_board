import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart' hide Color;
import 'package:chess/chess.dart' hide State;
import 'chess_board_controller.dart';
import 'constants.dart';

class ChessBoard extends StatefulWidget {
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

  final VoidCallback? onMove;

  const ChessBoard({
    Key? key,
    required this.controller,
    this.size,
    this.enableUserMoves = true,
    this.boardColor = BoardColor.brown,
    this.boardOrientation = PlayerColor.white,
    this.onMove,
  }) : super(key: key);

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Chess>(
      valueListenable: widget.controller,
      builder: (context, game, _) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: [
              AspectRatio(
                child: _getBoardImage(widget.boardColor),
                aspectRatio: 1.0,
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    var row = index ~/ 8;
                    var column = index % 8;
                    var boardRank = widget.boardOrientation == PlayerColor.black
                        ? '${row + 1}'
                        : '${(7 - row) + 1}';
                    var boardFile = widget.boardOrientation == PlayerColor.white
                        ? '${ranks[column]}'
                        : '${ranks[7 - column]}';

                    var squareName = '$boardFile$boardRank';
                    var pieceOnSquare = game.get(squareName);

                    var piece = BoardPiece(
                      squareName: squareName,
                      game: game,
                    );

                    var draggable = game.get(squareName) != null
                        ? Draggable<PieceMoveData>(
                            child: piece,
                            feedback: piece,
                            childWhenDragging: SizedBox(),
                            data: PieceMoveData(
                              squareName: squareName,
                              pieceType:
                                  pieceOnSquare?.type.toUpperCase() ?? 'P',
                              pieceColor: pieceOnSquare?.color ?? Color.WHITE,
                            ),
                          )
                        : Container();

                    var dragTarget =
                        DragTarget<PieceMoveData>(builder: (context, list, _) {
                      return draggable;
                    }, onWillAccept: (pieceMoveData) {
                      return widget.enableUserMoves ? true : false;
                    }, onAccept: (PieceMoveData pieceMoveData) async {
                      // A way to check if move occurred.
                      Color moveColor = game.turn;

                      if (pieceMoveData.pieceType == "P" &&
                          ((pieceMoveData.squareName[1] == "7" &&
                                  squareName[1] == "8" &&
                                  pieceMoveData.pieceColor == Color.WHITE) ||
                              (pieceMoveData.squareName[1] == "2" &&
                                  squareName[1] == "1" &&
                                  pieceMoveData.pieceColor == Color.BLACK))) {
                        var val = await _promotionDialog(context);

                        if (val != null) {
                          widget.controller.makeMoveWithPromotion(
                            from: pieceMoveData.squareName,
                            to: squareName,
                            pieceToPromoteTo: val,
                          );
                        } else {
                          return;
                        }
                      } else {
                        widget.controller.makeMove(
                          from: pieceMoveData.squareName,
                          to: squareName,
                        );
                      }
                      if (game.turn != moveColor) {
                        widget.onMove?.call();
                      }
                    });

                    return dragTarget;
                  },
                  itemCount: 64,
                  shrinkWrap: true,
                ),
              )
            ],
          ),
        );
      },
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

  /// Show dialog when pawn reaches last square
  Future<String?> _promotionDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Choose promotion'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                child: WhiteQueen(),
                onTap: () {
                  Navigator.of(context).pop("q");
                },
              ),
              InkWell(
                child: WhiteRook(),
                onTap: () {
                  Navigator.of(context).pop("r");
                },
              ),
              InkWell(
                child: WhiteBishop(),
                onTap: () {
                  Navigator.of(context).pop("b");
                },
              ),
              InkWell(
                child: WhiteKnight(),
                onTap: () {
                  Navigator.of(context).pop("n");
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      return value;
    });
  }
}

class BoardPiece extends StatelessWidget {
  final String squareName;
  final Chess game;

  const BoardPiece({
    Key? key,
    required this.squareName,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget imageToDisplay;
    var square = game.get(squareName);

    if (game.get(squareName) == null) {
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

class PieceMoveData {
  final String squareName;
  final String pieceType;
  final Color pieceColor;

  PieceMoveData({
    required this.squareName,
    required this.pieceType,
    required this.pieceColor,
  });
}
