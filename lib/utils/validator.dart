
class Validator {

  static String? validateRequired(value) {
    if (value.isEmpty) {
      return "This field is Required";
    }
    return null;
  }

  static String? validateName(value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "This field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Name";
    }
    return null;
  }

  static String? validatePinCode(value) {
    String pattern = r'^(?:[+0]9)?[0-9]{6}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "This field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Pincode";
    }
    return null;
  }

  static String? validateEmail(value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "This field is Required";
    } else if(!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String? validateMobile(value) {
    String pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "This field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Mobile Number";
    } else {
      return null;
    }
  }


}