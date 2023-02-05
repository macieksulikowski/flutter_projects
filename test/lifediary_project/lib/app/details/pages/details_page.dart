import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/add_page/add_page.dart';
import 'package:lifediary_project/app/details/cubit/details_cubit.dart';

import 'package:lifediary_project/app/models/item_model.dart';
import 'package:lifediary_project/app/repositories/items_repository.dart';

int maxDiaryCount = 3;
int currentDiaryCounter = 0;

class DetailsPageContent extends StatefulWidget {
  const DetailsPageContent({
    required this.itemModel,
    required this.id,
    // required this.itemModelText
    Key? key,
  }) : super(key: key);

// final ItemModelText itemModelText;
  final ItemModel itemModel;
  final String id;

  @override
  State<DetailsPageContent> createState() => _DetailsPageContentState();
}

class _DetailsPageContentState extends State<DetailsPageContent> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.itemModel.text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsCubit(ItemsRepository())..getItemWithID(widget.id),
      child: BlocListener<DetailsCubit, DetailsState>(
        listener: (context, state) {},
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final itemModel = state.itemModel;
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator());
            }

            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'LIFEDIARY',
                    style: GoogleFonts.lato(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.blue,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Wprowadź jakieś zadanie!"),
                        ),
                      );
                      return;
                    } else {
                      context
                          .read<DetailsCubit>()
                          .addtext(widget.id, controller.text);
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                body: ListView(
                  children: [
                    if (itemModel != null) ...[
                      _ListViewItem(
                        itemModel: itemModel,
                      ),
                      _DiaryPage(itemModel: itemModel, controller: controller),
                    ]
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: NetworkImage(
                    itemModel.imageURL,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(itemModel.title),
                    Icon(Icons.book, color: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiaryPage extends StatefulWidget {
  const _DiaryPage(
      {Key? key, required this.itemModel, required this.controller})
      : super(key: key);

  final ItemModel itemModel;
  final TextEditingController controller;

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<_DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.controller,
                maxLines: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write something here...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
