class RestaurantResponses {
  final bool? error;
  final String? message;
  final Restaurant? restaurant;

  RestaurantResponses({
    this.error,
    this.message,
    this.restaurant,
  });

  RestaurantResponses.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        message = json['message'] as String?,
        restaurant = (json['restaurant'] as Map<String, dynamic>?) != null
            ? Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'restaurant': restaurant?.toJson(),
  };
}

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final List<Categories>? categories;
  final Menus? menus;
  final double? rating;
  final List<CustomerReviews>? customerReviews;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        city = json['city'] as String?,
        address = json['address'] as String?,
        pictureId = json['pictureId'] as String?,
        categories = (json['categories'] as List?)?.map((dynamic e) => Categories.fromJson(e as Map<String, dynamic>)).toList(),
        menus = (json['menus'] as Map<String, dynamic>?) != null ? Menus.fromJson(json['menus'] as Map<String, dynamic>) : null,
        rating = json['rating'] as double?,
        customerReviews = (json['customerReviews'] as List?)?.map((dynamic e) => CustomerReviews.fromJson(e as Map<String, dynamic>)).toList();

  get fromJsonlist => null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'city': city,
    'address': address,
    'pictureId': pictureId,
    'categories': categories?.map((e) => e.toJson()).toList(),
    'menus': menus?.toJson(),
    'rating': rating,
    'customerReviews': customerReviews?.map((e) => e.toJson()).toList(),
  };

  static List<Restaurant> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Restaurant.fromJson(json as Map<String, dynamic>)).toList();
  }
}

class Categories {
  final String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class Menus {
  final List<Foods>? foods;
  final List<Drinks>? drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json)
      : foods = (json['foods'] as List?)?.map((dynamic e) => Foods.fromJson(e as Map<String, dynamic>)).toList(),
        drinks = (json['drinks'] as List?)?.map((dynamic e) => Drinks.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'foods': foods?.map((e) => e.toJson()).toList(),
    'drinks': drinks?.map((e) => e.toJson()).toList(),
  };
}

class Foods {
  final String? name;

  Foods({this.name});

  Foods.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class Drinks {
  final String? name;

  Drinks({this.name});

  Drinks.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class CustomerReviews {
  final String? name;
  final String? review;
  final String? date;

  CustomerReviews({this.name, this.review, this.date});

  CustomerReviews.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        review = json['review'] as String?,
        date = json['date'] as String?;

  Map<String, dynamic> toJson() => {
    'name': name,
    'review': review,
    'date': date,
  };
}
