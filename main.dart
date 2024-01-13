import 'dart:math' as math;

import 'package:karend_app/app/controllers/adderss_controller.dart';
import 'package:karend_app/app/controllers/home_controller.dart';
import 'package:karend_app/app/controllers/market_categorie_controller.dart';
import 'package:karend_app/app/controllers/market_controller.dart';
import 'package:karend_app/app/controllers/market_details_controller.dart';
import 'package:karend_app/app/controllers/top_market_controller.dart';
import 'package:karend_app/app/modles/category.dart';
import 'package:karend_app/app/theme/light_color.dart';
import 'package:karend_app/app/view/componets/bottom_bar_curved.dart';
import 'package:karend_app/app/view/componets/cart_icon_component.dart';
import 'package:karend_app/app/view/componets/cloeseApp.dart';
import 'package:karend_app/app/view/componets/custom_pull_to_ref_footer.dart';
import 'package:karend_app/app/view/componets/image/smart_image.dart';
import 'package:karend_app/app/view/componets/open_chip_componet.dart';
import 'package:karend_app/app/view/componets/sharedWidget.dart';
import 'package:karend_app/app/view/screens/market/all_market_screen.dart';
import 'package:karend_app/app/view/screens/market/market_details_screen.dart';
import 'package:karend_app/app/view/screens/ofers/all_ofers_screen.dart';
import 'package:karend_app/app/view/screens/profile_screen.dart';
import 'package:karend_app/app/view/screens/suport_screen.dart';
import 'package:karend_app/base/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:karend_app/app/extensions/string_extension.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends BaseHomeScreen<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  @override
  bool get alwaysUseBuilder => true;
  setup() {
    Get.put(HomeController());
    Get.put(AdderssController());
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: CloseApp(context).onWillPop,
      child: Scaffold(
          // backgroundColor: const Color.fromARGB(255, 203, 156, 0),
          key: controller.keySearch,
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          drawer: gustDrawer(context),
          bottomNavigationBar: BottomBarCurvedComponet(),
          body: PageView(
            controller: controller.homePageController,
            onPageChanged: (index) {
              controller.pageindex.value = index;
              Get.find<MarketControlller>().closeSearch();
            },
            children: [
              _buildHome(context),
              AllMarketScreen(),
              SupportScreen(),
              AllOfferScreen(),
              ProfileScreen(),
            ],
          )),
    );
  }

  _buildHome(BuildContext context) {
    
    // final GetStorage box = GetStorage();
    // setupSettings() async {
    //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //   String appName = packageInfo.appName;
    //   String packageName = packageInfo.packageName;
    //   String version = packageInfo.version;
    //   String buildNumber = packageInfo.buildNumber;
    //   log('version: $version ::: ${box.read('settings')['version']}');
    //   box.read('settings')['version']! == null ? box.write('settings', {
    //     'appName': appName,
    //     'packageName': packageName,
    //     'version': version,
    //     'buildNumber': buildNumber
    //   }) : null;

    //   if (box.read('settings') != null &&
    //       version != box.read('settings')['version']) {
    //     Get.defaultDialog(
    //         title: "تحديثات البرنامج",
    //         content: Column(children: [
    //           Text("هناك تحديث جديد للبرنامج"),
    //         ]),
    //         onConfirm: () {
    //           Get.back();
    //         });
    //   }
    // }

    // setupSettings();

    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () => controller.openDrawer(),
                              child: SvgPicture.asset("assets/Icon/mnue.svg",
                                  color: LightColor.PrimaryDarkBlue,
                                  width: 40)),
                          Text('الرئيسية',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: LightColor.PrimaryDarkBlue)),
                          CartIconComponent(),
                        ],
                      ),
                      heightSpace,
                      SizedBox(
                        height: 0.5.h,
                      ),
                      controller.obx(
                        (state) {
                          bool isOpen =
                              controller.dataHome!.days!.status ?? false;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ساعات العمل تبدأ من ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: LightColor.black)),
                              Text(
                                  controller
                                      .dataHome!.days!.from.formateTimeOnly,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 11,
                                          color: LightColor.PrimaryDarkBlue)),
                              Text('الى',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 13,
                                          color: LightColor.black)),
                              Text(
                                  controller.dataHome!.days!.to.formateTimeOnly,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: 11,
                                          color: LightColor.PrimaryDarkBlue)),
                              OpenChipComponent(
                                isOpen: isOpen,
                              )
                            ],
                          );
                        },
                        onLoading: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 90.w,
                              height: 2.h,
                              color: Colors.grey[300],
                              // child: Row(),
                            )),
                        onEmpty: const SizedBox(),
                        onError: (e) => const SizedBox(),
                      ),
                      // heightSpace,
                      // // AdderssSelectorTile(),
                      // heightSpace,
                      // InkWell(
                      //   onTap: () => Get.toNamed(RouteApp.SEARCH),
                      //   child: search(context),
                      // )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SmartRefresher(
                  enableTwoLevel: true,
                  enablePullDown: true,
                  enablePullUp: false,
                  footer: CustomPullToRefFooter(),
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoading,
                  child: controller.obx(
                    (state) {
                      var catLength = controller.dataHome!.category!.length;
                      return Center(
                        child: Stack(
                          children: List.generate(
                            catLength,
                            (index) => PositionedDirectional(
                              top: MediaQuery.of(context).size.height / 3.25 +
                                  math.cos(
                                        2 * math.pi * (index / catLength),
                                      ) *
                                      180,
                              end: (75.w / 2) +
                                  math.sin(
                                        2 * math.pi * (index / catLength),
                                      ) *
                                      120,
                              child: field(context,
                                  controller.dataHome!.category![index], index),
                            ),
                          )..add(
                              Align(
                                widthFactor: MediaQuery.of(context).size.width,
                                heightFactor:
                                    MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    PositionedDirectional(
                                      top: MediaQuery.of(context).size.height /
                                              3.20 +
                                          30,
                                      end: (75.w / 2) +
                                          math.sin(
                                                (2 * math.pi),
                                              ) *
                                              120,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => MarketDetailsScreen(
                                              market: controller
                                                  .dataHome!.superMarket!,
                                            ),
                                            arguments: {
                                              "marketId": controller
                                                  .dataHome!.superMarket!.id
                                                  .toString()
                                            },
                                            binding: BindingsBuilder(() {
                                              Get.lazyPut(() =>
                                                  MarketDetailsController());
                                              Get.lazyPut(() =>
                                                  MarketCategorieController());
                                            }),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                                radius: 53,
                                                backgroundColor:
                                                    LightColor.mainColor,
                                                child: CircleAvatar(
                                                  radius: 47,
                                                  backgroundColor: Colors.white,
                                                  child: controller
                                                          .dataHome!
                                                          .superMarket!
                                                          .media!
                                                          .isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(47),
                                                          child: SmartImage
                                                              .network(
                                                            url: controller
                                                                .dataHome!
                                                                .superMarket!
                                                                .media![0]
                                                                .url!,
                                                            fit: BoxFit.cover,
                                                            context: context,
                                                          ),
                                                        )
                                                      : Image.asset(
                                                          'assets/Icon/logo_d.png',
                                                          fit: BoxFit.cover,
                                                          // color: Colors.grey[300],
                                                        ),
                                                  // Image.asset(
                                                  //   "assets/Icon/logo_d.png",
                                                  //   colorBlendMode:
                                                  //       BlendMode
                                                  //           .darken,
                                                  // ),
                                                )),
                                            SizedBox(
                                              width: 24.w,
                                              child: Center(
                                                child: Text(
                                                    controller.dataHome!
                                                        .superMarket!.nameAr,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            fontSize: 13,
                                                            color: LightColor
                                                                .PrimaryDarkBlue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      );
                    },
                    onLoading: CircleAvatar(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(50.sp)),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.blue,
                              ))),
                    ),
                    onEmpty: const SizedBox(),
                    onError: (e) => const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  field(BuildContext context, Category category, int index) {
    return GestureDetector(
      onTap: () {
        Get.put(MarketControlller());
        Get.put(TopMarketController());
        Get.to(
            () => AllMarketScreen(
                  title: controller.dataHome!.category![index].fieldName,
                  check: true,
                ),
            arguments: {
              "field_id": controller.dataHome!.category![index].id,
            });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: LightColor.mainColor,
            radius: 50,
            child: CircleAvatar(
              backgroundColor: LightColor.WhiteColor,
              radius: 47,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35.sp),
                child: controller.dataHome!.category![index].hasMedia
                    ? SmartImage.network(
                        url: controller
                            .dataHome!.category![index].getMedia!.url!,
                        fit: BoxFit.cover,
                        context: context,
                        // width: 30.sp,
                        //color: LightColor.mainColor,
                      )
                    : Image.asset(
                        'assets/img/logo_d.png',
                        fit: BoxFit.cover,
                        // color: Colors.grey[300],
                      ),
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                controller.dataHome!.category![index].fieldName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 13,
                      color: LightColor.PrimaryDarkBlue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildHomeCard(BuildContext context, String title, var funName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              const SizedBox(
                width: 15.0,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 11.sp,
                      color: LightColor.PrimaryDarkBlue,
                      fontWeight: FontWeight.w800,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
      child: SvgPicture.asset(
        "assets/Icons/filter.svg",
        color: LightColor.PrimaryDarkBlue,
        width: 15.sp,
      ),
    );
  }
}

// Stack(
//           children: [
//             CircleDistribution(
//               items: const [
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                     child: Icon(
//                       Icons.home,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                     child: Icon(
//                       Icons.home,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(28.0),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//               ],
//               radius: MediaQuery.of(context).size.width,
//             ),
//           ],
//         ),
