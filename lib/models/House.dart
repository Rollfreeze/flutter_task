// house model

class House {
	late int id;
	late String name;
	late String location;
	late String description;
	late String type;
	late int rating;
	late int review_count;
	late List<String> images;
	late int price;


	House.fromMap({required map}) {
		id = map['id'];
		name = map['name'];
		location = map['location'];
		description = map['description'];
		type = map['type'];
		rating = map['rating'];
		review_count = map['review_count'];
		images = map['images'];
		price = map['price'];
  }
}