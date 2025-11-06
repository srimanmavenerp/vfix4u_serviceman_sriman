import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:demandium_serviceman/common/widgets/demo_reset_dialog_widget.dart';
import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_provider/path_provider.dart';

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    // Initialize local notifications
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse? notificationResponse) async {
      try {
        if (Get.context != null) {
          PriceConverter.getCurrency(Get.context!);
        }

        if (notificationResponse?.payload != null &&
            notificationResponse!.payload!.isNotEmpty) {
          Map<String, dynamic> data;
          try {
            data = jsonDecode(notificationResponse.payload!);
          } catch (e) {
            if (kDebugMode) print("Failed to decode notification payload: $e");
            return;
          }

          NotificationBody notificationBody = NotificationBody.fromJson(data);
          _handleNotificationClick(notificationBody);
        }
      } catch (e) {
        if (kDebugMode) print("Error handling notification click: $e");
      }
    });

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final type = message.data['type'] ??
          message.notification?.title?.toLowerCase() ??
          'general';
      final title = message.data['title'] ?? message.notification?.title ?? '';
      final body = message.data['body'] ?? message.notification?.body ?? '';

      if (kDebugMode) {
        print(
            "onMessage: Notification Type => $type / Title => $title / Body => $body");
      }

      switch (type) {
        case 'chatting':
          _handleChatNotification(message, flutterLocalNotificationsPlugin);
          break;
        case 'maintenance':
          Get.find<SplashController>().getConfigData();
          break;
        case 'demo_reset':
          if (Get.find<SplashController>()
                  .configModel
                  ?.content
                  ?.appEnvironment ==
              "demo") {
            Get.dialog(const DemoResetDialogWidget(),
                barrierDismissible: false);
          }
          break;
        case 'general':
        default:
          showNotification(message, flutterLocalNotificationsPlugin, false);
          Get.find<NotificationController>().getNotifications(1);
          break;
      }
    });

    // Messages opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      try {
        if (Get.context != null) {
          PriceConverter.getCurrency(Get.context!);
        }

        if (message != null) {
          final Map<String, dynamic> data = message.data.isNotEmpty
              ? message.data
              : {
                  'title': message.notification?.title ?? '',
                  'body': message.notification?.body ?? '',
                  'type': 'general'
                };

          NotificationBody notificationBody = convertNotification(data);
          _handleNotificationClick(notificationBody);
        }
      } catch (e) {
        if (kDebugMode) print("Error opening notification: $e");
      }
    });
  }

  // Handle notification click
  static void _handleNotificationClick(NotificationBody notificationBody) {
    if (notificationBody.notificationType == "chatting" &&
        notificationBody.channelId?.isNotEmpty == true) {
      if (Get.currentRoute.contains(RouteHelper.chatScreen)) {
        Get.back();
        Get.back();
      } else if (Get.currentRoute.contains(RouteHelper.chatInbox)) {
        Get.back();
      }

      Get.toNamed(RouteHelper.getChatScreenRoute(
        notificationBody.channelId ?? "",
        notificationBody.userType == "supper-admin"
            ? "admin"
            : notificationBody.userName ?? "",
        notificationBody.userProfileImage ?? "",
        notificationBody.userPhone ?? "",
        notificationBody.userType ?? "",
        fromNotification: "fromNotification",
      ));
    } else if (notificationBody.notificationType == 'booking' &&
        notificationBody.bookingId?.isNotEmpty == true) {
      Get.toNamed(RouteHelper.getBookingDetailsRoute(
        bookingId: notificationBody.bookingId!,
        fromPage: 'fromNotification',
        isSubBooking: notificationBody.bookingType == "repeat",
      ));
    } else if (notificationBody.notificationType == 'privacy_policy' &&
        notificationBody.title?.isNotEmpty == true) {
      Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
    } else if (notificationBody.notificationType == 'terms_and_conditions' &&
        notificationBody.title?.isNotEmpty == true) {
      Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition"));
    } else {
      Get.toNamed(RouteHelper.getNotificationRoute());
    }
  }

  // Handle chat notifications
  static void _handleChatNotification(
      RemoteMessage message, FlutterLocalNotificationsPlugin fln) {
    final channelId = message.data['channel_id'] ?? '';
    if (channelId.isNotEmpty) {
      if (Get.currentRoute.contains(RouteHelper.chatScreen) &&
          channelId == Get.find<ConversationController>().channelId) {
        Get.find<ConversationController>().getConversation(channelId, 1);
      } else if (Get.currentRoute.contains(RouteHelper.chatInbox) ||
          Get.currentRoute.contains(RouteHelper.chatScreen)) {
        if (kDebugMode) print("User Type : ${message.data['user_type']}");
        showNotification(message, fln, false);

        final userType = message.data['user_type'] ?? '';
        if (userType == 'customer') {
          Get.find<ConversationController>().getChannelList(1);
        } else {
          Get.find<ConversationController>()
              .getChannelList(1, type: "provider");
        }
      } else {
        showNotification(message, fln, false);
      }
    } else {
      showNotification(message, fln, false);
    }
  }

  // Show notification
  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      final title = (message.data['title'] ??
              message.notification?.title ??
              'Notification')
          .replaceAll('_', ' ')
          .toString()
          .capitalize;
      final body = message.data['body'] ?? message.notification?.body ?? '';
      final image = (message.data['image'] != null &&
              (message.data['image'] as String).isNotEmpty)
          ? (message.data['image'] as String).startsWith('http')
              ? message.data['image']
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}'
          : null;
      final payload = jsonEncode(message.data.isNotEmpty
          ? message.data
          : {
              'title': message.notification?.title ?? '',
              'body': message.notification?.body ?? '',
              'type': 'general'
            });

      if (image != null && image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              title.toString(), body, payload, image, fln);
        } catch (_) {
          await showBigTextNotification(
              title: title.toString(), body: body, payload: payload, fln: fln);
        }
      } else {
        await showBigTextNotification(
            title: title.toString(), body: body, payload: payload, fln: fln);
      }
    }
  }

  // Show big text notification
  static Future<void> showBigTextNotification(
      {required String title,
      required String body,
      required String payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    final bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
      "demandium",
      AppConstants.appName,
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final notificationDetails = NotificationDetails(android: androidDetails);
    await fln.show(Random().nextInt(100), title, body, notificationDetails,
        payload: payload);
  }

  // Show big picture notification
  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String payload,
      String image,
      FlutterLocalNotificationsPlugin fln) async {
    final largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');

    final bigPictureStyle = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );

    final androidDetails = AndroidNotificationDetails(
      "demandium",
      AppConstants.appName,
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyle,
      importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );

    final notificationDetails = NotificationDetails(android: androidDetails);
    await fln.show(Random().nextInt(100), title, body, notificationDetails,
        payload: payload);
  }

  // Download and save notification image
  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  // Convert data to NotificationBody
  static NotificationBody convertNotification(Map<String, dynamic> data) {
    return NotificationBody.fromJson(data);
  }
}

@pragma('vm:entry-point')
Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(
        "onBackground: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
  }
}
