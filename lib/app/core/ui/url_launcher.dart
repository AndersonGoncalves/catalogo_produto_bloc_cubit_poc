import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static void openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
