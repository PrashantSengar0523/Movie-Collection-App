class FormValidator {
  // Check if the field is empty
  static String? validateRequiredField(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Validate email format
  static String? validateEmail(String value) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validate password strength
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  // Validate phone number
  static String? validatePhoneNumber(String value) {
    final RegExp phoneRegExp = RegExp(r"^\d{10}$");
    if (value.isEmpty) {
      return 'Phone number is required';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }
}
