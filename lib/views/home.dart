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
                  title: const Text(""),
                  items: _controller.itemss,
                  onConfirm: (values) => _controller.onSelectItem(values),
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) {
                      // setState(() {
                      //   _selectedAnimals2.remove(value);
                      // });
                    },
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _controller.results.isEmpty
                      ? const Text('Select and submit, before display result')
                      : ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                image: DecorationImage(image: NetworkImage(_controller.results[index]["coco_url"]), fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          },
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
