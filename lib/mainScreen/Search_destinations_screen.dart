import 'package:flutter/material.dart';
import 'package:carpooling_app/assistants/request_assistant.dart';
import 'package:carpooling_app/global/map_key.dart';
import 'package:carpooling_app/models/predicted_places.dart';
import 'package:carpooling_app/widgets/place_prediction_tile.dart';


class SearchDestinationsScreen extends StatefulWidget
{

  @override
  _SearchDestinationsScreenState createState() => _SearchDestinationsScreenState();
}




class _SearchDestinationsScreenState extends State<SearchDestinationsScreen>
{
  List<PredictedPlaces> placesPredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async
  {
    if(inputText.length > 1) //2 or more than 2 input characters
        {
      String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapkey&components=country:LK";

      var responseAutoCompleteSearch = await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if(responseAutoCompleteSearch == "Error Occurred, Failed. No Response.")
      {
        return;
      }

      if(responseAutoCompleteSearch["status"] == "OK")
      {
        var placePredictions = responseAutoCompleteSearch["predictions"];

        var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();

        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //search place ui
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: Color.fromARGB(80, 0, 0, 0),
              boxShadow:
              [
                BoxShadow(
                  color: Color.fromARGB(255, 219, 136, 12),
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0.7,
                    0.7,
                  ),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  const SizedBox(height: 25.0),

                  Stack(
                    children: [

                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Search & Set Destination Location",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),

                  Row(
                    children: [

                      const Icon(
                        Icons.adjust_sharp,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 18.0,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (valueTyped)
                            {
                              findPlaceAutoCompleteSearch(valueTyped);
                            },
                            decoration: const InputDecoration(
                              hintText: "search here...",
                              labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                              fillColor: Color.fromARGB(184, 255, 255, 255),
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 11.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),

          //display place predictions result
          (placesPredictedList.length > 0)
              ? Expanded(
            child: ListView.separated(
              itemCount: placesPredictedList.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index)
              {
                return PlacePredictionTileDesign(
                  predictedPlaces: placesPredictedList[index],
                );
              },
              separatorBuilder: (BuildContext context, int index)
              {
                return const Divider(
                  height: 1,
                  color: Color.fromARGB(255, 219, 136, 12),
                  thickness: 1,
                );
              },
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}