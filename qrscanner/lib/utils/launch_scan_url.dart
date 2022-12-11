import 'package:flutter/cupertino.dart';
import 'package:qrscanner/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchScanUrl(BuildContext context, ScanModel scan) async {
  final url = Uri.parse(scan.value);
  if (scan.type == 'http') {
    if (await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
    } else {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
