

class Customer {
    Customer({
       required this.id,
       required this.fullName,
       this.organization,
       required this.email,
       required this.phone,
       required this.addressType,
       required this.address,
       required this.locality,
       required this.city,
       required this.pincode
    });

    int id;
    String fullName;
    String? organization;
    String email;
    String phone;
    String addressType;
    String address;
    String locality;
    String city;
    String pincode;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        fullName: json["full_name"],
        organization: json["organization"],
        email: json["email"],
        phone: json["phone"],
        addressType: json["address_type"],
        address: json["address"],
        locality: json["locality"],
        city: json["city"],
        pincode: json["pincode"],
    );

}
