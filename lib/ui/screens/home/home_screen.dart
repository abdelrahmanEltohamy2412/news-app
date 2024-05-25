import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:newsapp/ui/screens/home/tabs/news/news_tab.dart';


import '../../../data/model/category_dm.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentTab;

  @override
  void initState() {
    super.initState();
    currentTab = CategoriesTab(onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentTab is! CategoriesTab) {
          currentTab = CategoriesTab(onCategoryClick);
          setState(() {});
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.green,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight:  Radius.circular(30),
                  )
              ),
            title: const Text("News app!"),

          ),
          body: currentTab,
          drawer: buildDrawer(),
        ),
      ),
    );
  }

  Drawer buildDrawer() => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                    child: Text(
                  "News App!",
                  style: TextStyle(color: Colors.white),
                ))),
            buildDrawerRow(Icons.list, "Categories", () {
              currentTab = CategoriesTab(onCategoryClick);
              Navigator.pop(context);
              setState(() {});
            }),

          ],
        ),
      );

  void onCategoryClick(CategoryDM categoryDM) {
    currentTab = NewsTab(categoryDM.id);
    setState(() {});
  }

  buildDrawerRow(IconData iconData, String title, Function onClick) => InkWell(
        onTap: () {
          onClick();
        },
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Icon(
              iconData,
              color: Colors.black,
              size: 35,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(title)
          ],
        ),
      );
}
