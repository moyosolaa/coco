import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends StatelessWidget {
  const ExplorerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coco Explorer'),
      ),
      body: GetBuilder<ExplorerController>(
        builder: (_controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                MultiSelectBottomSheetField(
                  initialChildSize: 0.4,
                  listType: MultiSelectListType.LIST,
                  buttonIcon: const Icon(Icons.arrow_drop_down),
                  searchable: true,
                  buttonText: const Text("Select Items"),
                  title: const Text("Select Items"),
                  items: _controller.itemss,
                  onConfirm: (values) => _controller.onSelectItem(values),
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) => _controller.removeItem(value),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    onPressed: () => _controller.searchResult(),
                    style: OutlinedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _controller.results.isEmpty
                        ? const Text('No Items Found!!!!')
                        : ListView.builder(
                            itemCount: _controller.results.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                height: 300,
                                // width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  image: DecorationImage(image: NetworkImage(_controller.results[index]), fit: BoxFit.contain),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
