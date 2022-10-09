class ImageConstants {
  static ImageConstants? _instance;
  static ImageConstants get instance {
    _instance ??= ImageConstants._();
    return _instance!;
  }

  ImageConstants._();
  final String applicationIcon = 'icon/application_icon'.toPNG;
}

extension _ImageConstantsExtension on String {
  String get toPNG => 'assets/$this.png';
}
