class DeliveryAgent {
  final String fullName;
  final String longitude;
  final String latitude;

  DeliveryAgent({
    required this.fullName,
    required this.longitude,
    required this.latitude,
  });

  factory DeliveryAgent.fromJson(Map<String, dynamic> json) {
    return DeliveryAgent(
      fullName: json['fullName'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
    );
  }
}
