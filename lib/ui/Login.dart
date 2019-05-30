import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthily_v2/style/theme.dart' as Theme;
import 'package:healthily_v2/ui/categories.dart';
import 'package:healthily_v2/utils/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'dart:async';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  var _formKey = GlobalKey<FormState>();

  FirebaseUser myUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);
    // FacebookAccessToken myToken= FacebookLoginResult.accessToken;

    debugPrint(result.status.toString());
    if (result.status == FacebookLoginStatus.loggedIn) {
      AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      
      FirebaseUser firebaseUser= await FirebaseAuth.instance.signInWithCredential(credential);
      return firebaseUser;
    }
    return null;
  }

  void _logIn(){
    _loginWithFacebook().then((response){
      if(response != null){
        myUser = response;
      }
    });
  }

  bool isLogged = false;


  bool sunVal = false;
  bool monVal = false;
  bool tueVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;

  List _gender = ["Male", "Female", "Other"];
  List _time = ["Morning", "Day", "Evening"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuItems1;

  String _currentGender;

  String _currentTime;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String gender in _gender) {
      items.add(new DropdownMenuItem(value: gender, child: new Text(gender)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems1() {
    List<DropdownMenuItem<String>> items1 = new List();
    for (String time in _time) {
      items1.add(new DropdownMenuItem(value: time, child: new Text(time)));
    }
    return items1;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();
  TextEditingController signupAgeController = new TextEditingController();
  TextEditingController signupGenderController = new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: new Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientStart,
                        Theme.Colors.loginGradientEnd
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 75.0),
                      child: new Image(
                        width: 250.0,
                        height: 191.0,
                        fit: BoxFit.fill,
                        image: new AssetImage(
                          'assets/images/nobg.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: _buildMenuBar(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                            });
                          }
                        },
                        children: <Widget>[
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignIn(context),
                          ),
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignUp(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _dropDownMenuItems = getDropDownMenuItems();
    _currentGender = _dropDownMenuItems[0].value;

    _dropDownMenuItems1 = getDropDownMenuItems1();
    _currentTime = _dropDownMenuItems1[0].value;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white70,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Existing",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "New",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 230.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter your Email';
                            }
                          },
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter your Password';
                            }
                          },
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 210.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Categories()));
                        }
                      });
                    }),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white10,
                          Colors.white,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: "WorkSansMedium"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white10,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 40.0),
                child: GestureDetector(
                  onTap: _logIn,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.facebookF,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => showInSnackBar("Google button pressed"),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.google,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return ListView(children: <Widget>[
      GestureDetector(
        child: Container(
          padding: EdgeInsets.only(top: 23.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 930.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Enter your Name';
                                }
                              },
                              focusNode: myFocusNodeName,
                              controller: signupNameController,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Colors.black,
                                ),
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter your Email';
                                }
                              },
                              focusNode: myFocusNodeEmail,
                              controller: signupEmailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                ),
                                hintText: "Email Address",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Enter your Password';
                                }
                              },
                              focusNode: myFocusNodePassword,
                              controller: signupPasswordController,
                              obscureText: _obscureTextSignup,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.lock,
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleSignup,
                                  child: Icon(
                                    FontAwesomeIcons.eye,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Confirm your Password ';
                                }
                              },
                              controller: signupConfirmPasswordController,
                              obscureText: _obscureTextSignupConfirm,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.lock,
                                  color: Colors.black,
                                ),
                                hintText: "Confirmation",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleSignupConfirm,
                                  child: Icon(
                                    FontAwesomeIcons.eye,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Age';
                                }
                              },
                              controller: signupAgeController,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.hourglass,
                                  color: Colors.black,
                                ),
                                hintText: "Age",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontFamily: "WorkSansBold", fontSize: 16.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10.0, left: 25.0, right: 25.0),
                            child: DropdownButton(
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              value: _currentGender,
                              items: _dropDownMenuItems,
                              onChanged: changedDropDownItem,
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Text(
                            "Preferred Time",
                            style: TextStyle(
                                fontFamily: "WorkSansBold", fontSize: 16.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 25.0,
                                right: 25.0),
                            child: DropdownButton(
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              value: _currentTime,
                              items: _dropDownMenuItems1,
                              onChanged: changedDropDownItem1,
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Text(
                            "Preferred Day",
                            style: TextStyle(
                                fontFamily: "WorkSansBold", fontSize: 16.0),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 2.5,
                                    left: 50.0,
                                    right: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    //Sunday
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Sun"),
                                        Checkbox(
                                          activeColor: Colors.black,
                                          value: sunVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              sunVal = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                    //Monday
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Mon"),
                                        Checkbox(
                                          activeColor: Colors.black,
                                          value: monVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              monVal = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Tue"),
                                        Checkbox(
                                          activeColor: Colors.black,
                                          value: tueVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              tueVal = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Wed"),
                                        Checkbox(
                                          activeColor: Colors.black,
                                          value: wedVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              wedVal = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 2.5,
                                left: 70.0,
                                right: 20.0,
                                bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Thu"),
                                    Checkbox(
                                      activeColor: Colors.black,
                                      value: thurVal,
                                      onChanged: (bool value) {
                                        setState(() {
                                          thurVal = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Fri"),
                                    Checkbox(
                                      activeColor: Colors.black,
                                      value: friVal,
                                      onChanged: (bool value) {
                                        setState(() {
                                          friVal = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Sat"),
                                    Checkbox(
                                      activeColor: Colors.black,
                                      value: satVal,
                                      onChanged: (bool value) {
                                        setState(() {
                                          satVal = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 900.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: new LinearGradient(
                          colors: [
                            Theme.Colors.loginGradientEnd,
                            Theme.Colors.loginGradientStart
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Categories()));
                            }
                          });
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  void changedDropDownItem(String selectedGender) {
    setState(() {
      _currentGender = selectedGender;
    });
  }

  void changedDropDownItem1(String selectedTime) {
    setState(() {
      _currentTime = selectedTime;
    });
  }
}
