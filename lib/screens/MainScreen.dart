import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/HousesList.dart';
import 'package:flutter_test_app/models/House.dart';
import 'package:flutter_test_app/view/AdvertismentCard.dart';
import 'package:flutter_test_app/view/FilterButton.dart';

class MainScreen extends StatefulWidget {
	const MainScreen({
		Key? key,
	}) : super(key: key);

	@override
	_MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
	/// url для получения объявлений
	final url = "https://elki.rent/test/house.json";

	TextStyle buttonTextStyleNormal = const TextStyle(
		fontFamily: 'Roboto',
		fontWeight: FontWeight.w500,
		fontSize: 16,
		color: Colors.black,
	);

  void allFrame() {
    setState(() {
      filterButtonList.forEach((element) => element.isActiveNow = false);

      filterButtonList[0].isActiveNow = true;
    });
  }

  void oFrame() {
    setState(() {
      filterButtonList.forEach((element) => element.isActiveNow = false);

      filterButtonList[1].isActiveNow = true;
    });
  }

  void aFrame() {
    setState(() {
      filterButtonList.forEach((element) => element.isActiveNow = false);

      filterButtonList[2].isActiveNow = true;
    });
  }

	late List<FilterButton> filterButtonList = [];

	/// Строка фильтров
	Row buildFilterRow() {
		return Row(
			// children: [
			// 	FilterButton(buttonText: 'все дома', isActiveNow: true, pressedCB: (){}),
			// 	FilterButton(buttonText: 'O-frame', isActiveNow: false, pressedCB: (){}),
			// 	FilterButton(buttonText: 'A-frame', isActiveNow: false, pressedCB: (){}),
			// ],
			children: filterButtonList
		);
	}

	/// Возвращает список объявлений
  Widget buildAdvertismentsList(data) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(243, 243, 245, 1)),
      margin: const EdgeInsets.only(top: 70.0, left: 16.0, right: 16.0),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return AdvertismentCard(house: data[index]);
        },
      ),
    );
  }

	@override
  void initState() {
    filterButtonList = [
      FilterButton(buttonText: 'все дома', isActiveNow: true, pressedCB: allFrame),
      FilterButton(buttonText: 'O-frame', isActiveNow: false, pressedCB: oFrame),
      FilterButton(buttonText: 'A-frame', isActiveNow: false, pressedCB: aFrame),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: const Color.fromRGBO(243, 243, 245, 1),
      body: FutureBuilder(
          future: HousesList.fetchAdvertismentCards(url),
          builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Ошибка получения данных'));
            }
						
						/// Полученные данные - список объявлений
						var data = snapshot.data as List<House>;

						return SafeArea(
							top: true,
							bottom: true,
						  child: Stack(
						  	children: [
									/// Строка фильторв
									Padding(
									  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
									  child: buildFilterRow(),
									),
								
									/// Список объявлений
									buildAdvertismentsList(data)
						  	],
						  ),
						);
          }),
    );
  }
}