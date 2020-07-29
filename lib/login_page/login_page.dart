import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newedok/cities_page/cities_page.dart';
import 'package:newedok/themes/fond_and_colors.dart';
import '../services/imports.dart';
import '../services/api_services/requests.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPageForm(),
      ),
    );
  }
}

class LoginPageForm extends StatefulWidget {
  @override
  _LoginPageFormState createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  TextEditingController phone_numberController = TextEditingController();
  TextEditingController sms_confirm_codeController = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7(###)###-##-##', filter: {"#": RegExp(r'[0-9]')});
  var codeMask = new MaskTextInputFormatter(
      mask: '######', filter: {"#": RegExp(r'[0-9]')});
  bool _autoValidate = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String validateMobile(String value) {
    if (value.length != 16)
      return 'Неверный формат телефона';
    else
      return null;
  }

  void _validateInputs() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<void> _smsInput() async {
    await animated_dialog_box.showScaleAlertBox(
      title: Center(
          child: Text(
        "Введите код",
        style: Thm.of(context).contentBodyTitleBold,
      )),
      context: context,
      firstButton: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        color: Thm.of(context).primaryColor,
        elevation: 0,
        child: Text('Продолжить'),
        onPressed: () {
          ApiService.phoneCodeSend(phone_numberController.text,
              sms_confirm_codeController.text, context)
              .then((codeAccepted) {
            if (codeAccepted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return CitiesPage();
                }),
                    (Route<dynamic> route) => false,
              );
              Navigator.of(context, rootNavigator: true).pop(context);
            }
          },
          );
        },
      ),
      secondButton: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 0,
        color: Thm.of(context).primaryColor,
        child: Text('Закрыть'),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop(context);
        },
      ),
      icon: Icon(
        Icons.arrow_right,
        size: 0.1,
      ),
      // IF YOU WANT TO ADD ICON
      yourWidget: TextFormField(
        controller: sms_confirm_codeController,
        decoration: new InputDecoration(
          labelText: "Введите код",
          fillColor: Thm.of(context).primaryColor,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ApiService.getCities(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: new AssetImage("assets/login_page/burgers.jpg"),
              fit: BoxFit.cover,
              color: Colors.black54,
              colorBlendMode: BlendMode.darken,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(
                      bottom: size.height / 3, left: size.width / 9),
                  child: Text(
                    'Войти',
                    style: TextStyle(
                        color: Thm.of(context).primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                    child: Form(
                        child: new Theme(
                            data: new ThemeData(
                                brightness: Brightness.dark,
                                primarySwatch: Colors.teal,
                                inputDecorationTheme: new InputDecorationTheme(
                                    labelStyle: new TextStyle(
                                        color: Colors.teal, fontSize: 20.0))),
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 50, bottom: 50),
                                child: new Column(children: <Widget>[
                                  Form(
                                    key: formKey,
                                    autovalidate: _autoValidate,
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      maxLength: 16,
                                      inputFormatters: [maskFormatter],
                                      controller: phone_numberController,
                                      decoration: new InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Thm.of(context).blackColor),
                                        hintStyle: TextStyle(
                                            color:
                                                Thm.of(context).primaryColor),
                                        helperStyle: TextStyle(
                                            color:
                                                Thm.of(context).primaryColor),
                                        hintText: 'Номер телефона',
                                      ),
                                      validator: validateMobile,
                                      onSaved: (String val) {
                                        phone_numberController.text = val;
                                      },
                                    ),
                                  ),
                                ]))))),
                Container(
                    height: size.height / 11,
                    width: size.width / 1.3,
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: new MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28)),
                          color: Color(0xffFF6E40),
                          textColor: Thm.of(context).primaryColor,
                          child: new Text(
                            'Войти',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            _validateInputs();
                            if (validateMobile(phone_numberController.text) !=
                                null) {
                            } else {
                              ApiService api = new ApiService();
                              api
                                  .phoneSend(phone_numberController.text)
                                  .then((phoneAccepted) {
                                if (phoneAccepted) {
                                  _smsInput();
                                }
                              });
                            }
                          }),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
