import 'package:awesome_icons/awesome_icons.dart';
import 'package:ecommerce_app/bloc/Authentication/auth_cubit.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/network/local/cash_helper.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:ecommerce_app/screens/total_price.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:badges/badges.dart' as badges;

import '../bloc/App_Cubit/app_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

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
                text: 'E_Commerce',
                bold: true,
                color: Colors.white,
              ),
              centerTitle: true,
              leading: PopupMenuButton(
                onSelected: (val) {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 25,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Row(
                      children: [
                        Text('Edit Profile'),
                        Spacer(),
                        Icon(Icons.person)
                      ],
                    ),
                    onTap: () {
                      AuthCubit.get(context).getProfileData();
                      navigateTo(context, ProfileScreen());
                    },
                  ),
                  PopupMenuItem(
                    child: const Row(
                      children: [Text('Log Out'), Spacer(), Icon(Icons.logout)],
                    ),
                    onTap: () {
                      CashHelper.removeData(key: 'token');
                      navigateTo(context, LoginScreen());
                    },
                  ),
                ],
              ),
              actions: [
                badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: AppColor.myRedColor,
                  ),
                  position: badges.BadgePosition.topEnd(top: -5, end: -3),
                  badgeContent: BuildText(
                    text: cubit.cartModel == null
                        ? ''
                        : cubit.cartModel!.data!.cartItems!.length.toString(),
                    color: Colors.white,
                    size: 12,
                  ),
                  child: IconButton(
                    onPressed: () {
                      navigateTo(context, const TotalPriceScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ]),
          body: // cubit.homeModel == null ? buildLoadingWidget() :
              cubit.myScreens[cubit.currentIndexScreen],
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            child: GNav(
              selectedIndex: 0,
              backgroundColor: Colors.transparent,
              hoverColor: AppColor.myRedColor,
              haptic: true,
              tabBorderRadius: 10,
              duration: const Duration(microseconds: 400),
              gap: width * 0.03,
              color: AppColor.myBlueColor,
              activeColor: Colors.white,
              iconSize: 20,
              tabBackgroundColor: AppColor.myBlueColor,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.015),
              tabs: const [
                GButton(icon: FontAwesomeIcons.home, text: 'Home'),
                GButton(icon: FontAwesomeIcons.shoppingBag, text: 'Category'),
                GButton(icon: FontAwesomeIcons.heart, text: 'Favorite'),
                GButton(icon: FontAwesomeIcons.shoppingBasket, text: 'Cart'),
              ],
              onTabChange: (index) {
                cubit.changeScreen(index);
              },
            ),
          ),
        );
      },
    );
  }
}
