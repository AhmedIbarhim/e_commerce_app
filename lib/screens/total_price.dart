import 'package:ecommerce_app/bloc/App_Cubit/app_cubit.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/widgets/button.dart';
import 'package:ecommerce_app/stripe_payment/payment_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/widgets/text.dart';

class TotalPriceScreen extends StatefulWidget {
  const TotalPriceScreen({super.key});

  @override
  State<TotalPriceScreen> createState() => _TotalPriceScreenState();
}

class _TotalPriceScreenState extends State<TotalPriceScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primaryColor,
          ),
          body: cubit.cartModel == null
              ? buildLoadingWidget()
              : cubit.cartModel!.data!.cartItems!.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.2,
                            width: width,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        BuildText(
                                          text: 'Total',
                                          color: Colors.black,
                                          bold: true,
                                          size: 25,
                                        ),
                                        const Spacer(),
                                        BuildText(
                                          text:
                                              '${cubit.cartModel!.data!.total.toString()} EGP',
                                          color: AppColor.secondColor,
                                          bold: true,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    BuildButton(
                                      height: height * 0.05,
                                      width: width * 0.9,
                                      color: AppColor.primaryColor,
                                      text: 'Complete Order',
                                      function: () {
                                        PaymentManager.makePayment(
                                            cubit.cartModel!.data!.total,
                                            "EGP");
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: height * 0.27,
                                  width: width,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 0.5,
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: width * 0.35,
                                              height: height * 0.15,
                                              child: buildCashedImage(
                                                  image: cubit
                                                      .cartModel!
                                                      .data!
                                                      .cartItems![index]
                                                      .product!
                                                      .image,
                                                  fit: 'contain'),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 6),
                                          child: Column(
                                            children: [
                                              BuildText(
                                                text: cubit
                                                    .cartModel!
                                                    .data!
                                                    .cartItems![index]
                                                    .product!
                                                    .name!,
                                                maxLines: 1,
                                                overFlow: true,
                                                bold: true,
                                                color: AppColor.primaryColor,
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              BuildText(
                                                  text: cubit
                                                      .cartModel!
                                                      .data!
                                                      .cartItems![index]
                                                      .product!
                                                      .description!,
                                                  maxLines: 4,
                                                  overFlow: true,
                                                  size: 12,
                                                  color: Colors.black),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  BuildText(
                                                    text: cubit
                                                        .cartModel!
                                                        .data!
                                                        .cartItems![index]
                                                        .product!
                                                        .price!
                                                        .toString(),
                                                    bold: true,
                                                    size: 20,
                                                    color: AppColor.secondColor,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  cubit.cartModel!.data!.cartItems!.length,
                            ),
                          )
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
