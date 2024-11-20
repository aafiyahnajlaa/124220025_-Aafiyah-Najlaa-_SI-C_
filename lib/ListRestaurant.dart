import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'DetailRestaurant.dart'; // Import halaman detail
import 'FavoritPage.dart'; // Import halaman favorit

class RestaurantListPage extends StatefulWidget {
  final String username;
  RestaurantListPage({required this.username});

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  List<Restaurant> restaurants = [];
  List<String> favoriteRestaurants = [];

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
    _loadFavorites();
  }

  Future<void> _fetchRestaurants() async {
    final response = await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        restaurants = (data['restaurants'] as List)
            .map((restaurant) => Restaurant.fromJson(restaurant))
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch restaurants'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorites') ?? [];
    setState(() {
      favoriteRestaurants = favoriteIds;
    });
  }

  void _toggleFavorite(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    if (favoriteRestaurants.contains(restaurant.id)) {
      favoriteRestaurants.remove(restaurant.id);
      await prefs.setStringList('favorites', favoriteRestaurants);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed from favorites'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      favoriteRestaurants.add(restaurant.id);
      await prefs.setStringList('favorites', favoriteRestaurants);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to favorites'),
          backgroundColor: Colors.green,
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text('Hai, ${widget.username}'
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return ListTile(
            leading: Image.network(
              'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(restaurant.name),
            subtitle: Text(restaurant.city),
            trailing: Icon(
              Icons.arrow_forward,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(restaurant: restaurant),
                ),

              );
            },

          );
        },
      ),
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: double.parse(json['rating'].toString()),
    );
  }
}
