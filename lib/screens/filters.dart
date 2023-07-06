import 'package:flutter/material.dart';
import 'package:meals/widgets/filter.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenfreefilterset = false;
  var _lactosefreefilterset = false;
  var _vegetarianfilterset = false;
  var _veganfilterset = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FilterSwitchTile(
            checkstatus: _glutenfreefilterset,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free Meals',
          ),
          FilterSwitchTile(
            checkstatus: _lactosefreefilterset,
            title: 'Lactose-free',
            subtitle: 'Only include Lactose-free Meals',
          ),
          FilterSwitchTile(
            checkstatus: _vegetarianfilterset,
            title: 'Vegetarian',
            subtitle: 'Only include Vegetarian Meals',
          ),
          FilterSwitchTile(
            checkstatus: _veganfilterset,
            title: 'Vegan',
            subtitle: 'Only include Vegan Meals',
          ),
        ],
      ),
    );
  }
}
