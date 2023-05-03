class Order {
  List<Map<String, dynamic>> cartItems;
  double totalPrice;
  bool isDelivered;
  bool isConfirmed;
  Map<String, dynamic> location;

  Order({
    required this.cartItems,
    required this.totalPrice,
    required this.isDelivered,
    required this.isConfirmed,
    required this.location,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      cartItems: List<Map<String, dynamic>>.from(map['cartItems'].map((item) => item.toMap())),
      totalPrice: map['totalPrice'],
      isDelivered: map['isDelivered'],
      isConfirmed: map['isConfirmed'],
      location: Map<String, dynamic>.from(map['location']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartItems': cartItems,
      'totalPrice': totalPrice,
      'isDelivered': isDelivered,
      'isConfirmed': isConfirmed,
      'location': location,
    };
  }
}
