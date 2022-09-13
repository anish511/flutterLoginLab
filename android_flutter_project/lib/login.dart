import 'package:flutter/material.dart';
import 'package:my_first_android_flutter_project/services/auth_service.dart';
import 'package:my_first_android_flutter_project/welcome.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isBothValid = false;
  final GlobalKey<FormState> _key = GlobalKey();
  String emailLocal = "", passwordLocal = "";
  DBHelper? dbHelper = DBHelper();

  void successNavigation(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }
  void loginSubmitEvent() async {
    final String emailToBeSent = _emailController.text.trim();
    final String passwordToBeSent = _passwordController.text.trim();
    var response = await dbHelper!.isEmailExist(emailToBeSent,passwordToBeSent);
    if (response) {
      successNavigation();
    } else {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('User not Found!!'),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assests/login.png"), fit: BoxFit.cover)),
       child: Scaffold(
         backgroundColor: Colors.transparent,
         body: Stack(
           children: [
             Container(
               padding: EdgeInsets.only(left: 35, top: 135),
               child: Text('Welcome\nBack',
                 style: TextStyle(color: Colors.white, fontSize: 35),),
             ),
             SingleChildScrollView(
               child: Container(
                 padding: EdgeInsets.only(
                   top: MediaQuery.of(context).size.height * 0.5,
                   right: 35,
                   left: 35
                 ),
                 child: Column(
                   children: [
                     TextField(
                       controller: _emailController,
                       decoration: InputDecoration(
                         fillColor: Colors.grey.shade100,
                         filled: true,
                         hintText: 'Email',
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10)
                         )
                       ),
                     ),
                     SizedBox(height: 30,),
                     TextField(
                       obscureText: true,
                       controller: _passwordController,
                       decoration: InputDecoration(
                         fillColor: Colors.grey.shade100,
                         filled: true,
                         hintText: 'Password',
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10)
                         )
                     ),
                     ),
                     SizedBox(height: 40,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           'Sign In',
                           style: TextStyle(
                             color: Color(0xff4c505b),
                           fontSize: 27, fontWeight: FontWeight.w700),
                         ),
                         CircleAvatar(
                           radius: 30,
                           backgroundColor: Color(0xff4c505b),
                           child: IconButton(
                             color: Colors.white,
                             onPressed: () => loginSubmitEvent(),
                             icon: Icon(Icons.arrow_forward),
                           ),
                         )
                       ],
                     ),
                     SizedBox(height: 40,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         TextButton(onPressed: (){
                           Navigator.pushNamed(context, 'register');
                         },
                             child: Text(
                               'Sign Up',
                               style: TextStyle(
                                 decoration: TextDecoration.underline,
                                 fontSize: 15,
                                 color: Color(0xff4c505b),
                               ),
                             )),
                         TextButton(onPressed: (){},
                             child: Text(
                               'Forgot Password',
                               style: TextStyle(
                                 decoration: TextDecoration.underline,
                                 fontSize: 15,
                                 color: Color(0xff4c505b),
                               ),
                             ))
                       ],
                     )
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
    );
  }
}