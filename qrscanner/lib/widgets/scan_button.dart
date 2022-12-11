import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/themes/theme.dart';
import 'package:qrscanner/utils/launch_scan_url.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: AppTheme.secundary,
        radius: 30,
        child: IconButton(
          icon: const Icon(
            Icons.filter_center_focus,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () async {
            String barcode = await FlutterBarcodeScanner.scanBarcode(
                '#3D8BEF', 'Cancel', false, ScanMode.QR);
            final scanListProvider =
                Provider.of<ScanListProvider>(context, listen: false);

            final scan = await scanListProvider.newScan(barcode);

            launchScanUrl(context, scan);
          },
        ));
  }
}
