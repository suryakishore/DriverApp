import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../global/global_var.dart';

class PushNotificationService
{
  static sendNotificationToSelectedDriver(String userName, String deviceToken, BuildContext context, String tripID, String fareAmt, String startAddress, String endAddress) async
  {

    Map<String, String> headerNotificationMap =
    {
      "Content-Type": "application/json",
      "Authorization": serverKeyFCM,
    };

    Map titleBodyNotificationMap =
    {
      "title": "TRIP COMPLETED from $userName",
      "body": "Please pay the amount: $fareAmt",
    };

    Map dataMapNotification =
    {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "tripID": tripID,
      "fareAmt": fareAmt,
      "startAddress": startAddress,
      "endAddress": endAddress
    };

    Map bodyNotificationMap =
    {
      "notification": titleBodyNotificationMap,
      "data": dataMapNotification,
      "priority": "high",
      "to": deviceToken,
    };

    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotificationMap,
      body: jsonEncode(bodyNotificationMap),
    );
  }
}