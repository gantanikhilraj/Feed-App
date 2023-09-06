class User {
  String id;
  final String name;
  final String description;

  User({
    this.id = '',
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );
}
