// import 'package:flutter/material.dart';

// class CustomWidget extends StatefulWidget {
//   const CustomWidget({final Key key, this.menuScreenContext})
//       : super(key: key);
//   final BuildContext menuScreenContext;

//   @override
//   _CustomWidgetState createState() => _CustomWidgetState();
// }

// class _CustomWidgetState extends State<CustomWidget> {
//   PersistentTabController _controller;
//   bool _hideNavBar;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController();
//     _hideNavBar = false;
//   }

//   List<Widget> _buildScreens() => [
//         MainScreen(
//           menuScreenContext: widget.menuScreenContext,
//           hideStatus: _hideNavBar,
//           onScreenHideButtonPressed: () {
//             setState(() {
//               _hideNavBar = !_hideNavBar;
//             });
//           },
//         ),
//         MainScreen(
//           menuScreenContext: widget.menuScreenContext,
//           hideStatus: _hideNavBar,
//           onScreenHideButtonPressed: () {
//             setState(() {
//               _hideNavBar = !_hideNavBar;
//             });
//           },
//         ),
//         MainScreen(
//           menuScreenContext: widget.menuScreenContext,
//           hideStatus: _hideNavBar,
//           onScreenHideButtonPressed: () {
//             setState(() {
//               _hideNavBar = !_hideNavBar;
//             });
//           },
//         ),
//         MainScreen(
//           menuScreenContext: widget.menuScreenContext,
//           hideStatus: _hideNavBar,
//           onScreenHideButtonPressed: () {
//             setState(() {
//               _hideNavBar = !_hideNavBar;
//             });
//           },
//         ),
//         MainScreen(
//           menuScreenContext: widget.menuScreenContext,
//           hideStatus: _hideNavBar,
//           onScreenHideButtonPressed: () {
//             setState(() {
//               _hideNavBar = !_hideNavBar;
//             });
//           },
//         ),
//       ];

//   List<PersistentBottomNavBarItem> _navBarsItems() => [
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.home),
//           title: "Home",
//           activeColorPrimary: Colors.blue,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.search),
//           title: "Search",
//           activeColorPrimary: Colors.teal,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.add),
//           title: "Add",
//           activeColorPrimary: Colors.deepOrange,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.settings),
//           title: "Settings",
//           activeColorPrimary: Colors.indigo,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.settings),
//           title: "Settings",
//           activeColorPrimary: Colors.indigo,
//           inactiveColorPrimary: Colors.grey,
//         ),
//       ];

//   @override
//   Widget build(final BuildContext context) => Scaffold(
//         appBar: AppBar(title: const Text("Navigation Bar Demo")),
//         drawer: Drawer(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const <Widget>[
//                 Text("This is the Drawer"),
//               ],
//             ),
//           ),
//         ),
//         body: PersistentTabView.custom(
//           context,
//           controller: _controller,
//           screens: _buildScreens(),
//           itemCount: 5,
//           hideNavigationBar: _hideNavBar,
//           screenTransitionAnimation: const ScreenTransitionAnimation(
//             animateTabTransition: true,
//           ),
//           customWidget: CustomNavBarWidget(
//             _navBarsItems(),
//             onItemSelected: (final index) {
//               setState(() {
//                 _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
//               });
//             },
//             selectedIndex: _controller.index,
//           ),
//         ),
//       );
// }
