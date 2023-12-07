import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class BookPage extends StatefulWidget {
  const BookPage(
      {super.key,
      required this.books,
      required this.category,
      required this.categoryName});

  final List<Book> books;
  final String category;
  final String categoryName;

  @override
  State<StatefulWidget> createState() {
    return _BookPage();
  }
}

final TextEditingController nameController = TextEditingController();

class _BookPage extends State<BookPage> {
  int _currentIndex = 0;

  void _addBook(String category) {
    final name = nameController.text;

    if (name.isNotEmpty) {
      final newBook = Book(id: "b20", title: name, categories: [category]);
      setState(() {
        widget.books.add(newBook);
      });

      nameController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Add Book"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                ElevatedButton(
                  onPressed: () => _addBook(widget.category),
                  child: const Text("Add Book"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Books of category : " + widget.categoryName),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.books.map((book) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(book.title),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: "Book Application",
                        )),
              );
            }
            if (_currentIndex == 1) {
              _showAddModal(context);
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Book Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Book> _filterBooks(String id) {
    return DUMMY_BOOKS
        .where((element) => element.categories.contains(id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: DUMMY_CATEGORIES.map((category) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  List<Book> filtered = _filterBooks(category.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookPage(
                            books: filtered,
                            category: category.id,
                            categoryName: category.title)),
                  );
                },
                child: Card(
                  color: category.color,
                  child: ListTile(
                    title: Text(category.title),
                  ),
                ),
              ));
        }).toList(),
      ),
    );
  }
}

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({required this.id, required this.title, required this.color});
}

class Book {
  final String id;
  final List<String> categories;
  final String title;

  const Book({required this.id, required this.categories, required this.title});
}

final DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Literature',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Self-Help',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Horror',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'History',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Mysteries',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    title: 'Romance',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Westerns',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Comics',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'Health anf Fitness',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Hobbies and Crafts',
    color: Colors.teal,
  ),
  Category(
    id: 'c11',
    title: 'Religion',
    color: Colors.purpleAccent,
  ),
  Category(
    id: 'c12',
    title: 'Science Fiction (Sci-Fi)',
    color: Colors.cyanAccent,
  ),
  Category(
    id: 'c13',
    title: 'Short Stories',
    color: Colors.pink,
  ),
  Category(
    id: 'c14',
    title: 'Suspense and Thrillers',
    color: Colors.amber,
  ),
  Category(
    id: 'c15',
    title: 'Home and Garden',
    color: Colors.black12,
  ),
  Category(
    id: 'c16',
    title: 'Medical',
    color: Colors.teal,
  ),
  Category(
    id: 'c17',
    title: 'Parenting',
    color: Colors.pink,
  ),
];
final DUMMY_BOOKS = [
  Book(
    id: 'b1',
    categories: [
      'c1',
      'c3',
    ],
    title: 'Treasure Island -  Robert Louis Stevenson',
  ),
  Book(
    id: 'b2',
    categories: [
      'c1',
    ],
    title: 'Little Women and Other Novels - Louisa May Alcott',
  ),
  Book(
    id: 'b3',
    categories: [
      'c1',
    ],
    title: 'Frankenstein - Mary Shelley',
  ),
  Book(
    id: 'b4',
    categories: [
      'c1',
    ],
    title: 'To Kill a Mockingbird - Harper Lee',
  ),
  Book(
    id: 'b5',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b6',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b7',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b8',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b9',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b10',
    categories: [
      'c2',
    ],
    title: 'The Alchemist by Paulo Coelho',
  ),
  Book(
    id: 'b11',
    categories: [
      'c2',
    ],
    title: 'Atomic Habits by James Clear',
  ),
  Book(
    id: 'b12',
    categories: [
      'c2',
    ],
    title: 'Thinking Fast And Slow by Daniel Kahneman',
  ),
  Book(
    id: 'b13',
    categories: [
      'c2',
    ],
    title: 'The Four Agreements by Don Miguel Ruiz',
  ),
  Book(
    id: 'b14',
    categories: [
      'c2',
    ],
    title: 'The 7 Habits Of Highly Effective People by Stephen R. Covey',
  ),
  Book(
    id: 'b15',
    categories: [
      'c2',
    ],
    title: 'Best Self by Mike Bayer',
  ),
  Book(
    id: 'b16',
    categories: [
      'c2',
    ],
    title:
        'The Subtle Art of Not Giving a F*ck by Mark Manson Best Self Help Books for Women',
  ),
  Book(
    id: 'b17',
    categories: [
      'c2',
    ],
    title: 'Girl, Wash Your Face by Rachel Hollis',
  ),
  Book(
    id: 'b18',
    categories: [
      'c2',
    ],
    title: '12 Rules For Life by Jordan Peterson',
  ),
  Book(
    id: 'b19',
    categories: [
      'c2',
    ],
    title: 'Big Magic by Elizabeth Gilbert',
  ),
];
