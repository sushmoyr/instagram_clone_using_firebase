class User {
  final String email;
  final String uid;
  final String imageUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.uid,
    required this.imageUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': [],
        'following': [],
        'imageUrl': imageUrl,
      };
}
