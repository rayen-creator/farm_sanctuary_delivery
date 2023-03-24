import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
  final List<int> colorCodes = <int>[600, 500, 100];

  //****************Getting_current_postion_through_GPS*****************
  String location = 'Null';
  String Address = 'Null';
  //**********************************************

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(
      AssetImage('assets/images/background.jpg'),
      context,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.9),
        elevation: 0,
        title: const Center(
            child: Text(
          "Delivery list",
          style: TextStyle(
            color: Colors.white,
            // decoration: TextDecoration.underline,
          ),
        )),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                // image: background.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Center(
                  child: Text(
                "Delivery list",
                style: TextStyle(
                  color: Color(0xff0E4F55),
                  decoration: TextDecoration.underline,
                ),
              )),
            ),
          ),
          Center(
              child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: Colors.blueAccent, width: 1)),
                                child: Column(children: [
                                  ExpansionTile(
                                      initiallyExpanded: true,
                                      title: Text("Delivery ID " + entries[index],
                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                      backgroundColor: Colors.white12,
                                      children: [
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Pick up location : " + entries[index]),
                                                  Text("Destination : " + entries[index]),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ])
                                ])
                                // child: Card(
                                //   color: Colors.white.withOpacity(0.8),
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(25.0),
                                //   ),
                                //   elevation: 0,
                                //   child: Column(
                                //     children: [Text('Entry ${entries[index]}')],
                                //   ),
                                // ),
                                )));
                  })

              // children: [

              // ],
              ),

          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          //   child: Card(
          //     color: Colors.white.withOpacity(0.8),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(25.0),
          //     ),
          //     elevation: 0,
          //     child: Column(
          //       children: [Text("data")],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
