import 'package:flutter/material.dart';
import 'quote.dart';

class CreateQuote extends StatefulWidget {
  final Function create;

  CreateQuote({required this.create});

  @override
  _CreateQuoteState createState() => _CreateQuoteState();
}

class _CreateQuoteState extends State<CreateQuote> {
  final _textController = TextEditingController();
  final _authorController = TextEditingController();
  final _categoryController = TextEditingController(text: 'General');
  
  @override
  void dispose() {
    _textController.dispose();
    _authorController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Add New Quote',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Quote',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'Author',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _textController.clear();
                    _authorController.clear();
                    _categoryController.text = 'General';
                  },
                  child: Text('Clear'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      widget.create(Quote(
                        text: _textController.text,
                        author: _authorController.text,
                        category: _categoryController.text.isNotEmpty ? 
                                 _categoryController.text : 'General',
                      ));
                      _textController.clear();
                      _authorController.clear();
                      _categoryController.text = 'General';
                    }
                  },
                  child: Text('Add Quote'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}