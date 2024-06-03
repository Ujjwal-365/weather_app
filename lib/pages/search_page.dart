import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/services/weather_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _cityController = TextEditingController();

  String? cityName;
  final _weatherService = WeatherServices('473bbd0e505c72f05f1d89576972b116');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Lottie.asset('assets/Animation - 1715360854855.json',
              alignment: Alignment.topCenter,
              height: double.infinity,
              fit: BoxFit.fill),
          Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Lottie.asset('assets/earth-rotate.json',

                            ),

                         Text(
                            "Enter location to find its Weather",
                            style: TextStyle(color: Colors.white70, fontSize: 20),
                          ),

                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _cityController,
                          style: TextStyle(color: Colors.white70),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Enter Location',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white38),
                                  borderRadius: BorderRadius.circular(40)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color:
                                      Colors.grey.shade400
                                      ),
                                  borderRadius: BorderRadius.circular(40)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 20.0),
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async{

                            if(_cityController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please enter a location."),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.transparent,
                                    padding: EdgeInsets.symmetric(vertical: 25,horizontal: 100),
                                  ),
                              );
                            }
                            else  {
                             await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WeatherPage(location: _cityController.text.trim())));

                            _cityController.clear();
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                            backgroundColor: Colors.white10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.white38),
                            ),
                          ),
                          child: Text(
                            'Search',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Expanded(child: Divider(thickness: 01,color: Colors.grey.shade600,)),
                            Text("  Or use current location  ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.white70),),
                            Expanded(child: Divider(thickness: 01,color: Colors.grey.shade600,)),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async{
                           cityName= await _weatherService.getCurrentCity();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WeatherPage(location: cityName)));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(17),
                            backgroundColor: Colors.white10,
                            overlayColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.white38),
                            ),
                          ),
                          child: Text(
                            'Current Location',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
