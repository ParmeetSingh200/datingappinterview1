import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaydatingapp/user_inbox.dart';
import 'package:gaydatingapp/user_page.dart';
import 'package:gaydatingapp/user_profile.dart';

import 'favourites_page.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {

  int _selectedIndex = 0;
  int currentIndex=0;

  PageController _pageController=PageController(initialPage:0);

  String _appbarTitle = "Matchings";

  void _onItemTapped(int index) {
    setState(() {
      _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
      // _selectedIndex = index;
      // currentIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_selectedIndex == 0
      //       ? "Peoples"
      //       : _selectedIndex == 1
      //       ? "Inbox"
      //       : _selectedIndex == 2
      //       ? "Favourites"
      //       : "User",style:TextStyle(color: Colors.black)),
      //   actions: [
      //     Icon(
      //       Icons.search,
      //       color: Colors.black,
      //     ),
      //     SizedBox(
      //       width: 10,
      //     )
      //   ],
      //   backgroundColor: Colors.white,
      // ),
      body:
          PageView(
            controller:_pageController,
            onPageChanged: (index){
              setState(() {
                currentIndex=index;
              });
            }
            ,
            children: [
            UserPage(),
            FavouritesPage(),
            UserInbox(),
            UserProfile(),
          ],),
      // _selectedIndex==0 ?
      // UserPage()
      //     : _selectedIndex == 1 ? FavouritesPage()
      //     : _selectedIndex == 2 ? UserInbox()
      //     :UserProfile(),

      bottomNavigationBar:new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Color(0xffdd3953),
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.red,
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.yellow))),
      child:
      BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        // backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/people_select.png"),
            ),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/ic_fav.png"),
            ),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/message.png"),
            ),
            label: 'Inbox',
          ),

          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/pro_deselect.png"),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        // _selectedIndex,
        // selectedItemColor: Colors.pinkAccent,
        // unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,


      ),)
    );
  }
}
