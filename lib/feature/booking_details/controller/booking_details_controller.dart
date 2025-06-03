// import 'package:get/get.dart';
// import 'package:demandium_serviceman/utils/core_export.dart';
//
//
// class BookingDetailsController extends GetxController implements GetxService {
//   final BookingDetailsRepo bookingDetailsRepo;
//   BookingDetailsController({required this.bookingDetailsRepo});
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String _otp = '';
//   String get otp => _otp;
//
//   bool _isUpdate = false;
//   bool get isUpdate => _isUpdate;
//
//   String _dropDownValue= "";
//   String get dropDownValue => _dropDownValue;
//
//   bool _isWrongOtpSubmitted = false;
//   bool get isWrongOtpSubmitted => _isWrongOtpSubmitted;
//
//   ScrollController scrollController  = ScrollController();
//   ScrollController completedServiceImagesScrollController  = ScrollController();
//
//   BookingDetailsModel? _bookingDetails;
//   BookingDetailsModel? get bookingDetails => _bookingDetails;
//
//   bool _showPhotoEvidenceField = false;
//   bool get showPhotoEvidenceField => _showPhotoEvidenceField;
//
//   List<XFile> _photoEvidence = [];
//   List<XFile> get pickedPhotoEvidence => _photoEvidence;
//
//   bool _hideResendButton = false;
//   bool get hideResendButton => _hideResendButton;
//
//   final List<MultipartBody> _selectedIdentityImageList = [];
//   List<MultipartBody> get selectedIdentityImageList => _selectedIdentityImageList;
//
//   var bookingPageCurrentState = BookingDetailsTabControllerState.bookingDetails;
//
//   final TextEditingController review = TextEditingController();
//
//   final List<Tab> myTabs = <Tab>[
//     Tab(text: 'booking_details'.tr),
//     Tab(text: 'status'.tr),
//   ];
//
//   final List<String> statusTypeList = [ "ongoing", "completed" , "canceled"];
//
//
//   Future<void> getBookingDetails({required String bookingID, required bool isSubBooking}) async {
//
//     Response response = await bookingDetailsRepo.getBookingDetails(bookingID: bookingID, isSubBooking: isSubBooking);
//
//     if(response.statusCode == 200 ){
//
//       _bookingDetails = BookingDetailsModel.fromJson(response.body);
//
//       Get.find<BookingEditController>().getServiceListBasedOnSubcategory(
//         subCategoryId : bookingDetails?.bookingContent?.bookingDetailsContent?.subCategoryId ??   bookingDetails?.bookingContent?.bookingDetailsContent?.subBooking?.subCategoryId ?? "",
//       );
//
//       //Get.find<BookingEditController>().initializedControllerValue( isSubBooking ? _bookingDetails?.bookingContent?.bookingDetailsContent?.subBooking : _bookingDetails?.bookingContent?.bookingDetailsContent);
//
//       _hideCanceledOption();
//
//
//     }
//     else{
//       ApiChecker.checkApi(response);
//     }
//     _isLoading = false;
//     update();
//   }
//
//   Future<bool> sendBookingOTPNotification(String? bookingId, {bool shouldUpdate = true}) async {
//     if(shouldUpdate){
//       _hideResendButton = true;
//       update();
//     }
//     Response response = await bookingDetailsRepo.sendBookingOTPNotification(bookingId);
//     bool isSuccess;
//     if(response.statusCode == 200) {
//       isSuccess = true;
//     }else {
//       ApiChecker.checkApi(response);
//       isSuccess = false;
//     }
//     _hideResendButton = false;
//     update();
//     return isSuccess;
//   }
//
//
//   void changeBookingStatus({required String bookingId, required String bookingStatus, required isSubBooking,bool isBack = false} ) async{
//     _isUpdate = true;
//     update();
//
//     List<MultipartBody> multiParts = [];
//     for(XFile file in _photoEvidence) {
//       multiParts.add(MultipartBody('evidence_photos[]', file));
//     }
//
//     if(bookingStatus == 'ongoing' && _dropDownValue =='canceled'){
//       showCustomSnackBar('service_ongoing_can_not_cancel_booking'.tr, type: ToasterMessageType.info);
//     }
//     else{
//       Response response = await bookingDetailsRepo.changeBookingStatus(bookingID: bookingId, status: _dropDownValue, otp: otp , isSubBooking: isSubBooking, photoEvidence: multiParts);
//       if(response.statusCode==200 && response.body["response_code"]=="status_update_success_200"){
//
//         getBookingDetails(bookingID: bookingId, isSubBooking: isSubBooking);
//
//         if(isBack){
//           Get.back();
//         }
//         showCustomSnackBar(response.body['message'], type : ToasterMessageType.success);
//         Get.find<BookingRequestController>().getBookingList(
//           Get.find<BookingRequestController>().bookingStatusState.name.toLowerCase(),1,
//         );
//         Get.find<BookingRequestController>().getBookingHistory(
//           Get.find<BookingRequestController>().bookingHistoryStatus[ Get.find<BookingRequestController>().bookingHistorySelectedIndex],1,
//         );
//       }else if(response.statusCode==200 && response.body["response_code"] == "default_403"){
//         if(dropDownValue == "completed" && otp.isNotEmpty){
//           _isWrongOtpSubmitted  = true;
//         }
//       }
//       else{
//         showCustomSnackBar(response.body['message'] ?? response.statusText);
//       }
//     }
//     _isUpdate = false;
//     update();
//   }
//
//   void changePaymentStatus(String bookingId,String paymentStatus) async {
//     Response response = await bookingDetailsRepo.changePaymentStatus(bookingId,paymentStatus);
//     if(response.statusCode == 200){
//       showCustomSnackBar('successfully_paid'.tr,type : ToasterMessageType.success);
//     } else {
//       showCustomSnackBar(response.body['message']);
//     }
//     update();
//   }
//
// Future<void> serviceReview(String bookingId, String reviewText) async {
//   try {
//     _isLoading = true;
//     update();
//
//     // API call for review submission
//     Response response = await bookingDetailsRepo.serviceReview(bookingId, reviewText);
//
//     if (response.statusCode == 200) {
//       Get.find<BookingDetailsController>().getBookingDetails(
//         bookingID: bookingId ?? "",
//         isSubBooking: false,
//       );
//
//       showCustomSnackBar('Review submitted successfully'.tr, type: ToasterMessageType.success);
//
//
//     } else {
//       // Failure response
//       showCustomSnackBar(response.statusText ?? "Failed to submit review".tr, type: ToasterMessageType.error);
//     }
//   } catch (e) {
//     // Error case
//     showCustomSnackBar("Error: $e", type: ToasterMessageType.error);
//   } finally {
//     _isLoading = false;
//     update();
//   }
// }
//
//
// Future<void> refreshBookingDetails({required String bookingID, required bool isSubBooking}) async {
//   try {
//     // Fetch the updated booking details here
//     var updatedBookingDetails = await bookingDetailsRepo.getBookingDetails(
//       bookingID: bookingID, // Provide the bookingID
//       isSubBooking: isSubBooking, // Provide the isSubBooking flag
//     );
//
//     // Update the state with the new booking details
//     bookingDetails!.value = updatedBookingDetails; // Update observable value directly
//
//     // Trigger a UI rebuild (this happens automatically when using .value)
//     update();
//   } catch (e) {
//     showCustomSnackBar("Error refreshing booking details: $e", type: ToasterMessageType.error);
//   }
// }
//
//
//
//   void changePhotoEvidenceStatus({bool isUpdate = true , bool status = false}){
//     _showPhotoEvidenceField = status;
//     scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.ease);
//     if(isUpdate) {
//       update();
//     }
//   }
//
//   void updateServicePageCurrentState(BookingDetailsTabControllerState bookingDetaisTabControllerState){
//     bookingPageCurrentState = bookingDetaisTabControllerState;
//     update();
//   }
//
//   void setSelectedValue(String value){
//     _dropDownValue=value;
//     update();
//   }
//
//
//   Future<void> pickPhotoEvidence({required bool isRemove, required bool isCamera}) async {
//     if(isRemove) {
//       _photoEvidence = [];
//       _showPhotoEvidenceField = false;
//     }else {
//       XFile? xFile = await ImagePicker().pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery, imageQuality: 50);
//       if(xFile != null) {
//         _photoEvidence.add(xFile);
//         if(Get.isDialogOpen!){
//           Get.back();
//         }
//         changePhotoEvidenceStatus(isUpdate: false, status: true);
//         //completedServiceImagesScrollController.jumpTo(_photoEvidence.length * 120);
//
//       }
//       update();
//     }
//   }
//
//   void removePhotoEvidence(int index) {
//     _photoEvidence.removeAt(index);
//     update();
//   }
//
//   void setOtp(String otp) {
//     _otp = otp;
//     resetWrongOtpValue(shouldUpdate: false);
//     if(otp != '') {
//       update();
//     }
//   }
//
//   void resetWrongOtpValue({bool shouldUpdate = true}){
//     _isWrongOtpSubmitted = false;
//
//     if(shouldUpdate){
//       update();
//     }
//   }
//
//   _hideCanceledOption(){
//     if(Get.find<SplashController>().configModel?.content?.serviceManCanCancelBooking == 0 || _bookingDetails?.bookingContent?.providerServicemanCanCancelBooking == 0){
//       statusTypeList.remove('canceled');
//     }
//   }
//
//   bool isShowChattingButton(BookingDetailsContent? bookingDetails){
//     return ((bookingDetails != null) && (bookingDetails.bookingStatus == "pending"
//         || bookingDetails.bookingStatus == "accepted" || bookingDetails.bookingStatus == "ongoing" )
//         && (bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails)
//         && (bookingDetails.serviceman !=null || bookingDetails.customer != null));
//   }
//
//   void resetBookingDetailsValue(){
//     _photoEvidence = [];
//     _showPhotoEvidenceField = false;
//     bookingPageCurrentState = BookingDetailsTabControllerState.bookingDetails;
//     _bookingDetails = null;
//   }
// }

import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';

class BookingDetailsController extends GetxController implements GetxService {
  final BookingDetailsRepo bookingDetailsRepo;
  BookingDetailsController({required this.bookingDetailsRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _otp = '';
  String get otp => _otp;

  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;

  String _dropDownValue = "";
  String get dropDownValue => _dropDownValue;

  bool _isWrongOtpSubmitted = false;
  bool get isWrongOtpSubmitted => _isWrongOtpSubmitted;

  ScrollController scrollController = ScrollController();
  ScrollController completedServiceImagesScrollController = ScrollController();

  BookingDetailsModel? _bookingDetails;
  BookingDetailsModel? get bookingDetails => _bookingDetails;

  bool _showPhotoEvidenceField = false;
  bool get showPhotoEvidenceField => _showPhotoEvidenceField;

  List<XFile> _photoEvidence = [];
  List<XFile> get pickedPhotoEvidence => _photoEvidence;

  bool _hideResendButton = false;
  bool get hideResendButton => _hideResendButton;

  final List<MultipartBody> _selectedIdentityImageList = [];
  List<MultipartBody> get selectedIdentityImageList => _selectedIdentityImageList;

  var bookingPageCurrentState = BookingDetailsTabControllerState.bookingDetails;

  final TextEditingController review = TextEditingController();

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'booking_details'.tr),
    Tab(text: 'status'.tr),
  ];

  final List<String> statusTypeList = ["ongoing", "completed", "canceled"];

  @override
  void onInit() {
    super.onInit();
    // Reset dropdown
    _dropDownValue = '';
  }

  @override
  void onClose() {
    // Reset values
    resetBookingDetailsValue();
    scrollController.dispose();
    completedServiceImagesScrollController.dispose();
    review.dispose();
    super.onClose();
  }

  Future<void> getBookingDetails({required String bookingID, required bool isSubBooking}) async {
    _isLoading = true;
    update();

    Response response = await bookingDetailsRepo.getBookingDetails(bookingID: bookingID, isSubBooking: isSubBooking);

    if (response.statusCode == 200) {
      _bookingDetails = BookingDetailsModel.fromJson(response.body);
      // Reset dropdown
      _dropDownValue = _bookingDetails?.bookingContent?.bookingDetailsContent?.bookingStatus ?? '';

      Get.find<BookingEditController>().getServiceListBasedOnSubcategory(
        subCategoryId: _bookingDetails?.bookingContent?.bookingDetailsContent?.subCategoryId ??
            _bookingDetails?.bookingContent?.bookingDetailsContent?.subBooking?.subCategoryId ?? "",
      );

      _hideCanceledOption();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<bool> sendBookingOTPNotification(String? bookingId, {bool shouldUpdate = true}) async {
    if (shouldUpdate) {
      _hideResendButton = true;
      update();
    }
    Response response = await bookingDetailsRepo.sendBookingOTPNotification(bookingId);
    bool isSuccess;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      isSuccess = false;
    }
    _hideResendButton = false;
    update();
    return isSuccess;
  }

  void changeBookingStatus({
    required String bookingId,
    required String bookingStatus,
    required bool isSubBooking,
    bool isBack = false,
  }) async {
    _isUpdate = true;
    update();

    List<MultipartBody> multiParts = [];
    for (XFile file in _photoEvidence) {
      multiParts.add(MultipartBody('evidence_photos[]', file));
    }

    if (bookingStatus == 'ongoing' && _dropDownValue == 'canceled') {
      showCustomSnackBar('service_ongoing_can_not_cancel_booking'.tr, type: ToasterMessageType.info);
    } else {
      Response response = await bookingDetailsRepo.changeBookingStatus(
        bookingID: bookingId,
        status: _dropDownValue,
        otp: otp,
        isSubBooking: isSubBooking,
        photoEvidence: multiParts,
      );
      if (response.statusCode == 200 && response.body["response_code"] == "status_update_success_200") {
        // Reset dropdown
        _dropDownValue = '';
        await getBookingDetails(bookingID: bookingId, isSubBooking: isSubBooking);

        if (isBack) {
          Get.back();
        }
        showCustomSnackBar(response.body['message'], type: ToasterMessageType.success);
        Get.find<BookingRequestController>().getBookingList(
          Get.find<BookingRequestController>().bookingStatusState.name.toLowerCase(),
          1,
        );
        Get.find<BookingRequestController>().getBookingHistory(
          Get.find<BookingRequestController>().bookingHistoryStatus[
          Get.find<BookingRequestController>().bookingHistorySelectedIndex],
          1,
        );
      } else if (response.statusCode == 200 && response.body["response_code"] == "default_403") {
        if (_dropDownValue == "completed" && otp.isNotEmpty) {
          _isWrongOtpSubmitted = true;
        }
      } else {
        showCustomSnackBar(response.body['message'] ?? response.statusText);
      }
    }
    _isUpdate = false;
    update();
  }

  void changePaymentStatus(String bookingId, String paymentStatus) async {
    Response response = await bookingDetailsRepo.changePaymentStatus(bookingId, paymentStatus);
    if (response.statusCode == 200) {
      showCustomSnackBar('successfully_paid'.tr, type: ToasterMessageType.success);
    } else {
      showCustomSnackBar(response.body['message']);
    }
    update();
  }

  Future<void> serviceReview(String bookingId, String reviewText) async {
    try {
      _isLoading = true;
      update();

      Response response = await bookingDetailsRepo.serviceReview(bookingId, reviewText);

      if (response.statusCode == 200) {
        await getBookingDetails(bookingID: bookingId, isSubBooking: false);
        showCustomSnackBar('Review submitted successfully'.tr, type: ToasterMessageType.success);
      } else {
        showCustomSnackBar(response.statusText ?? "Failed to submit review".tr,
            type: ToasterMessageType.error);
      }
    } catch (e) {
      showCustomSnackBar("Error: $e", type: ToasterMessageType.error);
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> refreshBookingDetails({required String bookingID, required bool isSubBooking}) async {
    try {
      Response response = await bookingDetailsRepo.getBookingDetails(
        bookingID: bookingID,
        isSubBooking: isSubBooking,
      );

      if (response.statusCode == 200) {
        _bookingDetails = BookingDetailsModel.fromJson(response.body);
        _dropDownValue = _bookingDetails?.bookingContent?.bookingDetailsContent?.bookingStatus ?? '';
        update();
      } else {
        showCustomSnackBar("Failed to refresh booking details", type: ToasterMessageType.error);
      }
    } catch (e) {
      showCustomSnackBar("Error refreshing booking details: $e", type: ToasterMessageType.error);
    }
  }

  void changePhotoEvidenceStatus({bool isUpdate = true, bool status = false}) {
    _showPhotoEvidenceField = status;
    if (status) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
    }
    if (isUpdate) {
      update();
    }
  }

  void updateServicePageCurrentState(BookingDetailsTabControllerState bookingDetaisTabControllerState) {
    bookingPageCurrentState = bookingDetaisTabControllerState;
    update();
  }

  void setSelectedValue(String value) {
    _dropDownValue = value;
    update();
  }

  Future<void> pickPhotoEvidence({required bool isRemove, required bool isCamera}) async {
    if (isRemove) {
      _photoEvidence = [];
      _showPhotoEvidenceField = false;
    } else {
      XFile? xFile = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );
      if (xFile != null) {
        _photoEvidence.add(xFile);
        if (Get.isDialogOpen!) {
          Get.back();
        }
        changePhotoEvidenceStatus(isUpdate: false, status: true);
      }
    }
    update();
  }

  void removePhotoEvidence(int index) {
    _photoEvidence.removeAt(index);
    update();
  }

  void setOtp(String otp) {
    _otp = otp;
    resetWrongOtpValue(shouldUpdate: false);
    if (otp.isNotEmpty) {
      update();
    }
  }

  void resetWrongOtpValue({bool shouldUpdate = true}) {
    _isWrongOtpSubmitted = false;
    if (shouldUpdate) {
      update();
    }
  }

  void _hideCanceledOption() {
    if (Get.find<SplashController>().configModel?.content?.serviceManCanCancelBooking == 0 ||
        _bookingDetails?.bookingContent?.providerServicemanCanCancelBooking == 0) {
      statusTypeList.remove('canceled');
    }
  }

  bool isShowChattingButton(BookingDetailsContent? bookingDetails) {
    return (bookingDetails != null &&
        (bookingDetails.bookingStatus == "pending" ||
            bookingDetails.bookingStatus == "accepted" ||
            bookingDetails.bookingStatus == "ongoing") &&
        bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails &&
        (bookingDetails.serviceman != null || bookingDetails.customer != null));
  }

  void resetBookingDetailsValue() {
    _photoEvidence = [];
    _showPhotoEvidenceField = false;
    _dropDownValue = ''; // Reset dropdown
    bookingPageCurrentState = BookingDetailsTabControllerState.bookingDetails;
    _bookingDetails = null;
    _otp = '';
    _isWrongOtpSubmitted = false;
    update();
  }
}