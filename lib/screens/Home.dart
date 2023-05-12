import 'package:farm_sanctuary_delivery/services/graphqlService.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  final String id;

  const Home({Key? key, required this.id}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<dynamic>> _deliveryFuture;
  final GraphQLService _graphQLService = GraphQLService();
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    _deliveryFuture = _graphQLService.getAlldeliveries(widget.id);
  }

  Future<void> _refreshDeliveryData() async {
    setState(() {
      _deliveryFuture = _graphQLService.getAlldeliveries(widget.id);
    });
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
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _deliveryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            List<dynamic> orders = snapshot.data!;
            if (orders.length > 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: const Text(
                        "Your deliveries has been set ,\n Drive safe and have a productive day ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: false,
                        itemCount: orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.blueAccent, width: 1),
                                ),
                                child: Column(
                                  children: [
                                    ExpansionTile(
                                      initiallyExpanded: true,
                                      title: Text(
                                        "Delivery ID : " + orders[index]['id'],
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      ),
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
                                                Text("Destination: " +
                                                    orders[index]['location']['houseStreetnumber'] +
                                                    ', ' +
                                                    orders[index]['location']['city'] +
                                                    ', ' +
                                                    orders[index]['location']['state'] +
                                                    ', ' +
                                                    orders[index]['location']['country']),
                                                // Text("Pick uplocation : " + orders[index]['location']['codePostal']),
                                                Text("Pick uplocation : " + "Tunis"),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    // if (_deliveryFuture != null) {
                                                    //   // check if the field is null before accessing it
                                                    //   await _graphQLService.updateOrderDeliveryStatus(
                                                    //       orders[index]['id'], true);
                                                    //   setState(() {
                                                    //     _deliveryFuture = _graphQLService
                                                    //         .getAlldeliveries(widget.id); // update the future
                                                    //   });
                                                    // }
                                                    // print("pressed !");
                                                    await _graphQLService.updateOrderDeliveryStatus(
                                                        orders[index]['id'], true);
                                                    await _refreshDeliveryData();
                                                    setState(() {});
                                                  },
                                                  child: Text('Delivered'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.grey[700],
                      size: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No orders found to deliver",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
