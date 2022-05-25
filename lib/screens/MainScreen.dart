import 'package:flutter/widgets.dart';
import 'package:flutter_test_app/components/BackendConnectionService.dart';
import 'package:flutter_test_app/models/House.dart';

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

	late var advertismentsList;

	/// Получаем список объявлений
	fetchAdvertismentCards() {
		advertismentsList = BackendConnectionService.request(url: url);
	}


  @override
  Widget build(BuildContext context) {
		fetchAdvertismentCards();

		print(advertismentsList);

    throw UnimplementedError();
  }
}