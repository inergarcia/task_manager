class User {
  int id;
  String name;
  String username;
  String role;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "role": role,
        "name": name,
      };
}
