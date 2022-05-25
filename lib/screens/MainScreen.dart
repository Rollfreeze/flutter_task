import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_app/components/HousesList.dart';

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

	@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
		return FutureBuilder(
			future: HousesList.fetchAdvertismentCards(url),
		
			builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
				if (snapshot.connectionState == ConnectionState.waiting) {
		    	return const Center(child: CircularProgressIndicator());
				}
		
				if (snapshot.hasError) {
					return const Center(child: Text('Ошибка получения данных'));
				}
		
				return Center(child: Text('Success!'));
			}
		);
  }
}