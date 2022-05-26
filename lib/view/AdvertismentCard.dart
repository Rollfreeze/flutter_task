import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/House.dart';
import 'package:flutter_test_app/view/ImgAvatar.dart';
import 'package:flutter_svg/svg.dart';

/// Класс - карточка объявления.
/// Является `StatelessWidget`, поскольку не имеет динамики,
/// а представляет собой неизменяемую статическую карточку
class AdvertismentCard extends StatelessWidget {
  final House house;

  AdvertismentCard({Key? key, required this.house}) : super(key: key);

  /// Текст стиль для имени объявления
  TextStyle nameStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    fontSize: 21,
    color: Colors.black,
  );

  /// Текст стиль для локации объявления
  TextStyle locationStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    fontSize: 21,
    color: Colors.grey,
  );

  /// Текст стиль для отзывов
  TextStyle reviewCountStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.black,
  );

  /// Главная картинка объявления
  Widget buildAdvertismentImage() {
    try {
      return ImgAvatar(txt: house.images![0].toString());
    } catch (exception) {
      throw Exception('null image');
    }
  }

  /// Возвращает тайтл карточки
  Widget buildTitle() {
    Text advertismentName = Text(house.name, style: nameStyle);
    Text advertismentLocation = Text(house.location, style: locationStyle);

    return Row(children: [
      advertismentName,
      Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: advertismentLocation,
      )
    ]);
  }

  /// Возвращает звезды объявления
  Widget buildStars() {
    List<SvgPicture> stars = [];

    if (house.rating > 0) {
      for (int i = 0; i < house.rating; i++) {
        stars.add(
            SvgPicture.asset('assets/images/star.svg', width: 12, height: 12));
      }

      for (int i = 0; i < (5 - house.rating); i++) {
        stars.add(SvgPicture.asset('assets/images/star.svg',
            width: 12, height: 12, color: Colors.grey.shade600));
      }
    } else {
      for (int i = 0; i < 5; i++) {
        stars.add(SvgPicture.asset('assets/images/star.svg',
            width: 12, height: 12, color: Colors.grey.shade600));
      }
    }

    return SizedBox(
      width: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: stars,
      ),
    );
  }

  /// Возвращает текст с количеством отзывов
  Widget buildReviewCount() {
    return Text('(' + house.review_count.toString() + ' отзывов' + ')',
        style: reviewCountStyle);
  }

  /// Объединение двух подстрок - звезд и отзывов
  Widget buildStarsAndReviewCount() {
    return Row(
      children: [
        buildStars(),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: buildReviewCount(),
        ),
      ],
    );
  }

  Widget buildPricePerDay() {
    // todo: отсупы 9.000
    Text price = Text(house.price.toString() + '₽', style: nameStyle);
    Text perDay = Text('/сут.', style: reviewCountStyle.copyWith(fontSize: 16));

    return Row(children: [price, perDay]);
  }

  /// Возвращает строку со звездами + отзывы и ценой за сутки
  Widget buildStarPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStarsAndReviewCount(),
        buildPricePerDay(),
      ],
    );
  }

  /// Собирает подготовленные заранее видежты, как конструктор
  List<Widget> buildCardElements() {
    List<Widget> cardBlocks = [
      /// img
      buildAdvertismentImage(),

      /// title
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: buildTitle(),
      ),

      /// downrow
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: buildStarPriceRow(),
      ),
    ];

    return cardBlocks;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
				clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Colors.white,
        ),
        child: Column(children: buildCardElements()),
      ),
    );
  }
}
