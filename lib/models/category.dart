
class Category {
    Category({required this.id, required this.name, this.image});

    int id;
    String name;
    String? image;
  
    factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"], name: json["name"], image: json["image"]);
}
