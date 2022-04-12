
class Issue {
    Issue({
       required this.id,
       required this.title,
       required this.desc,
       required this.status,
       required this.service,
       required this.customer,
    });

    int id;
    String title;
    String desc;
    String status;
    int service;
    int customer;

    factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        status: json["status"],
        service: json["service"],
        customer: json["customer"],
    );

}
