import 'package:flutter/material.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/utils/launch_scan_url.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
              onDismissed: (direction) =>
                  {scanListProvider.deleteScansByID(scans[i].id!)},
              key: UniqueKey(),
              background: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.red,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text('Delete',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(type == 'http' ? Icons.web : Icons.map,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[i].value),
                subtitle: Text('ID: ${scans[i].id.toString()}'),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  launchScanUrl(context, scans[i]);
                },
              ),
            ));
  }
}
