import 'package:bayan_task/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Database ?database;
  createDatabase()async
  {
    await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          print("Database created");
          database.execute('CREATE TABLE task (id INTEGER PRIMARY KEY,name TEXT, age DOUBLE, nationalyId INTEGER, birthDate TEXT)')
              .then((value) {
            print("Table created");
          }).catchError((error) {
            print("Error when creating table: ${error.toString()}");
          });
        },
        onOpen: (database) {
          getdatafromdatabase(database);
        }
    ).then((value){
      database=value;
      emit(Appcreatedbstate());
    });
  }
  void insertdatabase({required String name,
    required String age,
    required String date,

    required String ?nationalyId
  }) {

    database?.transaction((txn) async{
      await txn.rawInsert('INSERT INTO task (name,age, nationalyId, birthDate) '
          'VALUES("$name","$age", "$nationalyId", "$date")')
          .then((value) {
        getdatafromdatabase(database);
        emit(Appinsertdbstate());
      }).catchError((error) {
        print('Error when inserting into table: ${error.toString()}');
      });
    });
  }

  List<DataModel>tasks=[];
  void getdatafromdatabase(database)async {
    tasks.clear();
    await database.rawQuery('SELECT * FROM task').then((value){
      value.forEach((element){
        tasks.add(DataModel(id: element['id'], name: element['name'], age: element['age'].toString(), date: element['birthDate'].toString()));
      });

    });
    tasks=tasks.toSet().toList();
    emit(Appgetdbstate());
  }



  void deletedatabase({required int id})async{
    await database!.rawDelete('DELETE FROM task WHERE id=?',[id])
        .then((value) {
      getdatafromdatabase(database);
      emit(Appdeletedbstate());
    });
    getdatafromdatabase(database);
  }
  void updatedatabase({required int id,
    required String name,
    required String age,
    required String date,
   required String ?nationalyId
  })async{
    await database!.rawDelete('UPDATE Test SET name = ?, age = ?,nationalyId = ?,birthDate = ?  WHERE id = $id',
        ['$name', '$age', '$nationalyId', '$date'])
        .then((value) {
      getdatafromdatabase(database);
      emit(Appdeletedbstate());
    });
    getdatafromdatabase(database);
    tasks=tasks.toSet().toList();
  }
}
