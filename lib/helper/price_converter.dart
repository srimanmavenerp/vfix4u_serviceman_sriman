import 'package:demandium_serviceman/common/models/service_details_model.dart';
import 'package:demandium_serviceman/feature/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class PriceConverter {

  static String currencySymbol ='';
  static String currencySymbolValue ='';
  static String getCurrency( BuildContext context) {
    currencySymbol =  Get.find<SplashController>().configModel?.content?.currencySymbol ?? "";
    return currencySymbol;
  }

  static String convertPrice(double? price, {double? discount, String? discountType, bool isShowLongPrice = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool isRightSide = Get.find<SplashController>().configModel?.content?.currencySymbolPosition == 'right';
    return isShowLongPrice == true ?'${isRightSide ? '' : currencySymbol}'
        '${(price!).toStringAsFixed(int.parse(Get.find<SplashController>().configModel?.content?.currencyDecimalPoint?? "2"))
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} '
        '${isRightSide ? currencySymbol : ''}' : '${isRightSide ? '' : currencySymbol}'
        '${longToShortPrice(price!)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} '
        '${isRightSide ? currencySymbol : ''}';

  }

  static double convertWithDiscount(double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : currencySymbol} OFF';
  }

  static Discount _getDiscount(List<ServiceDiscount>? serviceDiscountList, double? discountAmount, String? discountAmountType) {
    ServiceDiscount? serviceDiscount = (serviceDiscountList != null && serviceDiscountList.isNotEmpty) ?serviceDiscountList.first : null;
    if(serviceDiscount != null){
      double? getDiscount = serviceDiscount.discount?.discountAmount;
      if(getDiscount! > serviceDiscount.discount!.maxDiscountAmount! && serviceDiscount.discount!.discountType == 'percent') {
        getDiscount = serviceDiscount.discount!.maxDiscountAmount!;
      }
      discountAmount = (discountAmount! + getDiscount);
      discountAmountType = serviceDiscount.discount!.discountAmountType!;
    }

    return Discount(discountAmount: discountAmount, discountAmountType: discountAmountType);
  }

  static Discount discountCalculation(ServiceModel service, {bool addCampaign = false}) {
    double? discountAmount = 0;
    String? discountAmountType;

    if(service.serviceDiscount != null && service.serviceDiscount!.isNotEmpty) {

      Discount discount =  _getDiscount(service.serviceDiscount, discountAmount, discountAmountType);
      discountAmount = discount.discountAmount;

      discountAmountType = discount.discountAmountType;

    }else if(service.campaignDiscount != null && service.campaignDiscount!.isNotEmpty && addCampaign) {

      Discount discount =  _getDiscount(service.campaignDiscount, discountAmount, discountAmountType);
      discountAmount = discount.discountAmount;
      discountAmountType = discount.discountAmountType;
    }
    return Discount(discountAmount: discountAmount, discountAmountType: discountAmountType);
  }

  static String longToShortPrice(double amount){
    int decimalPoint = int.tryParse(Get.find<SplashController>().configModel?.content?.currencyDecimalPoint ?? "2") ?? 2 ;

    if (amount.abs() >= 1e12) {
      return '${(amount / 1e12).toStringAsFixed(decimalPoint)}T';
    } else if (amount.abs() >= 1e9) {
      return '${(amount / 1e9).toStringAsFixed(decimalPoint)}B';
    } else if (amount.abs() >= 1e6) {
      return '${(amount / 1e6).toStringAsFixed(decimalPoint)}M';
    } else if (amount.abs() >= 1e4) {
      return '${(amount / 1e3).toStringAsFixed(decimalPoint)}k';
    } else {
      return amount.toStringAsFixed(decimalPoint);
    }
  }

}