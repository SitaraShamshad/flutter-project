import 'package:flutter/material.dart';

class DuaCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  DuaCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class DuaCategoriesScreen extends StatelessWidget {
  final List<DuaCategory> categories = [
    DuaCategory(title: 'Morning & Evening', subtitle: '6 Chapters', icon: Icons.nights_stay, color: Colors.blue[700]!),
    DuaCategory(title: 'Praising Allah', subtitle: '9 Chapters', icon: Icons.all_out, color: Colors.teal[200]!),
    DuaCategory(title: 'Hajj & Umrah', subtitle: '8 Chapters', icon: Icons.mosque, color: Colors.yellow[200]!),
    DuaCategory(title: 'Travel', subtitle: '11 Chapters', icon: Icons.airplanemode_active, color: Colors.amber[200]!),
    DuaCategory(title: 'Joy & Distress', subtitle: '15 Chapters', icon: Icons.sentiment_very_satisfied, color: Colors.orange[200]!),
    DuaCategory(title: 'Nature', subtitle: '10 Chapters', icon: Icons.nature, color: Colors.lime[200]!),
    DuaCategory(title: 'Good Etiquette', subtitle: '10 Chapters', icon: Icons.self_improvement, color: Colors.purple[200]!),
    DuaCategory(title: 'Home & Family', subtitle: '10 Chapters', icon: Icons.home, color: Colors.cyan[200]!),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duas'),
        backgroundColor: Color(0xFF008080), // Teal color for the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBarViewExample(), // Add the tab bar view
            SizedBox(height: 20),
            Text(
              'Hisnul Muslim (Fortress of the Muslim)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    color: category.color,
                    child: InkWell(
                      onTap: () {
                        // Handle category tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(category.icon, size: 40, color: Colors.white),
                            SizedBox(height: 10),
                            Text(category.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 5),
                            Text(category.subtitle, style: TextStyle(fontSize: 14, color: Colors.white)),
                          ],
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

class TabBarViewExample extends StatefulWidget {
  @override
  _TabBarViewExampleState createState() => _TabBarViewExampleState();
}

class _TabBarViewExampleState extends State<TabBarViewExample> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Categories'),
            Tab(text: 'My Duas'),
          ],
        ),
        Container(
          height: 50, // Adjust the height as needed
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(),
              Container(),
            ],
          ),
        ),
      ],
    );
  }
}

