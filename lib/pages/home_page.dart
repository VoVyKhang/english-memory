import 'dart:math';

import 'package:english_memory/models/english_today.dart';
import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../package/quotes/quote.dart';
import '../package/quotes/quote_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController pageController;

  List<EnglishToday> words = [];

  String quote = Quotes().getRandom().content!;

  List<int> fixedListRandom({int len = 1, int max = 120, min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() {
    List<String> newList = [];
    List<int> random = fixedListRandom(len: 5, max: nouns.length);

    for (var index in random) {
      newList.add(nouns[index]);
    }

    EnglishToday getQuote(String noun) {
      Quote? quote;
      quote = Quotes().getByWord(noun);
      return EnglishToday(
        noun: noun,
        quote: quote?.content,
        id: quote?.id,
      );
    }

    words = newList.map((e) => getQuote(e)).toList();
  }

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {},
          child: Image.asset(AppAssets.menu),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          Container(
            height: size.height * 1 / 10,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            child: Text(
              '"$quote"',
              style: AppStyles.h5
                  .copyWith(fontSize: 12, color: AppColors.textColor),
            ),
          ),
          SizedBox(
            height: size.height * 1.8 / 3,
            child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: words.length,
                itemBuilder: (context, index) {
                  String? word =
                      (words[index].noun != null) ? words[index].noun : '';
                  String? firstLetter = word?.substring(0, 1);
                  String? restLetter = word?.substring(1, word.length);

                  String quoteDefault =
                      "Think of all the beauty still left around you and be happy";

                  String quote = words[index].quote != null
                      ? words[index].quote!
                      : quoteDefault;

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(3, 6),
                                blurRadius: 6)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Image.asset(AppAssets.heart),
                          ),
                          RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: firstLetter,
                                  style: const TextStyle(
                                      fontFamily: FontFamily.sen,
                                      fontSize: 89,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(3, 6),
                                            blurRadius: 6)
                                      ]),
                                  children: [
                                    TextSpan(
                                        text: restLetter,
                                        style: const TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontSize: 56,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 6)
                                            ]))
                                  ])),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text(
                              '"$quote"',
                              style: AppStyles.h4.copyWith(
                                  letterSpacing: 1, color: AppColors.textColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 12,
              margin: const EdgeInsets.symmetric(vertical: 14),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return buildIndicator(index == _currentIndex, size);
                  })),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 8,
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}
