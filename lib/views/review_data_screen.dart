import 'package:bayan_task/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:bayan_task/views/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        var cubit = context.read<SignInCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text("Review Data"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder:
                (context, index) =>  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text("Name: ${cubit.tasks[index].name}"),
                        Text("Age: ${cubit.tasks[index].age}"),
                        Text("NationalyId: ${cubit.tasks[index].nationalyId}"),
                        Text("BirthDate: ${cubit.tasks[index].date}"),
                        Row(children: [
                          MaterialButton(onPressed: () {
                            cubit.deletedatabase(id: cubit.tasks[index].id!);
                          },
                            child: Text('delete'),
                          ),
                          MaterialButton(onPressed: () {
                   nameController.text=cubit.tasks[index].name!;
                  ageController.text=cubit.tasks[index].age.toString();
                  nationalityIdController.text=cubit.tasks[index].nationalyId.toString();
                   birthDateController.text=cubit.tasks[index].date!;
                   cubit.deletedatabase(id: cubit.tasks[index].id!);
                            Navigator.pop(context);
                          },
                            child: Text('edit'),
                          )
                        ],)
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index)
                => SizedBox(height: 20,),
                itemCount: cubit.tasks.length),
          ),
        );
      },
    );
  }
}
