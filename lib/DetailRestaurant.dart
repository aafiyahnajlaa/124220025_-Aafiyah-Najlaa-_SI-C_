import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantDetailPage extends StatefulWidget {
  final restaurant;

  RestaurantDetailPage({required this.restaurant});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorites') ?? [];
    setState(() {
      isFavorite = favoriteIds.contains(widget.restaurant.id);
    });
  }

  void _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorites') ?? [];
    if (favoriteIds.contains(widget.restaurant.id)) {
      favoriteIds.remove(widget.restaurant.id);
      await prefs.setStringList('favorites', favoriteIds);
      setState(() {
        isFavorite = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed from favorites'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      favoriteIds.add(widget.restaurant.id);
      await prefs.setStringList('favorites', favoriteIds);
      setState(() {
        isFavorite = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to favorites'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.restaurant.name),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://restaurant-api.dicoding.dev/images/small/${widget.restaurant.pictureId}',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              widget.restaurant.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(widget.restaurant.city),
            SizedBox(height: 8.0),
            Text('Rating: ${widget.restaurant.rating}'),
            SizedBox(height: 16.0),
            Text(widget.restaurant.description),
          ],
        ),
      ),
    );
  }
}
