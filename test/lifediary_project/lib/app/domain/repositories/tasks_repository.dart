import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/data/remote_data_sources/tasks_remote_data_sources.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';

class TasksRepository {
  TasksRepository(this._tasksRemoteDataSource);

  final TasksRemoteDataSource _tasksRemoteDataSource;

  Stream<List<ItemModelToDoList>> getTasksStream() {
    return _tasksRemoteDataSource.getTasksData().map((dataList) {
      return dataList
          .map((data) => ItemModelToDoList(
                id: data['id'],
                title: data['title'],
                isChecked: data['isChecked'],
              ))
          .toList();
    });
  }

  Future<void> updateTask(
    ItemModelToDoList itemModel,
  ) async {
    return _tasksRemoteDataSource.updateTask(itemModel);
  }

  Future<void> deletetask({required String id}) {
    return _tasksRemoteDataSource.deletetask(id: id);
  }

  Future<ItemModelToDoList> gettasks(
      {required String id, required String title}) async {
    final data = await _tasksRemoteDataSource.gettasks(id: id, title: title);
    return ItemModelToDoList(
      id: data['id'],
      title: data['title'],
      isChecked: data['isChecked'],
    );
  }

  Future<void> addtask(
    String title,
    bool isChecked,
  ) async {
    return _tasksRemoteDataSource.addtask(title, isChecked);
  }
}
