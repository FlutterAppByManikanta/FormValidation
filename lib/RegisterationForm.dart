import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RegisterationForm extends StatefulWidget {
  const RegisterationForm({super.key});

  @override
  State<RegisterationForm> createState() => _RegisterationFormState();
}

class _RegisterationFormState extends State<RegisterationForm> {

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  // Validation for Email
  String? validateEmail(String? email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(email == null || email.isEmpty) {
      return "Email is Required";
    } else if (!emailRegex.hasMatch(email)) {
      return "Enter Valid Email";
    }
    return null;
  }

  // validation for PhoneNumber
  String? validatePhoneNumber(String? phoneNumber) {
    final phoneNumberRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return "PhoneNumber is Required";
    } else if (!phoneNumberRegex.hasMatch(phoneNumber)) {
      return "Enter Valid PhoneNumber";
    }
    return null;
  }

  // Validation FirstName
  String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return "FirstName is Required";
    }
    return null;
  }

  //validation for DOB
  String? validateDOB(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.isEmpty) {
      return "DateOfBirth is Required";
    }
    try {
      DateFormat.yMd().parseStrict(dateOfBirth);
    }catch(e) {
      return "Enter a Valid Date (MM/DD/YYYY)";
    }
    return null;
  }

  // PickDate from DatePicker
  Future<void> _pickDate(BuildContext context) async {

    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1901),
      lastDate: DateTime.now()
    );

    if (date != null) {
      dateOfBirthController.text = DateFormat.yMd().format(date);
    }
  }

  void _submitForm() {
    if(_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Form Submitted SuccessFully")));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RegistrationForm"),
      backgroundColor: Colors.pinkAccent,),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              // FirstName Field
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: "FirstName"),
                validator: validateFirstName,
              ),

              SizedBox(height: 16,),

              //Email Field

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 16,),

              //PhoneNumber Field
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: "PhoneNumber"),
                validator: validatePhoneNumber,
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 16,),

              // DOB Field

              TextFormField(
                controller: dateOfBirthController,
                decoration: InputDecoration(
                    labelText: "DateOfBirth",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          _pickDate(context);
                        },
                    ),
                ),
                validator: validateDOB,
                readOnly: true,
              ),

              SizedBox(height: 16,),

              ElevatedButton(onPressed: _submitForm, child: Text("Register"))
            ],
          ),
        ),
      )
    );
  }
}
