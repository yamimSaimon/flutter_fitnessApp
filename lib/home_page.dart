import 'dart:convert';

import 'package:fitness_app/model/model.dart';
import 'package:fitness_app/second_page.dart';
import 'package:fitness_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExcerciesModel> allData = [];
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";
  bool isLoading = false;
  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var responce = await http.get(
        Uri.parse(link),
      ); //link hit
      print("status code is ${responce.statusCode}");
      // print("${responce.body}");
      if (responce.statusCode == 200) {
        final item = jsonDecode(responce.body);
        for (var data in item["exercises"]) {
          ExcerciesModel excerciesModel = ExcerciesModel(
              id: data["id"],
              title: data["title"],
              thumbnail: data["thumbnail"],
              gif: data["gif"],
              seconds: data["seconds"]);
          setState(() {
            allData.add(excerciesModel);
          });
        }

        print("total length is ${allData.length}");
      } else {
        showToast("Something is wrong");
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Somethinf is wrong $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        progressIndicator: spinkit,
        child: Container(
          width: double.infinity,
          child: ListView.builder(
            itemCount: allData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Secondpage(
                            excerciesModel: allData[index],
                          )));
                },
                child: Container(
                  height: 160,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.network(
                          "${allData[index].thumbnail}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 65,
                            padding: EdgeInsets.all(16),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${allData[index].title}",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.black12,
                                  Colors.black54,
                                  Colors.black87,
                                  Colors.black
                                ])),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
