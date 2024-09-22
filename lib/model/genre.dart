class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  // Factory method to create a Genre object from a JSON map
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }

  // Method to convert a Genre object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}