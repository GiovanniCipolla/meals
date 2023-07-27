import 'package:flutter_riverpod/flutter_riverpod.dart';


enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier():super({
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegan:false,
    Filter.vegetarian:false,
  });

  void setFilters(Map<Filter, bool> choosenFilters){
    state = choosenFilters;
  }


  void setFilter (Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,  //sovrasscrive la vecchia medesima chiave valore
    };
  }

}

final filtersProvider = StateNotifierProvider<FiltersNotifier,Map<Filter, bool>>((ref) => FiltersNotifier());