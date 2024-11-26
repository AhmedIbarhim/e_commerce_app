import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/App_Cubit/app_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
            body: cubit.cartModel == null
                ? buildLoadingWidget()
                : cubit.cartModel!.data!.cartItems!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.grey.withOpacity(0.1),
                              size: 300,
                            ),
                            BuildText(
                              text: 'Cart Is Empty',
                              size: 20,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
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
                                      BuildText(
                                        text: cubit.cartModel!.data!
                                            .cartItems![index].product!.price!
                                            .toString(),
                                        bold: true,
                                        size: 20,
                                        color: AppColor.secondColor,
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
                                          text: cubit.cartModel!.data!
                                              .cartItems![index].product!.name!,
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
                                            IconButton(
                                              onPressed: () {
                                                cubit
                                                    .postChangeCart(
                                                        id: cubit
                                                            .cartModel!
                                                            .data!
                                                            .cartItems![index]
                                                            .product!
                                                            .id!)
                                                    .then((value) {
                                                  cubit.getHomeData();
                                                });
                                                setState(() {
                                                  cubit.cartModel!.data!
                                                      .cartItems!
                                                      .removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: AppColor.myRedColor,
                                                size: 35,
                                              ),
                                            )
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
                        itemCount: cubit.cartModel!.data!.cartItems!.length,
                      ));
      },
    );
  }
}
