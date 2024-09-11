class UserModal
{
  String email,name,image,phone,token;

  UserModal({required this.email,required this.name,required this.phone,required this.token,required this.image});

  factory UserModal.fromMap(Map m1)
  {
    return UserModal(email : m1['email'],name: m1['name'],phone: m1['phone'],token:  m1['token'],image :m1['image']);
  }

  Map<String, String> toMap(UserModal user)
  {
    return {
      'name' : user.name,
      'email' : user.email,
      'image' : user.image,
      'phone' : user.phone,
      'token' : user.token,
    };
  }
}