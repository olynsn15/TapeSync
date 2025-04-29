class Purchase {
  final int tapeId;
  final int quantity;

  Purchase({
    required this.tapeId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'TapeID': tapeId,
      'Quantity': quantity,
    };
  }
}
