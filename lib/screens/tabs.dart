import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_tracking_app/models/lifts.dart';
import 'package:workout_tracking_app/providers/Weights_provider.dart';
import 'package:workout_tracking_app/providers/lifts_provider.dart';
import 'package:workout_tracking_app/screens/cardio.dart';
import 'package:workout_tracking_app/providers/cardio_provider.dart';
import 'package:workout_tracking_app/models/cardio.dart';
import 'package:workout_tracking_app/models/weights.dart';
import 'package:workout_tracking_app/services/data_service.dart';
import 'package:workout_tracking_app/screens/weights.dart';
// import 'package:workout_tracking_app/providers/category_provider.dart';
// import 'package:workout_tracking_app/providers/payment_method_provider.dart';
// import 'package:workout_tracking_app/screens/streams.dart';
// import 'package:workout_tracking_app/screens/categories.dart';
// import 'package:workout_tracking_app/widgets/insights.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Weights> w = [];
  final _dataService = DataService();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _loadItems();
    });
  }

  Future<void> _loadItems() async {
    final cardio = ref.read(cardioProvider);

    if (cardio.isEmpty) {
      Map<String, List<dynamic>> allData = await _dataService.loadAll();
      List<Cardio> _cardio = allData["cardio"] as List<Cardio>;
      List<Weights> _weights = allData["weights"] as List<Weights>;
      List<Lifts> _lifts = allData["lifts"] as List<Lifts>;

      w = _weights;

      ref.read(cardioProvider.notifier).setData(_cardio);
      ref.read(weightsProvider.notifier).setData(_weights);
      ref.read(liftsProvider.notifier).setData(_lifts);
    }
  }
  
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // void _goInsights() async {
  //   final updatedPayment = await Navigator.of(context).push<Payment>(
  //     MaterialPageRoute(
  //       builder: (ctx) => Insights(),
  //     )
  //   );

  //   if (updatedPayment == null) {
  //     return; 
  //   }
  // }

  @override 
  Widget build(BuildContext context) {
    Widget? activePage;

    switch(_selectedPageIndex) {
      case 0: {
        activePage = const CardioScreen();
        //activePage = const Text("I AM FIRST PAGE");
      }
      break;
      case 1: {
        activePage = WeightsScreen(data: w);
      }
      break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking App"),
        // leading: IconButton(
        //   icon: const Icon(Icons.add),
        //   onPressed: activeAddFunction,
        // ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         curve: Curves.fastOutSlowIn,
      //         child: Text(
      //           'Drawer Header',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       const ListTile(
      //         leading: Icon(Icons.attach_money),
      //         title: Text('Goals')
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.insights),
      //         title: const Text('Insights'),
      //         onTap: _goInsights,
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.logout),
      //         title: const Text('Logout'),
      //         onTap: _authService.logOut,
      //       ),
      //     ],
      //   ),
      // ),

      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: "Cardio"),
          BottomNavigationBarItem(icon: Icon(Icons.castle), label: "Weights"),
          // BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: "Income"),
          // BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Accounts")          
        ],
      ),
    );
  }
}