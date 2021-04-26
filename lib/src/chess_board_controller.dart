import 'package:chess/chess.dart' as chess;

enum PieceType { Pawn, Rook, Knight, Bishop, Queen, King }

enum PieceColor {
  White,
  Black,
}

/// Controller for programmatically controlling the board
class ChessBoardController {
  /// The game attached to the controller
  chess.Chess game;

  /// Function from the ScopedModel to refresh board
  Function refreshBoard;

  /// Makes move on the board
  void makeMove(String from, String to) {
    game?.move({"from": from, "to": to});
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  /// Makes move on the board
  void makeMoveWithNormalNotation(String move) {
    game?.move(move);
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  /// Makes move and promotes pawn to piece (from is a square like d4, to is also a square like e3, pieceToPromoteTo is a String like "Q".
  /// pieceToPromoteTo String will be changed to enum in a future update and this method will be deprecated in the future
  void makeMoveWithPromotion(String from, String to, String pieceToPromoteTo) {
    game?.move({"from": from, "to": to, "promotion": pieceToPromoteTo});
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  /// Resets square
  void resetBoard() {
    game?.reset();
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  /// Clears board
  void clearBoard() {
    game?.clear();
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  /// Puts piece on a square
  void putPiece(PieceType piece, String square, PieceColor color) {
    game?.put(_getPiece(piece, color), square);
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  /// Loads a PGN
  void loadPGN(String pgn) {
    game.load_pgn(pgn);
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  /// Exception when a controller is not attached to a board
  void _throwNotAttachedException() {
    throw Exception("Controller not attached to a ChessBoard widget!");
  }

  /// Gets respective piece
  chess.Piece _getPiece(PieceType piece, PieceColor color) {
    chess.Color _getColor(PieceColor color) {
      return color == PieceColor.White ? chess.Color.WHITE : chess.Color.BLACK;
    }

    switch (piece) {
      case PieceType.Bishop:
        return chess.Piece(chess.PieceType.BISHOP, _getColor(color));
      case PieceType.Queen:
        return chess.Piece(chess.PieceType.QUEEN, _getColor(color));
      case PieceType.King:
        return chess.Piece(chess.PieceType.KING, _getColor(color));
      case PieceType.Knight:
        return chess.Piece(chess.PieceType.KNIGHT, _getColor(color));
      case PieceType.Pawn:
        return chess.Piece(chess.PieceType.PAWN, _getColor(color));
      case PieceType.Rook:
        return chess.Piece(chess.PieceType.ROOK, _getColor(color));
    }

    return chess.Piece(chess.PieceType.PAWN, chess.Color.WHITE);
  }
}
