import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';
import 'create_quote.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(author: 'Oscar Wilde', text: 'Be yourself; everyone else is already taken', category: 'Inspiration'),
    Quote(author: 'Oscar Wilde', text: 'I have nothing to declare except my genius', category: 'Humor'),
    Quote(author: 'Oscar Wilde', text: 'The truth is rarely pure and never simple', category: 'Philosophy')
  ];

  List<String> categories = ['All', 'Inspiration', 'Humor', 'Philosophy', 'General'];
  String selectedCategory = 'All';
  String searchQuery = '';
  bool showOnlyFavorites = false;
  bool showAddForm = false;

  void createQuote(Quote quote) {
    setState(() {
      quotes.add(quote);
      showAddForm = false;
    });
  }

  void toggleFavorite(int index) {
    setState(() {
      quotes[index].isFavorite = !quotes[index].isFavorite;
    });
  }

  void editQuote(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final textController = TextEditingController(text: quotes[index].text);
        final authorController = TextEditingController(text: quotes[index].author);
        final categoryController = TextEditingController(text: quotes[index].category);
        
        return AlertDialog(
          title: Text('Edit Quote'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: InputDecoration(labelText: 'Quote'),
                  maxLines: 3,
                ),
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                ),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  quotes[index].text = textController.text;
                  quotes[index].author = authorController.text;
                  quotes[index].category = categoryController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  List<Quote> getFilteredQuotes() {
    return quotes.where((quote) {
      if (showOnlyFavorites && !quote.isFavorite) return false;
      
      if (selectedCategory != 'All' && quote.category != selectedCategory) return false;
      
      if (searchQuery.isNotEmpty) {
        return quote.text.toLowerCase().contains(searchQuery.toLowerCase()) ||
               quote.author.toLowerCase().contains(searchQuery.toLowerCase());
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredQuotes = getFilteredQuotes();
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Inspiring Quotes'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(showOnlyFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                showOnlyFavorites = !showOnlyFavorites;
              });
            },
            tooltip: 'Show favorites',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          
          Expanded(
            child: filteredQuotes.isEmpty
                ? Center(child: Text('No quotes found'))
                : ListView.builder(
                    itemCount: filteredQuotes.length,
                    itemBuilder: (context, index) {
                      final originalIndex = quotes.indexOf(filteredQuotes[index]);
                      return QuoteCard(
                        quote: filteredQuotes[index],
                        delete: () {
                          setState(() {
                            quotes.removeAt(originalIndex);
                          });
                        },
                        toggleFavorite: () => toggleFavorite(originalIndex),
                        editQuote: () => editQuote(originalIndex),
                      );
                    },
                  ),
          ),
          
          if (showAddForm)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateQuote(
                create: createQuote,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showAddForm = !showAddForm;
          });
        },
        child: Icon(showAddForm ? Icons.close : Icons.add),
        tooltip: showAddForm ? 'Cancel' : 'Add new quote',
      ),
    );
  }
}

