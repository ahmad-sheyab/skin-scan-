String? validatoremail(val) {
  if (val == null || val.trim().isEmpty) {
    return 'Field cannot be empty';
  }

  final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  if (!emailRegex.hasMatch(val.trim())) {
    return 'Invalid email format';
  }

  if (val.length < 5) {
    return 'Email is too short';
  }

  if (val.length > 254) {
    return 'Email is too long';
  }

  if (val.contains(' ')) {
    return 'Email cannot contain spaces';
  }
  return null;
}

String? validatorpass(val) {
  if (val == null || val.trim().isEmpty) {
    return 'Password cannot be empty';
  }
  if (val.length < 8) {
    return 'Password must be at least 8 characters';
  }
  if (val.length > 32) {
    return 'Password must be no more than 32 characters';
  }

  if (val.contains(' ')) {
    return 'Password cannot contain spaces';
  }
  List<String> commonPasswords = ['123456', 'password', '12345678', 'abc123'];
  if (commonPasswords.contains(val)) {
    return 'Password is too common';
  }
  return null;
}

String? validatordata(val) {
  if (val == null || val.trim().isEmpty) {
    return 'Field cannot be empty';
  }
  return null;
}
