// ignore: file_names
// ignore: file_names
import 'package:e_learning/AllCourses.dart';
import 'package:e_learning/CoursePlaylist.dart';
import 'package:e_learning/Filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _color = Colors.white;
  bool _color_s = false;

  final mail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Hello Omar!'),
          Text(
            'Find your course',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                height: 55,
                width: 300,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                      // border: Border(
                      //     bottom: BorderSide(color:Colors.grey.shade200)
                      // )
                      ),
                  child: TextField(
                    controller: mail,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.grey,
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () async {
                        await Future.delayed(Duration(milliseconds: 500));

                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Filter()));
                      },
                      child: Container(
                        width: 60,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 241, 85, 54),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 33,
                        ),
                      )))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Courses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 500));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AllCourses()));
                },
                child: Ink(
                    height: 18,
                    child: Text(
                      'See All',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      //onTapDown: launch,
                      onTap: () async {
                        launch();
                      },

                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/ui_ux_design.png',
                            width: 170,
                            height: 170,
                          ),
                          Text(
                            'UX/UI Design',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 20,
                              ),
                              Text(
                                '5h 30 min',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Text(
                                '4.9 (522 reviews)',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          )
                        ],
                      ),
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.all(10),
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        //onTapDown: launch,
                        onTap: () async {
                          launch();
                        },
                        child: Column(
                          children: [
                            // SizedBox(height: 24,),
                            //Icon(Icons.web,size: 140,color: Colors.blue,),

                            Image.asset(
                              'assets/images/web-development.png',
                              width: 140,
                              height: 140,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Web Development',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                Text(
                                  '5h 30 min',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Text(
                                  '4.9 (522 reviews)',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => CoursePlaylist()));
                },
                child: Container(
                  width: 170,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/development.png',
                        width: 100,
                        height: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Mobile Development',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 20,
                          ),
                          Text(
                            '5h 30 min',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          Text(
                            '4.9 (522 reviews)',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    // SizedBox(height: 24,),
                    //Icon(Icons.web,size: 140,color: Colors.blue,),

                    Image.asset(
                      'assets/images/python.png',
                      width: 140,
                      height: 140,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Python From A to Z',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Text(
                          '5h 30 min',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Text(
                          '4.9 (522 reviews)',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    )));
  }

  showLoaderDialog(BuildContext context) async {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text('Wait for It..'),
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future<void> launch() async {
    await Future.delayed(Duration(milliseconds: 400));

    showLoaderDialog(context);
    print(context.toString());
    await Future.delayed(Duration(seconds: 1));

    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => CoursePlaylist()));
  }
}
