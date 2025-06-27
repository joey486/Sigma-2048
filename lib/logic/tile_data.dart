class TileData {
  int value;
  int row;
  int col;
  String id;
  bool isNew;
  bool isMerged;

  TileData({
    required this.value,
    required this.row,
    required this.col,
    required this.id,
    this.isNew = false,
    this.isMerged = false,
  });
}
