class AppUser {
  final String uid, name, phone, email;
  const AppUser({required this.uid, required this.name, required this.phone, this.email = ''});
  Map<String, dynamic> toMap() => {'uid': uid, 'name': name, 'phone': phone, 'email': email, 'createdAt': DateTime.now()};
}
