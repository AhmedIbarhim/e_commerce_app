import 'package:ecommerce_app/bloc/App_Cubit/app_cubit.dart';
import 'package:ecommerce_app/bloc/Authentication/auth_cubit.dart';
import 'package:ecommerce_app/bloc/bloc_observer.dart';
import 'package:ecommerce_app/network/remote/dio_helper.dart';
import 'package:ecommerce_app/screens/home_layout.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'network/local/cash_helper.dart';
import 'stripe_payment/stripe_keys.dart';

void main() async {
  Stripe.publishableKey = StripeKeys.publishableKey;
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CashHelper.init();
  final myWidget;

  String? token = CashHelper.getData(key: 'token');

  if (token == null) {
    myWidget = LoginScreen();
  } else {
    myWidget = HomeLayout();
  }

  runApp(MyApp(
    widget: myWidget,
  ));
}

class MyApp extends StatelessWidget {
  final widget;
  const MyApp({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => AppCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getCart())
      ],
      child: MaterialApp(
          title: 'e_commerce sample',
          debugShowCheckedModeBanner: false,
          home: widget),
    );
  }
}
