import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_monetering/landing/landingbloc.dart';

class TankScreen extends StatefulWidget {
  @override
  _TankScreenState createState() => _TankScreenState();
}

class _TankScreenState extends State<TankScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  String selectedTab = "0-25";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
    context.read<TankBloc>().add(LoadTanks());
    // ✅ Then, apply the "0-25" filter after a slight delay
    Future.delayed(Duration(milliseconds: 100), () {
      _applyFilter();
    });
  }

  void _handleTabChange() {
    List<String> tabs = ["0-25", "25-60", "60-100", "All"];
    setState(() {
      selectedTab = tabs[_tabController.index];
    });
    _applyFilter();
  }

  void _applyFilter() {
    context.read<TankBloc>().add(
      FilterTanks(query: _searchController.text, tab: selectedTab),
    );
  }

  void _refreshData() {
    _searchController.clear();
    _tabController.animateTo(0); // Reset to first tab
    setState(() {
      selectedTab = "0-25";
    });
    context.read<TankBloc>().add(LoadTanks()); // Reload the full list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tank Level Monitoring",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<TankBloc>().add(LoadTanks()); // ✅ Reload all data

              // ✅ Apply the filter for the current tab after a slight delay
              Future.delayed(Duration(milliseconds: 100), () {
                _applyFilter();
              });
            },
          ),
        ],
        backgroundColor: Colors.teal,
       iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.teal,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "0-25"),
                Tab(text: "25-60"),
                Tab(text: "60-100"),
                Tab(text: "All"),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) => _applyFilter(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white, // Background color
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "Search Panchayat",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ), // Better spacing
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ), // Highlighted when focused
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          // Tank List
          Expanded(
            child: BlocBuilder<TankBloc, TankState>(
              builder: (context, state) {
                if (state is TankLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TankLoaded) {
                  if (state.tanks.isEmpty) {
                    return Center(child: Text("No tanks found"));
                  }

                  return ListView.builder(
                    itemCount: state.tanks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.storage),
                        title: Text(state.tanks[index].name),
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Error loading data"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
