import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> askNotificationPermission() async {
    var status = await Permission.notification.status;

    if (!status.isGranted) {
      await Permission.notification.request();
    }

    return await Permission.notification.status.isGranted;
  }
}
