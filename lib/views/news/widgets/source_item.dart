import 'package:flutter/material.dart';
import 'package:news_c10_str/models/source_reposne.dart';

class SourceItem extends StatelessWidget {
  final Sources source;
  final bool isSelected;

  const SourceItem({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.green),
          color: isSelected ? Colors.green : Colors.transparent),
      child: Text(
        source.name ?? "",
        style: TextStyle(color: isSelected ? Colors.white : Colors.green),
      ),
    );
  }
}
