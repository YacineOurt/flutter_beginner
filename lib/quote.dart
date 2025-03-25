class Quote {
  String text;
  String author;
  bool isFavorite;
  String category;
  DateTime dateAdded;

  Quote({
    required this.text, 
    required this.author, 
    this.isFavorite = false,
    this.category = 'General',
    DateTime? dateAdded,
  }) : this.dateAdded = dateAdded ?? DateTime.now();
}