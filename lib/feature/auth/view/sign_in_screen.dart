import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';


class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  const SignInScreen({super.key, required this.exitFromApp});

  @override
  SignInScreenState createState() => SignInScreenState();
}


class SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  String _countryDialCode='+880';
  bool _canExit = GetPlatform.isWeb ? true : false;
  bool _isTermsAccepted = false;
  void _showTermsAndConditionsDialog() {
    // Assuming you have the termsAndCondition data
    String termsAndCondition = 'Some terms and conditions content'; // Replace this with actual data

    if (termsAndCondition.isNotEmpty) {
      // If termsAndCondition is not empty, navigate to the page
      Get.toNamed(RouteHelper.getHtmlRoute('terms-and-condition'));
    } else {
      // Show a dialog with the terms and conditions content
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Terms and Conditions'.tr),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Here, you can add the terms and conditions content...'),
                  // Add dynamic content or sections if necessary
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'.tr),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  void initState(){
    super.initState();

    if(Get.find<SplashController>().configModel?.content != null){

      if(Get.find<AuthController>().getUserCountryCode()!=''){
        _countryDialCode = Get.find<AuthController>().getUserCountryCode();
      }else{
        _countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>()
            .configModel?.content?.countryCode ?? "BD").dialCode!;}
      }
    _phoneController.text =  Get.find<AuthController>().getUserNumber()
        .replaceFirst( Get.find<AuthController>().getUserCountryCode(), '');

    _passwordController.text = Get.find<AuthController>().getUserPassword();

    if(Get.find<AuthController>().getUserPassword() != "" && Get.find<AuthController>().getUserNumber() !=""){
      Get.find<AuthController>().toggleRememberMe(newValue: true, shouldUpdate: false);
    }else{
      Get.find<AuthController>().toggleRememberMe(newValue: false, shouldUpdate: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      onPopInvoked: () {
        if (_canExit) {
          exit(0);
        } else {
          showCustomSnackBar('back_press_again_to_exit'.tr, type : ToasterMessageType.info);
          _canExit = true;
          Timer(const Duration(seconds: 2), () {
            _canExit = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Center(
              child: GetBuilder<SplashController>(builder: (splashController) {
                return GetBuilder<AuthController>(builder: (authController) {
                  return Column(children: [
                    Image.asset(Images.newlogo,width: Dimensions.logoWidth,),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    CustomTextField(
                      hintText: 'phone_hint'.tr,
                      controller: _phoneController,
                      focusNode: _phoneFocus,
                      nextFocus: _passwordFocus,
                      inputType: TextInputType.phone,
                      countryDialCode: _countryDialCode,
                      onCountryChanged: (CountryCode countryCode) => _countryDialCode = countryCode.dialCode!,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomTextField(
                      title: 'password'.tr,
                      hintText: 'enter_your_password'.tr,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Theme.of(context).primaryColor,
                          value: _isTermsAccepted,
                          onChanged: (bool? value) {
                            setState(() {
                              _isTermsAccepted = value!;
                            });
                          },
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        RichText(
                          text: TextSpan(
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).textTheme.bodyMedium?.color,  // Use bodyMedium or bodyLarge
                            ),

                            children: [
                              TextSpan(
                                text: 'accept terms and conditions'.tr,
                                style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).primaryColor,  // Link style
                                  decoration: TextDecoration.underline, // Optional underline
                                ),
                                recognizer: TapGestureRecognizer()..onTap = _showTermsAndConditionsDialog,  // Add tap action
                              ),
                            ],
                          ),
                        )

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: () => authController.toggleRememberMe(),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  child: Checkbox(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: authController.isActiveRememberMe,
                                    onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                                Text(
                                  'remember_me'.tr,
                                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            horizontalTitleGap: 0,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(minimumSize: const Size(1, 40),backgroundColor: Theme.of(context).colorScheme.surface),
                          onPressed: () => Get.to(const ForgetPassScreen()),
                          child: Text('forgot_password?'.tr, style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.tertiary.withValues(alpha:0.8),)
                          ),
                        ),
                    ]),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomButton(
                      isLoading: authController.isLoading!,
                      btnTxt: 'sign_in'.tr,
                      onPressed: _isTermsAccepted ? () => _login(authController, _countryDialCode) : null, // Enable only if terms accepted
                    ),

                    const SizedBox(height: Dimensions.paddingSizeDefault),
                  ]);
                });
              }),
            ),
          ),
        )),
      ),
    );
  }


  void _login(AuthController authController, String countryDialCode) async {

    String password = _passwordController.text.trim();
    String phone = ValidationHelper.getValidPhone(countryDialCode+_phoneController.text, withCountryCode: true);

    if (_phoneController.text.isEmpty) {
      showCustomSnackBar('phone_hint'.tr, type: ToasterMessageType.info);
    }else if (phone == "") {
      showCustomSnackBar('invalid_phone_number'.tr, type: ToasterMessageType.info);
    }else if (password.isEmpty) {
      showCustomSnackBar('enter_password'.tr, type: ToasterMessageType.info);
    }else if (password.length < 8) {
      showCustomSnackBar('password_should_be'.tr, type: ToasterMessageType.info);
    }else {
      authController.login(phone, countryDialCode, phone, password).then((status) async {
      });
    }
  }
}
