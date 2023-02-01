import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login&register/login_screen/shoplogin_screen.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_Boarding1.png',
        title: 'ORDER ONLINE ',
        body: 'make your order sitting on a Sofa.\n play and choose online'),
    BoardingModel(
        image: 'assets/images/on_Boarding3.png',
        title: 'M-COMMERCE',
        body: 'Download our application and buy using your phone or laptop'),
    BoardingModel(
        image: 'assets/images/on_Boarding2.png',
        title: 'DELIVERY SERVICES',
        body: 'Modern delivering technologies. shipping to the porch of you apartment'),
  ];
  var boardController = PageController();
  bool isLast = false;
  
  void skipOnBoarding() {
    CacheHelper.saveData(key: 'boardingShown', value: true).then((value) {
      if (value == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ShopLoginScreen()),
          (route) => false,

        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                            title: const Text(
                              'Are You Sure to Skip?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    skipOnBoarding();
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No')),
                            ]),
                );
              },
              child: const Text("Skip")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) =>
                    buildBoardingiteam(boarding[index])),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 10.0,
                    expansionFactor: 4.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                isLast
                    ? TextButton(
                        onPressed: () {
                          skipOnBoarding();
                        },
                        child: const Text("Let's Start"))
                    : FloatingActionButton(
                        onPressed: () {
                          boardController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.decelerate);
                        },
                        child: const Icon(Icons.arrow_forward_ios))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingiteam(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // ignore: sized_box_for_whitespace
            child: Container(
                width: double.infinity,
                child: Image(image: AssetImage(model.image))),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
