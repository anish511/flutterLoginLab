import 'package:flutter/material.dart';
import 'package:my_first_android_flutter_project/services/auth_service.dart';
import 'package:my_first_android_flutter_project/welcome.dart';
import 'model/user.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isBothValid = false;
  final GlobalKey<FormState> _key = GlobalKey();
  String emailLocal = "Om", passwordLocal = "om";
  DBHelper? dbHelper = DBHelper();

  void singupSubmitEvent() {
    String emailToBeSent = _emailController.text.trim();
    String passwordToBeSent = _passwordController.text.trim();
    dbHelper!
        .insert(
      User(email: emailToBeSent, password: passwordToBeSent),
    ).then((value) {
      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Registered Successfully'),
        duration: Duration(seconds: 1),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).onError((error, stackTrace) {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Something Went Wrong!!'),
        duration: Duration(seconds: 1),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }

      @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assests/register.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 135),
              child: Text('Register\nNow',
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
                          'Sign Up',
                          style: TextStyle(
                              color: Color(0xff4c505b),
                              fontSize: 27, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () => singupSubmitEvent(),
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     TextButton(onPressed: (){},
                    //         child: Text(
                    //           'Sign Up',
                    //           style: TextStyle(
                    //             decoration: TextDecoration.underline,
                    //             fontSize: 15,
                    //             color: Color(0xff4c505b),
                    //           ),
                    //         )),
                    //     TextButton(onPressed: (){},
                    //         child: Text(
                    //           'Forgot Password',
                    //           style: TextStyle(
                    //             decoration: TextDecoration.underline,
                    //             fontSize: 15,
                    //             color: Color(0xff4c505b),
                    //           ),
                    //         ))
                    //   ],
                    // )
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

