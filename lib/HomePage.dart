import 'package:flutter/material.dart';
import 'package:responsi_124220025/data/responses/RestaurantModelResponses.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  //inisiasi variabel
  final String username;
  final String? nickname;//ada tanda tanya krn isinya bisa berbentuk string atau ngga ada


  HomePage({Key? key, required this.username, this.nickname,  });

  get baseNetwork => null; //passing data
//required untuk ditampilkan di homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Selamat Datang! $username"),
        automaticallyImplyLeading: false, //menghilangkan tombol back

      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
                      future: baseNetwork.getData('restaurant'),
                      //apa yang mau dibuat
                      builder: (context, snapshot){
                        //kalau datanya error
                        if(snapshot.hasError) {
                          return Text("tidak dapat ememuat data");
                        }
                        //kalau datanya ada
                        if(snapshot.hasData) {
                          List<Restaurants> RestaurantModel = Restaurants().fromJsonList(
                              snapshot.data!
                          );
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2 // ada batasaan makanya hasilnya dibawah erorr
                            ),
                            itemBuilder : (context, index) {
                              return Card(
                                child: Column(
                                  children: [
                                    Text(RestaurantModel[index].name!),
                                    Image.network(RestaurantModel[index].pictureId!),

                                  ],
                                ),
                              );
                            },
                            itemCount: RestaurantModel.length, // ada batasaan
                          );
                        }
                        return CircularProgressIndicator();
                      }
                  ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );

  }
}


