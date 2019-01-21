
import 'package:chess/chess.dart' as chess;

enum PieceType { Pawn, Rook, Knight, Bishop, Queen, King }

enum PieceColor {
  White,
  Black,
}

class ChessBoardController {
  chess.Chess game;
  Function refreshBoard;

  void makeMove(String from, String to) {
    game?.move({"from": from, "to": to});
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  void makeMoveWithPromotion(String from, String to, String pieceToPromoteTo) {
    game?.move({"from": from, "to": to, "promotion": pieceToPromoteTo});
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  void resetBoard() {
    game?.reset();
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  void clearBoard() {
    game?.clear();
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  void putPiece(PieceType piece, String square, PieceColor color) {
    game?.put(_getPiece(piece, color), square);
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  void loadPGN(String pgn) {
    game.load_pgn(pgn);
    refreshBoard == null ? this._throwNotAttachedException() : refreshBoard();
  }

  void _throwNotAttachedException() {
    throw Exception("Controller not attached to a ChessBoard widget!");
  }

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