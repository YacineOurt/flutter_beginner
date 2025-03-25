import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final Function delete;
  final Function toggleFavorite;
  final Function editQuote;

  QuoteCard({
    required this.quote, 
    required this.delete,
    required this.toggleFavorite,
    required this.editQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Chip(
                  label: Text(quote.category),
                  backgroundColor: Colors.blue[100],
                ),
                Spacer(),
                Text(
                  '${quote.dateAdded.day}/${quote.dateAdded.month}/${quote.dateAdded.year}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              quote.text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              quote.author.isEmpty ? 'Anonymous' : quote.author,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: quote.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => toggleFavorite(),
                  tooltip: 'Add to favorites',
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => editQuote(),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => delete(),
                  tooltip: 'Delete',
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Share functionality to be implemented
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sharing quote...')),
                    );
                  },
                  tooltip: 'Share',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}