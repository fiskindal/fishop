extension StringBoolExtension on String {
  bool get isTrue => bool.fromEnvironment(this);
}
