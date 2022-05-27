import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/BackendConnectionService.dart';
import 'package:flutter_test_app/components/HousesList.dart';
import 'package:flutter_test_app/models/House.dart';
import 'package:flutter_test_app/view/AdvertismentCard.dart';
import 'package:flutter_test_app/view/FilterButton.dart';
import 'package:flutter_test_app/view/PrimaryButton.dart';

class MainScreen extends StatefulWidget {
	const MainScreen({
		Key? key,
	}) : super(key: key);

	@override
	_MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
	late var futureFetch;
	late List<FilterButton> filterButtonList = [];

	TextStyle buttonTextStyleNormal = const TextStyle(
		fontFamily: 'Roboto',
		fontWeight: FontWeight.w500,
		fontSize: 16,
		color: Colors.black,
	);

	void refreshCB() {
		setState(() {
			futureFetch = HousesList.fetchAdvertismentCards(BackendConnectionService().url);
		});
	}

	/// Вспомогательный метод для переключения активного состояния
	/// кнопки сортировки
	void switchBtn(index) {
    setState(() {
      filterButtonList.forEach((element) => element.isActiveNow = false);
      filterButtonList[index].isActiveNow = true;
    });
	}

	/* Методы для соотвуствующих кнопок сортировки: */

	/// Все
  allFrame() {
    futureFetch = HousesList.fetchAdvertismentCards(BackendConnectionService().url);
    switchBtn(0);
  }

	/// O-frame
  oFrame() {
    futureFetch = HousesList.fetchOFrameCards();
    switchBtn(1);
  }

	/// A-frame
  aFrame() {
    futureFetch = HousesList.fetchAFrameCards();
    switchBtn(2);
  }


	/// Строка фильтров
	Row buildFilterRow() {
		return Row(mainAxisAlignment: MainAxisAlignment.start, children: filterButtonList);
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

		futureFetch = HousesList.fetchAdvertismentCards(BackendConnectionService().url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: const Color.fromRGBO(243, 243, 245, 1),
      body: FutureBuilder(
          future: futureFetch,
          builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
							return Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Text('Ошибка получения данных', style: buttonTextStyleNormal),	
									Padding(
									  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
									  child: PrimaryButton(buttonText: 'Попробовать еще раз', pressedCB: refreshCB),
									),		
								],
							);
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
