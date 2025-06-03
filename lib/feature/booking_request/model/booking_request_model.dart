import 'package:demandium_serviceman/feature/booking_details/model/booking_details_model.dart';

class BookingRequestModel {
  String? id;
  String? readableId;
  String? zoneId;
  String? bookingStatus;
  String? serviceSchedule;
  int? isPaid;
  String? paymentMethod;
  double? totalBookingAmount;
  double? totalTaxAmount;
  double? totalDiscountAmount;
  String? createdAt;
  String? updatedAt;
  String? subCategoryId;
  double? totalCampaignDiscountAmount;
  double? totalCouponDiscountAmount;
  int? isGuest;
  int? isRepeatBooking;
  List<RepeatBooking>? repeatBookingList;
  SubCategory? subCategory;


  BookingRequestModel({
    this.id,
    this.readableId,
    this.zoneId,
    this.bookingStatus,
    this.isPaid,
    this.paymentMethod,
    this.totalBookingAmount,
    this.totalTaxAmount,
    this.totalDiscountAmount,
    this.createdAt,
    this.updatedAt,
    this.subCategoryId,
    this.totalCampaignDiscountAmount,
    this.totalCouponDiscountAmount,
    this.isGuest,
    this.isRepeatBooking,
    this.repeatBookingList,
    this.subCategory,
    this.serviceSchedule,
  });

  BookingRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'].toString();
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    totalBookingAmount = double.tryParse(json['total_booking_amount'].toString());
    totalTaxAmount = double.tryParse(json['total_tax_amount'].toString());
    totalDiscountAmount = double.tryParse(json['total_discount_amount'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategoryId = json['sub_category_id'];
    totalCampaignDiscountAmount = double.tryParse(json['total_campaign_discount_amount'].toString());
    totalCouponDiscountAmount = double.tryParse(json['total_coupon_discount_amount'].toString());
    isGuest = int.tryParse(json['is_guest'].toString());
    isRepeatBooking = int.tryParse(json['is_repeated'].toString());
    serviceSchedule = json['service_schedule'];
    if (json['repeats'] != null) {
      repeatBookingList = <RepeatBooking>[];
      json['repeats'].forEach((v) {
        repeatBookingList!.add(RepeatBooking.fromJson(v));
      });
    }
    subCategory = json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['zone_id'] = zoneId;
    data['booking_status'] = bookingStatus;
    data['is_paid'] = isPaid;
    data['payment_method'] = paymentMethod;
    data['total_booking_amount'] = totalBookingAmount;
    data['total_tax_amount'] = totalTaxAmount;
    data['total_discount_amount'] = totalDiscountAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sub_category_id'] = subCategoryId;
    data['total_campaign_discount_amount'] = totalCampaignDiscountAmount;
    data['total_coupon_discount_amount'] = totalCouponDiscountAmount;
    data['is_guest'] = isGuest;
    data['is_repeated'] = isRepeatBooking;
    if (repeatBookingList != null) {
      data['repeats'] = repeatBookingList!.map((v) => v.toJson()).toList();
    }
    if (subCategory != null) {
      data['sub_category'] = subCategory!.toJson();
    }

    return data;
  }
}

class RepeatBooking {
  String? id;
  String? readableId;
  String? bookingId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  double? totalBookingAmount;
  double? totalTaxAmount;
  double? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? servicemanId;
  String? categoryId;
  String? subcategoryId;
  List<ItemService>? details;
  List<ScheduleHistories>? scheduleHistories;
  List<StatusHistories>? statusHistories;
  List<PartialPayment>? partialPayments;
  ServiceAddress? serviceAddress;
  String ? totalCampaignDiscountAmount;
  String ? totalCouponDiscountAmount;
  double ? additionalCharge;
  List<String>? photoEvidence;
  List<String>? photoEvidenceFullPath;
  double? extraFee;
  int? isGuest;
  double ? totalReferralDiscountAmount;

  RepeatBooking({
    this.id,
    this.readableId,
    this.bookingId,
    this.customerId,
    this.providerId,
    this.zoneId,
    this.bookingStatus,
    this.isPaid,
    this.paymentMethod,
    this.transactionId,
    this.totalBookingAmount,
    this.totalTaxAmount,
    this.totalDiscountAmount,
    this.serviceSchedule,
    this.serviceAddressId,
    this.createdAt,
    this.updatedAt,
    this.servicemanId,
    this.details,
    this.scheduleHistories,
    this.statusHistories,
    this.partialPayments,
    this.serviceAddress,
    this.totalCampaignDiscountAmount,
    this.totalCouponDiscountAmount,
    this.additionalCharge,
    this.photoEvidence,
    this.photoEvidenceFullPath,
    this.extraFee,
    this.isGuest,
    this.totalReferralDiscountAmount,
    this.categoryId,
    this.subcategoryId,
  });

  RepeatBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'].toString();
    bookingId = json['booking_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalBookingAmount = double.tryParse(json['total_booking_amount'].toString());
    totalTaxAmount = double.tryParse(json['total_tax_amount'].toString());
    totalDiscountAmount = double.tryParse(json['total_discount_amount'].toString());
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    servicemanId = json['serviceman_id'];
    categoryId = json['category_id'];
    subcategoryId = json['sub_category_id'];
    if (json['detail'] != null) {
      details = <ItemService>[];
      json['detail'].forEach((v) {
        details!.add(ItemService.fromJson(v));
      });
    }
    if (json['schedule_histories'] != null) {
      scheduleHistories = <ScheduleHistories>[];
      json['schedule_histories'].forEach((v) {
        scheduleHistories!.add(ScheduleHistories.fromJson(v));
      });
    }
    if (json['status_histories'] != null) {
      statusHistories = <StatusHistories>[];
      json['status_histories'].forEach((v) {

        statusHistories!.add(StatusHistories.fromJson(v));
      });
    }

    if (json['booking_partial_payments'] != null) {
      partialPayments = <PartialPayment>[];
      json['booking_partial_payments'].forEach((v) {
        partialPayments!.add(PartialPayment.fromJson(v));
      });
    }

    serviceAddress = json['service_address'] != null
        ? ServiceAddress.fromJson(json['service_address'])
        : null;
    totalCampaignDiscountAmount = json['total_campaign_discount_amount'].toString();
    totalCouponDiscountAmount =json['total_coupon_discount_amount'].toString();
    additionalCharge = double.tryParse(json['additional_charge'].toString());
    totalReferralDiscountAmount = double.tryParse(json['total_referral_discount_amount'].toString());
    photoEvidence = json["evidence_photos"]!=null? json["evidence_photos"].cast<String>(): [];
    photoEvidenceFullPath = json["evidence_photos_full_path"]!=null? json["evidence_photos_full_path"].cast<String>(): [];
    extraFee = double.tryParse(json["extra_fee"].toString());
    isGuest = int.tryParse(json["is_guest"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['booking_id'] = bookingId;
    data['customer_id'] = customerId;
    data['provider_id'] = providerId;
    data['zone_id'] = zoneId;
    data['booking_status'] = bookingStatus;
    data['is_paid'] = isPaid;
    data['payment_method'] = paymentMethod;
    data['transaction_id'] = transactionId;
    data['total_booking_amount'] = totalBookingAmount;
    data['total_tax_amount'] = totalTaxAmount;
    data['total_discount_amount'] = totalDiscountAmount;
    data['service_schedule'] = serviceSchedule;
    data['service_address_id'] = serviceAddressId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['serviceman_id'] = servicemanId;
    if (details != null) {
      data['detail'] = details!.map((v) => v.toJson()).toList();
    }
    if (scheduleHistories != null) {
      data['schedule_histories'] =
          scheduleHistories!.map((v) => v.toJson()).toList();
    }
    if (statusHistories != null) {
      data['status_histories'] =
          statusHistories!.map((v) => v.toJson()).toList();
    }
    if (serviceAddress != null) {
      data['service_address'] = serviceAddress!.toJson();
    }
    return data;
  }
}

class SubCategory {
  String? id;
  String? name;

  SubCategory({
    this.id,
    this.name,
  });

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}




