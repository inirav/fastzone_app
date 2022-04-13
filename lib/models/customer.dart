

class Customer {
    Customer({
       required this.id,
       required this.firstName,
       required this.lastName,
       required this.email,
       required this.phone,
       required this.addressType,
       required this.address,
       required this.locality,
       required this.city,
       required this.pincode
    });

    int id;
    String firstName;
    String lastName;
    String email;
    String phone;
    String addressType;
    String address;
    String locality;
    String city;
    String pincode;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        addressType: json["address_type"],
        address: json["address"],
        locality: json["locality"],
        city: json["city"],
        pincode: json["pincode"],
    );

}
