import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:ecommerce_app/bloc/App_Cubit/app_cubit.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/models/home_model.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/widgets/text.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products product;
  ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  CarouselSliderController carouselController = CarouselSliderController();

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
            title: BuildText(
              text: 'product details',
              color: Colors.white,
              bold: true,
              size: 20,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.3,
                    width: width,
                    child: Stack(
                      children: [
                        BuildCarouselSlider(
                            width: width,
                            height: height * 0.3,
                            carouselController: carouselController,
                            cubit: cubit,
                            length: widget.product.images!.length,
                            items: widget.product.images)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: cubit.currentIndexSlider,
                      count: widget.product.images!.length,
                      effect: const WormEffect(),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BuildText(
                    text: widget.product.name!,
                    bold: true,
                    color: AppColor.secondColor,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const Icon(
                        Icons.star_half,
                        color: Colors.yellow,
                      ),
                      BuildText(text: '  |  Reviews  123'),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BuildText(text: widget.product.description!),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BuildText(
                    text: '${widget.product.price!.toString()}  EGP',
                    size: 25,
                    color: AppColor.secondColor,
                    bold: true,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: BuildButton(
                        color: widget.product.inCart!
                            ? Colors.grey
                            : AppColor.secondColor,
                        height: height * 0.07,
                        width: width * 0.7,
                        text: widget.product.inCart!
                            ? 'Remove Item From Cart'
                            : 'Add Item To Cart',
                        function: () {
                          setState(() {
                            widget.product.inCart = !widget.product.inCart!;
                          });
                          cubit
                              .postChangeCart(id: widget.product.id!)
                              .then((value) {
                            cubit.getCart();
                          });
                        }),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
