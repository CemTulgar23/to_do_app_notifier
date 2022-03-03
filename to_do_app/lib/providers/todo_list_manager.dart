import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: Uuid().v4(), description: "Spora Git"),
    TodoModel(id: Uuid().v4(), description: "Alışverişe Git"),
  ]);
});

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    //state: burada List<TodoModel> i temsil ediyor.
    //aslında super() içerisine gönderilen değeri temsil ediyor.
    //initialTodos dolu ise var olan değeri boş ise de [] döndürüyor.
    var eklenecekTodo = TodoModel(id: Uuid().v4(), description: description);
    state = [...state, eklenecekTodo];
    //Hem state'in içindeki elemanları hem de eklenecekTodo'yu listeye koyduk.
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: todo.description,
            completed: !todo.completed,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: newDescription,
            completed: todo.completed,
          )
        else
          todo,
    ];
  }

  void remove(TodoModel silinecekTodo) {
    state = state.where((element) => element.id != silinecekTodo.id).toList();
    //yeni bir state oluşturuyoruz -where bize yeni bir state oluşturuyor-
    //önceki listedeki elemanları dolaşıyor ve id aynı değilse bu todoModel'i
    //yeni listeye ekliyor. Bu listeyi de state değerine atıyoruz.
  }
}
