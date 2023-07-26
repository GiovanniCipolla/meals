import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'filters.dart';
import 'meals.dart';

const kInitianlFilter = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favouritesMeal = [];
  Map<Filter, bool> _selectedFilters = kInitianlFilter;

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      // il metodo push ritorna un valore future , che gli verrà restituito con il pop.
      // visto che abbiamo sviluppato noi sappiamo che tipo ci ritorna, e lo mettiamo nei generics del push
      // ovviamente dobbiamo configurare anche il pop nella pagina dove si va e
      // deve essere tutto asyncrono
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitianlFilter;  // ?? controlla il futuro valore , e se è nullo utilizza quello dopo il ? cioè il valore che metto
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   final availableMeals = dummyMeals.where((meal) {
    if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
   }).toList();

    
    void toggleMealFavouriteStatus(Meal meal) {
      final isExisting = favouritesMeal.contains(meal);
      if (isExisting) {
        setState(() {
          favouritesMeal.remove(meal);
          showInfoMessage('Removed from favourites');
        });
      } else {
        setState(
          () {
            favouritesMeal.add(meal);
            showInfoMessage('Added to favourites');
          },
        );
      }
    }

    Widget activePage = CategoriesScreen(
      onToggleFavourite: toggleMealFavouriteStatus, avaibleMeals: availableMeals,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favouritesMeal,
        onToggleFavourite: toggleMealFavouriteStatus,
      );
      activePageTitle = ' Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
