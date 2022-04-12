
class Service {
    Service({
       required this.id,
       required this.name,
        this.image,
       required this.category,
    });

    int id;
    String name;
    String? image;
    int category;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        category: json["category"],
    );
}
