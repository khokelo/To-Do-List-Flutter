import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List Interaktif',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _todos = [];

  void _addTodo() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _todos.add({'task': _controller.text, 'isDone': false});
      _controller.clear();
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index]['isDone'] = !_todos[index]['isDone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List Interaktif'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Text Field
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ketik tugas baru...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo, // ➜ event onPressed
                ),
              ),
              onChanged: (value) {
                // ➜ event onChanged
              },
            ),
            const SizedBox(height: 20),

            // Daftar tugas dinamis
            Expanded(
              child: _todos.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada tugas 😴',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final todo = _todos[index];
                        return GestureDetector(
                          onTap: () => _toggleDone(index), // ➜ event onTap
                          child: Card(
                            color: todo['isDone']
                                ? Colors.teal[100]
                                : Colors.white,
                            child: ListTile(
                              title: Text(
                                todo['task'],
                                style: TextStyle(
                                  fontSize: 18,
                                  decoration: todo['isDone']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: todo['isDone']
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              trailing: Icon(
                                todo['isDone']
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: todo['isDone']
                                    ? Colors.teal
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
