// house model

class House {
	late int id;
	late String name;
	late String location;
	late String description;
	late String type;
	late int rating;
	late int review_count;

	/// может быть null - тогда заменим на '0'
	/// или может прийти список string List<String>
	late dynamic images;

	late int price;


	House.fromMap({required map}) {
		id = map['id'];
		name = map['name'];
		location = map['location'];
		description = map['description'];
		type = map['type'];
		rating = map['rating'];
		review_count = map['review_count'];
		
		if (map['images'].length > 0) {
			images = [];
			for (int i = 0; i < map['images'].length; i++) {
				images!.add(map['images'][i]);
			}
		} else {
			images = '0';
		}

		price = map['price'];
  }

	
}