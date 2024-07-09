import 'package:flutter/material.dart';
import 'package:news_c10_str/models/category_model.dart';
import 'package:news_c10_str/views/news/news_view.dart';
import 'package:news_c10_str/views/home/widgets/category_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<CategoryModel> allCategories = CategoryModel.getCategories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pick your category of interest",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GridView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onCategoryClicked(allCategories[index]);
                  },
                  child: CategoryItem(
                    model: allCategories[index],
                    index: index,
                  ),
                );
              },
              itemCount: allCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  CategoryModel? selectedCategory;

  onCategoryClicked(category) {
    selectedCategory = category;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return NewsView(categoryId: selectedCategory!.id);
      },
    ));
    setState(() {});
  }
}
