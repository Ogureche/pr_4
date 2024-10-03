import 'package:flutter/material.dart';
import 'package:pr_4/models/note.dart';

class Item extends StatelessWidget {
  final Note note;

  const Item({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(211, 225, 176, 155),
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, 
              ),
            ),
            const SizedBox(height: 5),
            Text(
              note.description,
              style: const TextStyle(
                color: Colors.white, 
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '₽${note.price}', 
              style: TextStyle(
                color: Colors.green, 
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
