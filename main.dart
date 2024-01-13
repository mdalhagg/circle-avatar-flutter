class main (){
  return controller.obx(
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
                          // center avatar
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
}
