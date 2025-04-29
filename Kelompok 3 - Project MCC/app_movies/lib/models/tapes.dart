enum Genre { horror, thriller, romance, comedy, family, action, other }

class Tape {
  int id;
  String tapeTitle;
  String description;
  String tapePrice;
  int tapeYear;
  String tapeImage;
  Genre genre;
  double level;
  int quantity;

  Tape(
      {required this.id,
      required this.tapeTitle,
      required this.description,
      required this.tapePrice,
      required this.tapeImage,
      required this.tapeYear,
      required this.genre,
      required this.level,
      this.quantity = 1});

  factory Tape.fromJson(Map<String, dynamic> json) => Tape(
        id: json["id"] as int,
        tapeTitle: json["tape_title"].toString(),
        description: json["description"].toString(),
        tapePrice: json["tape_price"].toString(),
        tapeYear: json["tape_year"] as int,
        tapeImage: json["tape_image"].toString(),
        genre: _parseGenre(json["genre"].toString()),
        level: json["level"].toDouble(),
      );

  static Genre _parseGenre(String genreString) {
    switch (genreString.toLowerCase()) {
      case 'horror':
        return Genre.horror;
      case 'thriller':
        return Genre.thriller;
      case 'romance':
        return Genre.romance;
      case 'comedy':
        return Genre.comedy;
      case 'family':
        return Genre.family;
      case 'action':
        return Genre.action;
      default:
        return Genre.other;
    }
  }
}
