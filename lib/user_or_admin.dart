class UserOrAdmin {
  static bool? _isUser;

  static bool? get isUser => _isUser;

  static set isUser(bool? value) {
    _isUser = value;
  }
}