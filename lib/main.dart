import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Formpage(),
    );
  }
}

class Formpage extends StatefulWidget {
  const Formpage({super.key});

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  final _formkey = GlobalKey<FormState>();
  late String firstname;
  late String lastname;
  late int age;

  String? selectedGender;

  bool _isOption1 = false;
  bool _isOption2 = false;
  bool _isOption3 = false;

  List<String> selectedOptions = [];
  void _onRadioButtonChange(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Form"),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Firstname"),
                  TextFormField(
                    onSaved: (value) => setState(() {
                      firstname = value!;
                    }),
                  ),
                  Text("Lastname"),
                  TextFormField(
                    onSaved: (value) => setState(() {
                      lastname = value!;
                    }),
                  ),
                  Text("Age"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (value) => setState(() {
                      age = int.parse(value!);
                    }),
                  ),
                  Text("Gender"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Male'),
                      Radio(
                          value: 'Male',
                          groupValue: selectedGender,
                          onChanged: (value) => _onRadioButtonChange(value!)),
                      Text('Female'),
                      Radio(
                          value: 'Female',
                          groupValue: selectedGender,
                          onChanged: (value) => _onRadioButtonChange(value!))
                    ],
                  ),
                  Text("Symtomps"),
                  Column(
                    children: [
                      CheckboxListTile(
                        title: Text("ไอ"),
                        value: _isOption1,
                        onChanged: (val) {
                          setState(() {
                            _isOption1 = !_isOption1;
                            if (_isOption1) {
                              selectedOptions.add('ไอ');
                            } else {
                              selectedOptions.remove('ไอ');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("เจ็บคอ"),
                        value: _isOption2,
                        onChanged: (val) {
                          setState(() {
                            _isOption2 = !_isOption2;
                            if (_isOption2) {
                              selectedOptions.add('เจ็บคอ');
                            } else {
                              selectedOptions.remove('เจ็บคอ');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("มีไข้"),
                        value: _isOption3,
                        onChanged: (val) {
                          setState(() {
                            _isOption3 = !_isOption3;
                            if (_isOption3) {
                              selectedOptions.add('มีไข้');
                            } else {
                              selectedOptions.remove('มีไข้');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        print(firstname);

                        print(selectedGender);
                        print(selectedOptions);
                        print('Save');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Page1(
                                    firstname: firstname,
                                    lastname: lastname,
                                    age: age,
                                    gender: selectedGender,
                                    symtomps: selectedOptions,
                                  )),
                        );
                      }
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    Key? key,
    this.firstname,
    this.lastname,
    required this.age,
    this.gender,
    required this.symtomps,
  }) : super(key: key);

  final String? firstname;
  final String? lastname;
  final int age;
  final String? gender;

  final List<String> symtomps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Image.network(
                'https://as2.ftcdn.net/v2/jpg/03/30/96/09/1000_F_330960978_aWCwNWhAo3i7azG4wfvskSCoWGPw8fCY.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50),
            covidDetect(symtomps)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('ยืนยัน'),
        backgroundColor: Colors.blue.shade300,
      ),
    );
  }

  Widget covidDetect(List<String> symtomps) {
    if (symtomps.length == 3) {
      return Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.redAccent.shade400,
        ),
        child: Center(
            child: Text("คุณ $firstname $lastname, อายุ $age คุณเป็นโควิท")),
      );
    } else {
      return Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.greenAccent.shade400,
        ),
        child: Center(
            child:
                Text("คุณ $firstname $lastname, อายุ $ageคุณไม่ได้เป็นโควิท")),
      );
    }
  }
}
