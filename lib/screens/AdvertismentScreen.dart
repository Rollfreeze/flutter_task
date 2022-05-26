import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/NavigationService.dart';
import 'package:flutter_test_app/models/House.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_test_app/screens/ViewPhotoWidget.dart';
import 'package:flutter_test_app/view/PrimaryButton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


/// Скрин объявления
class AdvertismentScreen extends StatefulWidget {
	final House house;
  static CarouselController buttonCarouselController = CarouselController();

	const AdvertismentScreen({
		Key? key,
		required this.house
	}) : super(key: key);

  @override
  _AdvertismentScreenState createState() => _AdvertismentScreenState();
}

class _AdvertismentScreenState extends State<AdvertismentScreen> {
	late bool anyImageExist;

  int currentImageNumber = 0;

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

	TextStyle descriptionStyle = const TextStyle(
		fontFamily: 'Roboto',
		fontWeight: FontWeight.w400,
		fontSize: 16,
		color: Colors.black
	);

	/// Возвращает тайтл карточки
  Widget buildTitle() {
    Text advertismentName = Text(widget.house.name, style: nameStyle);
    Text advertismentLocation = Text(widget.house.location, style: locationStyle);

    return Row(children: [
      advertismentName,
      Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: advertismentLocation,
      )
    ]);
  }

	/// Контейнер, который появляется, когда
	/// пользователь кликает на объявление,
	/// где нет картинки
	Widget buildEmptyImagesContainer() {
		return const Image(image: AssetImage('assets/images/placeholder.png'));
	}

  /// Открытие галлереии
  void openGallery(int currentImageNumber, imagesList) =>
     NavigationService.instance.navigateToRoute(
        MaterialPageRoute(
          builder: (_) => ViewPhotoWidget(
              currentImageNumber: currentImageNumber, imagesList: imagesList),
        ),
      );

	/// Возвращает картинку, на которую можно тапнуть и перейти в просмотр с зумом
	Widget buildImage(String urlImage, int index, List imagesList) => GestureDetector(
		onTap: () => openGallery(index, imagesList),
	  child: Container(
	  	color: Colors.grey,
	  	child: Image.network(urlImage, fit: BoxFit.fitWidth),
	  ),
	);

	/// Слайдер картинок
	Widget buildCarouselSlider() {
    return CarouselSlider.builder(
      carouselController: AdvertismentScreen.buttonCarouselController,
      options: CarouselOptions(
        height: 264,
				// pageSnapping: true,
				viewportFraction: 1,
        // autoPlay: false,
        // enlargeCenterPage: false,
        enableInfiniteScroll: false,
        initialPage: 0,
        onPageChanged: (index, reason) => setState(() => {currentImageNumber = index}),
      ),
			itemCount: widget.house.images.length,
			itemBuilder: (BuildContext context, index, realIndex) {
				final urlImage = widget.house.images[index];

				return buildImage(urlImage, index, widget.house.images);
			},
    );
  }

	/// Небольшое дополнение от себя: кружочки как в ios,
	/// показывающие текущий слайд на фотографиях
  Widget buildIndicator() => AnimatedSmoothIndicator(
        count: widget.house.images.length,
        activeIndex: currentImageNumber,
        effect: const JumpingDotEffect(
          spacing: 8,
          dotWidth: 8,
          dotHeight: 8,
          dotColor: Color.fromRGBO(255, 255, 255, 0.5),
          activeDotColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      );


	/// Возвращает блок с описанием дома
	Widget buildDescriptionHouse() {
		return Row(
			children: [
				Expanded(child: Text(widget.house.description, style: descriptionStyle, maxLines: 5)),
		]);
	}

	/// Данный метод возвращает верхнюю половину
  /// объявления
  Widget buildTopPart() {
    return Column(
      children: [
        Stack(children: [
          /// Картинки
          if (!anyImageExist)
            buildEmptyImagesContainer()
          else
            buildCarouselSlider(),

          /// точечки снизу
          Visibility(
            visible: (widget.house.images.length > 1),
            child: Positioned.fill(
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: buildIndicator(),
              ),
            ),
          ),
        ]),

        /// Описание дома
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: buildDescriptionHouse(),
        ),
      ],
    );
  }

	/// Возвращает блок с ценой за сутки
  Widget buildPricePerDay() {
    // todo: отсупы 9.000
    Text price = Text(widget.house.price.toString() + '₽', style: nameStyle);
    Text perDay = Text('/сут.', style: descriptionStyle);

    return Row(children: [price, perDay]);
  }

	/// Метод возвращает нижний блок
	/// объявления, который включает в себя
	/// кнопку назад и стоимость
  Widget buildBottom() {
    return Container(
      decoration: BoxDecoration(
				color: Colors.white,

				boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ]),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 21.0, horizontal: 16.0),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							/// Цена за сутки
							buildPricePerDay(),
							
							/// Primary Button - "Назад"
							const PrimaryButton(buttonText: 'Назад', pressedCB: null)
					]),
				),
    );
  }

	@override
  void initState() {
    anyImageExist = (widget.house.images != '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(243, 243, 245, 1),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: buildTitle(),
        ),
      ),
      body: SafeArea(
				top: true,
				bottom: true,
        child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
					/// Верхняя половина
					/// объялвения: Картинки, описание
					buildTopPart(),

					/// Нижняя половина объявления
					buildBottom()
          ],
        ),
      ),
    );
  }
}
