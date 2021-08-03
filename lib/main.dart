// ignore: prefer_double_quotes
import 'package:flutter/foundation.dart';
// ignore: prefer_double_quotes
import 'package:flutter/material.dart';
// ignore: unused_import, prefer_double_quotes
import 'package:flutter_driver/driver_extension.dart';
//to  make http requests
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  // IMPORTANT: Uncomment the line `enableFlutterDriverExtension();`
  // before making a submission. 
  //Failure in doing so will not execute the automated testcases.

  enableFlutterDriverExtension();
  runApp(MyApp());
}

/// The MyApp Class
// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
      // ignore: prefer_double_quotes
      title: 'Food Delivery',
      // ignore: prefer_double_quotes
      home: const restaurantDisplay(),
    );
}

class Restaurant {
  final double rating;
  final String title;
  final String logoImage;
  
  Restaurant({
    this.rating,
    this.title,
    this.logoImage,
  });
}

/// The Homepage Class
class restaurantDisplay extends StatefulWidget {
  @override
  restaurantDisplayState createState() => restaurantDisplayState();
}

class restaurantDisplayState extends State<restaurantDisplay> {  
    late TextEditingController _searchcontroller;
    List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    _searchcontroller = TextEditingController();
    searchRestaurants("", "init");
  }

  //Keyword based restaurnt display
  void searchRestaurants(keyword, from) async{
    final response = await http.get(Uri.parse(from == "init" ? 
                                              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=47.6204,-122.3491&radius=2500&type=restaurant&key=AIzaSyDxVclNSQGB5WHAYQiHK-VxYKJelZ_9mjk' :
                                              'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=47.6204,-122.3491&radius=2500&type=restaurant&keyword=${keyword}&key=AIzaSyDxVclNSQGB5WHAYQiHK-VxYKJelZ_9mjk');
    var responseData = json.decode(response.body);
    restaurants.clear();
    for (var restaurant in responseData['results']) {
      Restaurant r1 = Restaurant(
          rating: restaurant["rating"],
          title: restaurant["name"],
          logoImage: restaurant["icon"]);
  
      //Adding restaurant to the list.
      setState((){
        restaurants.add(r1);
      });
    }
  }
                                    
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
        height: Mediaquery.of(context).size.height,
        width: Mediaquery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start.
          children:[
            
            //textfield widget for search
//             Container(
//               width: Mediaquery.of(context).size.width,
//               height: 60.0,
//               margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 5.0),
//               padding: EdgeInsets.all(10.0),
//               decoration: InputDecoration(
//                 border: Border.all(color: Colors.black.withOpacity(0.5),
//                 borderRadius: BorderRadius.all(Radius.circular(20))
//               ),
//               child:
//                   TextField(
//                     key: ValueKey('edit_search'),
//                     controller: _searchcontroller,
//                     style: TextStyle(fontSize: 18.0, color: Colors.black),
//                     onChanged: (content) {
//                       searchRestaurants(content, "onSearch");
//                     },
//                     decoration: InputDecoration(  
//                       border: InputBorder.none,  
//                       prefixIcon: new Padding(
//                         padding: EdgeInsets.only(right: 15.0),
//                         child: Icon(Icons.search, size: 18.0, color: Colors.black.withOpacity(0.5))
//                       ),
//                       hintText: 'Search for restaurants, cuisines..',
//                       hintStyle:  TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(0.5))
//                   ),  
//             )
//            ),
              
            //ListView widget
              Container(
                height: Mediaquery.of(context).size.height * 0.75,
                child: Expanded(
                child:  ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Mediaquery.of(context).size.width,
                      height: 
                      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              //restaurant logo/image 
                              Container(
                                height: 100.0,
                                width: 100.0,
                                margin: EdgeInsets.only(right:10.0),
                                child: Image.network(restaurants[index].logoImage,
                                  fit: BoxFit.fill,
                                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null ? 
                                             loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                             : null,
                                      ),
                                    );
                                  },
                                )
                             ),
                              
                              //restaurant name
                              Flexible(
                                child: Text(restaurants[index].title ??"", style: TextStyle(fontSize: 21.0, color: Colors.black, fontweight: FontWeight.bold))
                              ),
                              
                              //restaurant rating
                              Container(
                                color: Colors.green,
                                height: 40.0,
                                width: 50.0,
                                padding: EdgeInsets.all(7.0),
                                child: Center(
                                  child: Text(restaurants[index].rating.toString() ?? "", style: TextStyle(color: Colors.white, fontSize: 18.0)
                                )
                              )
                                   
                            ]
                          )
                        ]  
                      )
                          
                          
                    );
                  },
                )
               )        
                          
                          
          ]
      ))
     );
}
