class UserModel {
  String? id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String profileImage; // Remove the underscore to make it accessible

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profileImage, // Ensure it's required in the constructor
  });

  // Convert a UserModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage, // Use directly here
    };
  }

  // Create a UserModel object from a JSON map
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      phone: data['phone'],
      profileImage: data['profileImage'],
    );
  }
}
