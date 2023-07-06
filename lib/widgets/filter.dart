import 'package:flutter/material.dart';

class FilterSwitchTile extends StatefulWidget {
  FilterSwitchTile(
      {super.key,
      required this.checkstatus,
      required this.title,
      required this.subtitle});
  var checkstatus = false;
  final String title;
  final String subtitle;
  @override
  State<FilterSwitchTile> createState() => _FilterSwitchTileState();
}

class _FilterSwitchTileState extends State<FilterSwitchTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.checkstatus,
      onChanged: (ischecked) {
        setState(() {
          widget.checkstatus = ischecked;
        });
      },
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 15,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
