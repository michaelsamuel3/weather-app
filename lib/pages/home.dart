// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/utility/ImgPath.dart';
import 'package:weather/pages/utility/apptext.dart';
import 'package:weather/services/location_provider.dart';
import 'package:weather/services/weather_service_-provider.dart';
//import 'package:weather/pages/utility/customdivider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceprovider>(context, listen: false)
              .fetchWeatherDataByCity(city);
        }
      }
    });

    super.initState();
  }

  TextEditingController cityController = TextEditingController();
  var city;

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final weatherProvider = Provider.of<WeatherServiceprovider>(context);

    int sunriseTimestamp = weatherProvider.weather?.sys?.sunrise ?? 0;
    int sunsetTimestamp = weatherProvider.weather?.sys?.sunset ?? 0;

    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

    String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);
    String formattedSunset = DateFormat.Hm().format(sunsetDateTime);

    return Scaffold(
        body: ListView(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //         "assets/background.jpg",
        //       ),
        //       fit: BoxFit.cover),
        // ),
        decoration: const BoxDecoration(
        color: Color.fromARGB(255, 136, 207, 235)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                    var locationcity;
                    if (locationProvider.currentLocationName != null) {
                      locationcity = locationProvider
                          .currentLocationName!.administrativeArea;
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           
                            AppText(
                              data: locationcity.isEmpty
                                  ? "Unknown location"
                                  : locationcity,
                              color:Colors.black87,
                              fw: FontWeight.bold,
                              size: 20,
                            ),
                            SizedBox(height: 3,),
                               AppText(
                        data: DateFormat("hh:mm a").format(DateTime.now()),
                        color:Colors.black87,
                        fw: FontWeight.normal,
                        size: 18,
                      ),
                          ],
                        ),
                        SizedBox(
                          width: 180,
                          // height: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                clicked = !clicked;
                              });
                            },
                            icon: Icon(
                              Icons.search,
                              size: 28,
                              color: Colors.black87,
                            ))
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              clicked == true
                  ? Container(
                      height: 40,
                      width: 400,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: cityController,
                              decoration: InputDecoration(
                                  hintText: " Serach City",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white70),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                          ),
                          IconButton(
                              onPressed: () async{
                                print(cityController.text);
                               await weatherProvider.fetchWeatherDataByCity(
                                    cityController.text);
                              },
                              icon: Icon(Icons.search),color: Colors.red,focusColor: 
                              Colors.black,)
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(image( weatherProvider.weather?.weather![0].main!.toLowerCase())),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        data:
                            " ${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)}\u00B0 C",
                        color:Colors.black87,
                        fw: FontWeight.w900,
                        size: 40,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AppText(
                        data: weatherProvider.weather?.name ?? "N/A",
                        color:Colors.black87,
                        fw: FontWeight.bold,
                        size: 22,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AppText(
                        data:
                            weatherProvider.weather?.weather![0].main ?? "N/A",
                        color:Colors.black87,
                        fw: FontWeight.bold,
                        size: 25,
                      ),
                   
                   
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:Colors.white70,
                          ),
                          height: 100,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/thermometer.png",
                                  height: 65,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      data: "Temp Max",
                                      color: Colors.black87,
                                      fw: FontWeight.w900,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      data:
                                          "${weatherProvider.weather?.main!.tempMax!.toStringAsFixed(0) ?? "N/A"}\u00b0 C",
                                      color: Colors.black87,
                                      fw: FontWeight.normal,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                        //  SizedBox(width: 30,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             color:Colors.white70,
                          ),
                          height: 100,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/low-temperature.png",
                                 height: 60,
                                ),
                                SizedBox(width: 7),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      data: "Temp Min",
                                      color: Colors.black87,
                                      fw: FontWeight.w900,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      data:
                                          "${weatherProvider.weather?.main!.tempMin!.toStringAsFixed(0) ?? "N/A"}\u00b0 C",
                                      color: Colors.black87,
                                      fw: FontWeight.normal,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             color:Colors.white70,
                          ),
                          height: 100,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/sun.png",
                                 height: 70,
                                ),
                                SizedBox(width: 8),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      data: "Sunrise",
                                      color: Colors.black87,
                                      fw: FontWeight.w900,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      data: "${formattedSunrise} AM",
                                      color: Colors.black87,
                                      fw: FontWeight.normal,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                         // SizedBox(width: 30,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             color:Colors.white70,
                          ),
                          height: 100,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/moonlight.png",
                                  height: 70,
                                ),
                                SizedBox(width: 8),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      data: "Sunset",
                                      color: Colors.black87,
                                      fw: FontWeight.w900,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      data: "${formattedSunset} PM",
                                      color:Colors.black87,
                                      fw: FontWeight.normal,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                   SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              color:Colors.white70,
                          ),
                          height: 100,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/humidity.png",
                                 height: 60,
                                ),
                                SizedBox(width: 10),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      data: "Humidity",
                                      color: Colors.black87,
                                      fw: FontWeight.w900,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      data: "${weatherProvider.weather?.main!.humidity ?? "N/A"}%",
                                      color: Colors.black87,
                                      fw: FontWeight.normal,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                         // SizedBox(width: 30,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              color:Colors.white70,
                          ),
                          height: 100,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/wind.png",
                                  height: 60,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      data: "wind",
                                      color: Colors.black87,
                                      fw: FontWeight.w900,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      data:  "${weatherProvider.weather?.wind!.speed!.toStringAsFixed(0) ?? "N/A"} Km/h",
                                      color: Colors.black87,
                                      fw: FontWeight.normal,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
