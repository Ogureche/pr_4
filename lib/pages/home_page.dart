import 'package:flutter/material.dart';
import 'package:pr_4/components/item.dart';
import 'create_note_page.dart';
import 'package:pr_4/models/note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }
  void _openNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Item(note: note), // Переход на страницу детали заметки
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index); // Удаление заметки по индексу
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CakeTime'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateNotePage(onCreate: _addNote),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(211, 232, 177, 150),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () => _openNote(note),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(218, 213, 145, 120),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (note.imagePath.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        note.imagePath,
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    note.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white), // Заголовок заметки
                  ),
                  const SizedBox(height: 5),
                  Text(
                    note.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white), // Описание заметки
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₽${note.price}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green), // Цвет для цены
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Подтверждение удаления
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Удалить товар'),
                            content: const Text('Вы уверены, что хотите удалить этот товар?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _deleteNote(index); // Удаляем заметку
                                  Navigator.of(context).pop(); // Закрываем диалог
                                },
                                child: const Text('Да'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(), // Закрываем диалог
                                child: const Text('Нет'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}