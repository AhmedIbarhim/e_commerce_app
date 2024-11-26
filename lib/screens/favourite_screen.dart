import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/App_Cubit/app_cubit.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
            body: cubit.favouriteModel == null
                ? buildLoadingWidget()
                : cubit.favouriteModel!.data!.details!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.grey.withOpacity(0.1),
                              size: 300,
                            ),
                            BuildText(
                              text: 'No Favourites',
                              size: 20,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: SizedBox(
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
                                                  .favouriteModel!
                                                  .data!
                                                  .details![index]
                                                  .product!
                                                  .image,
                                              fit: 'contain'),
                                        ),
                                        BuildText(
                                          text: cubit.favouriteModel!.data!
                                              .details![index].product!.price!
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
                                            text: cubit.favouriteModel!.data!
                                                .details![index].product!.name!,
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
                                                  .favouriteModel!
                                                  .data!
                                                  .details![index]
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
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cubit.postChangeCart(
                                                        id: cubit
                                                            .favouriteModel!
                                                            .data!
                                                            .details![index]
                                                            .product!
                                                            .id!);
                                                  });
                                                },
                                                icon: Icon(
                                                  !cubit.cart.contains(cubit
                                                          .favouriteModel!
                                                          .data!
                                                          .details![index]
                                                          .product!
                                                          .id)
                                                      ? Icons.add_shopping_cart
                                                      : Icons
                                                          .remove_shopping_cart,
                                                  color: !cubit.cart.contains(
                                                          cubit
                                                              .favouriteModel!
                                                              .data!
                                                              .details![index]
                                                              .product!
                                                              .id)
                                                      ? AppColor.myBlueColor
                                                      : Colors.grey,
                                                  size: 35,
                                                ),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {
                                                  cubit
                                                      .postChangeFavourite(
                                                          id: cubit
                                                              .favouriteModel!
                                                              .data!
                                                              .details![index]
                                                              .product!
                                                              .id!)
                                                      .then((value) {
                                                    cubit.getHomeData();
                                                  });
                                                  setState(() {
                                                    cubit.favouriteModel!.data!
                                                        .details!
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
                            ),
                          );
                        },
                        itemCount: cubit.favouriteModel!.data!.details!.length,
                      ));
      },
    );
  }
}
