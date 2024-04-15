import 'package:bayan_task/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:bayan_task/views/review_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var nameController = TextEditingController();
var ageController = TextEditingController();
var nationalityIdController = TextEditingController();
var birthDateController = TextEditingController();

class SignInScreen extends StatelessWidget {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Column(
          children: <Widget>[
            Theme(

              data: ThemeData.light().copyWith(
                textTheme: ThemeData
                    .light()
                    .textTheme
                    .copyWith(
                  bodyLarge: TextStyle(fontSize: 16), // Set smaller font size
                ),
                colorScheme: ColorScheme.light().copyWith(
                  primary: Colors.green, // Set primary color to green
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  height: 500,
                  width: 500,
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
      context: context,

      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      birthDateController.text = selectedDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        var cubit = context.read<SignInCubit>();
        return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Age',
                      ),
                      controller: ageController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'NationalyId',
                      ),
                      controller: nationalityIdController,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        hintText: 'BirthDate',
                      ),
                      controller: birthDateController,
                    ),
                    MaterialButton(onPressed: () {
                      cubit.insertdatabase(
                        nationalyId: nationalityIdController.text,
                        name: nameController .text,
                        age: ageController.text,
                        date: birthDateController.text,);

                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => ReviewScreen(),));
                    },
                      child: Text('Save'),
                    )
                  ],),
              ),
            )
        );
      },
    );
  }
}