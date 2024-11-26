import 'package:dio/dio.dart';
import 'package:ecommerce_app/stripe_payment/stripe_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManager {
  static Future<void> makePayment(int amount, String currency) async {
    try {
      String clientSectret =
          await _getClientSecret((amount * 100).toString(), currency);
      await _initPaymentSheet(clientSectret);
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    String url = 'https://api.stripe.com/v1/payment_intents';
    var response = await dio.post(url,
        options: Options(headers: {
          'Authorization': 'Bearer ${StripeKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        }),
        data: {'amount': amount, 'currency': currency});
    return response.data['client_secret'];
  }

  static Future<void> _initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: 'Ahmed Ibrahim',
    ));
  }
}
