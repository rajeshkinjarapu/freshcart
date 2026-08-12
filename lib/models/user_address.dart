class UserAddress {
  final String flat, area, landmark, pincode;
  final double latitude, longitude;
  const UserAddress({required this.flat, required this.area, required this.landmark, required this.pincode, required this.latitude, required this.longitude});
  Map<String, dynamic> toMap() => {'flat': flat, 'area': area, 'landmark': landmark, 'pincode': pincode, 'latitude': latitude, 'longitude': longitude, 'createdAt': DateTime.now()};
}
