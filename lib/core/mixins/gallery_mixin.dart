import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

mixin GalleryLaunch {
  final String _iosPhotoScheme = 'photos-redirect://';
  final String _androidPhotoScheme = 'content://media/external/images/media';

  Future<void> open() async {
    await launchUrl(
        Uri.parse(Platform.isIOS ? _iosPhotoScheme : _androidPhotoScheme));
  }
}
