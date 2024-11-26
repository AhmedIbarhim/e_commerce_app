import 'package:ecommerce_app/bloc/App_Cubit/app_cubit.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/models/home_model.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/shared/widgets/button.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:ecommerce_app/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';

class AlterSearchScreen extends StatefulWidget {
  AlterSearchScreen({super.key});

  @override
  State<AlterSearchScreen> createState() => _AlterSearchScreenState();
}

class _AlterSearchScreenState extends State<AlterSearchScreen> {
  List<Products> searchList = [];

  var textController = TextEditingController();

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
            title: Text('Search', style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                TextField(
                  controller: textController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Search Here",
                    prefixIcon: Icon(Icons.search),
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.3)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onChanged: (value) {
                    cubit.postSearch(text: value);
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                // BuildButton(
                //     height: height*0.07,
                //     width: width*0.3,
                //     text: 'Search',
                //     color: AppColor.primaryColor,
                //     function: (){
                //       setState(() {
                //         cubit.postSearch(text: textController.toString());
                //       });
                //     }
                // ),
                cubit.searchModel == null
                    ? Center(
                        child: Icon(
                          Icons.search,
                          color: AppColor.secondColor.withOpacity(0.3),
                          size: 150,
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: height * 0.37,
                            crossAxisCount: 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              // onTap: (){
                              //   navigateTo(context, ProductDetailsScreen(product: cubit.searchModel!.data!.data[index],));
                              // },
                              child: SizedBox(
                                height: height * 0.4,
                                width: width * 0.5,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.2,
                                          width: width * 0.5,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: height * 0.2,
                                                child: buildCashedImage(
                                                    image: cubit
                                                        .searchModel!
                                                        .data!
                                                        .data[index]
                                                        .image,
                                                    fit: 'contain'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BuildText(
                                          text: cubit.searchModel!.data!
                                              .data[index].name!,
                                          maxLines: 2,
                                          overFlow: true,
                                          bold: true,
                                          color: AppColor.primaryColor,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BuildText(
                                              text:
                                                  '${cubit.searchModel!.data!.data[index].price.toString()} EGP',
                                              size: 16,
                                              bold: true,
                                            ),
                                            const Spacer(),
                                            // InkWell(
                                            //   onTap: (){
                                            //     cubit.changeFavouriteInProducts(index: index);
                                            //     cubit.postChangeFavourite(id: cubit.searchModel!.data!.data[index].id!);
                                            //   },
                                            //   child: Icon(
                                            //       cubit.searchModel!.data!.data[index].? Icons.favorite : Icons.favorite_outline,
                                            //       color: searchList[index].inFavourites!? Colors.red : Colors.grey),
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: cubit.searchModel!.data!.data.length,
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
