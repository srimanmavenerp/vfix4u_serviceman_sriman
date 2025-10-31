import 'dart:convert';
import 'package:demandium_serviceman/common/widgets/maintenance_screen.dart';
import 'package:demandium_serviceman/feature/conversation/view/conversation_list_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String update = '/update';
  static const String profile = '/profile';
  static const String profileInformation = '/profile-information';
  static const String bankInfo = '/bank-info';
  static const String mySubscription = '/my-subscription';
  static const String html = '/html';
  static const String bookingDetails = '/booking-details';
  static const String chatScreen = '/chat-screen';
  static const String chatInbox = '/chat-inbox';
  static const String notification = '/notification';
  static const String bookingRequest = '/booking-request';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String maintenanceRoute = '/maintenance-screen';


  static String getInitialRoute() => initial;
  static String getSplashRoute({NotificationBody? body}) {
    String data = 'null';
    if(body != null) {
      List<int> encoded = utf8.encode(jsonEncode(body));
      data = base64Encode(encoded);
    }
    return '$splash?data=$data';
  }
  static String getLanguageRoute() => language;
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getChatScreenRoute(String channelId,String name,String image,String phone,String userType, {String? fromNotification}) =>
      '$chatScreen?channelID=$channelId&name=$name&image=$image&phone=$phone&userType=$userType&fromNotification=$fromNotification';
  static String getInboxScreenRoute({String? fromNotification}) => '$chatInbox?fromNotification=$fromNotification';



  static String getProfileRoute() => profile;
  static String getBankInfoRoute() => bankInfo;
  static String getMySubscriptionRoute() => mySubscription;
  static String getHtmlRoute(String page) => '$html?page=$page';
  // static String getHtmlRoute({String? page,String? fromPage}) => '$html?page=$page&fromPage=$fromPage';
  static String getBookingDetailsRoute({required String bookingId, bool? isSubBooking , String? fromPage}) =>
      '$bookingDetails?booking_id=$bookingId&fromPage=$fromPage&is_sub_booking=$isSubBooking';
  static String getBookingReqRoute() => bookingRequest;
  static String getForgotPasswordRoute() => forgotPassword;

  static String getVerificationRoute({required String identity,required String identityType, String? firebaseSession,}) {
    String data = Uri.encodeComponent(jsonEncode(identity));
    String session = base64Url.encode(utf8.encode(firebaseSession ?? ''));
    return '$verification?identity=$data&identity_type=$identityType&session=$session';
  }
  static String getChangePasswordRoute(String identity,String identityType ,String otp) {
    String identity0 = Uri.encodeComponent(jsonEncode(identity));
    String otp0 = Uri.encodeComponent(jsonEncode(otp));
    return '$changePassword?identity=$identity0&identity_type=$identityType&otp=$otp0';
  }

  static String getNotificationRoute() => notification;
  static String getMaintenanceRoute() => maintenanceRoute;


  static List<GetPage> routes = [
    GetPage(name: initial, page: () => getRoute(const BottomNavScreen(pageIndex: 0))),
    GetPage(name: splash,
        page: () {
          NotificationBody? data;
          if(Get.parameters['data'] != 'null') {
            List<int> decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
            data = NotificationBody.fromJson(jsonDecode(utf8.decode(decode)));
          }
          return SplashScreen(body: data);
        },
    ),

    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: notification, page: () => const NotificationScreen()),
    GetPage(name: signIn, page: () => const SignInScreen(exitFromApp: false,)),

    GetPage(
      name: bookingDetails, binding: BookingDetailsBinding(),
      page: () => getRoute(BookingDetailsScreen(
        bookingId: Get.parameters['booking_id']!,
        fromPage: Get.parameters['fromPage'],
        isSubBooking: Get.parameters['is_sub_booking'] == "true",
      )),
    ),

    GetPage(name: profileInformation, page: () => getRoute(const EditProfileScreen())),
    GetPage(name: bookingRequest, page: () => getRoute(const BookingListScreen())),

    GetPage( name: chatScreen, page: () => getRoute(ConversationDetailsScreen(
      channelID: Get.parameters['channelID']!,
      name: Get.parameters['name']!,
      phone: Get.parameters['phone']!,
      image: Get.parameters['image']!,
      userType: Get.parameters['userType']!,
      formNotification: Get.parameters['fromNotification'] ?? "",
    ))),

    GetPage(name: forgotPassword, page:() => getRoute(const ForgetPassScreen()),),

    GetPage(name: verification, page:() {
      String data = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));

      return VerificationScreen(
        identity: data,
        identityType: Get.parameters['identity_type']!,
        firebaseSession: Get.parameters['session'] == 'null' ? null
            : utf8.decode(base64Url.decode(Get.parameters['session'] ?? '')),
      );
    }),

    GetPage(name: changePassword, page:() {
      String identity0 = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));
      String otp0 = Uri.decodeComponent(jsonDecode(Get.parameters['otp']!));

      return NewPassScreen(
          identity: identity0,
          identityType:  Get.parameters['identity_type']!,
          otp: otp0
      );
    }),
    GetPage(name: language, page: () => const ChooseLanguageScreen()),
    GetPage(name: html, page: () => HtmlViewerScreen(
      htmlType: Get.parameters['page'] == 'terms-and-condition' ? HtmlType.termsAndCondition
      : Get.parameters['page'] == 'privacy-policy' ? HtmlType.privacyPolicy :Get.parameters['page'] == 'refund_policy' ?
      HtmlType.refundPolicy: Get.parameters['page'] == 'return_policy' ? HtmlType.returnPolicy:
      Get.parameters['page'] == 'cancellation_policy' ? HtmlType.cancellationPolicy :
      HtmlType.aboutUs,
    )),
    GetPage(name: chatInbox, page: () =>  ConversationListScreen(
      fromNotification: Get.parameters['fromNotification'],
    )),
    GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    GetPage(name: maintenanceRoute, page: () => const MaintenanceScreen()),
  ];

  static getRoute(Widget navigateTo) {

    return navigateTo;
  }
}