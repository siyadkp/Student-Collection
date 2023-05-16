import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:students/profile_page/information.dart';

import '../bloc/home_bloc_bloc.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    super.key,
    required this.homeBlocBloc,
    required this.successState,
  });

  final HomeBlocBloc homeBlocBloc;
  final HomeSuccess successState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Text('HOME'),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
              onPressed: () {
                homeBlocBloc.add(
                    EventNavigateIntoSearch(students: successState.students));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      final values = successState.students[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            File(values.photo),
                          ),
                        ),
                        title: Text(
                          values.name,
                        ),
                        subtitle: Text(values.domain),
                        trailing: IconButton(
                            onPressed: () {
                              homeBlocBloc.add(EventDeleteStudent(
                                  id: successState.students[index].id!));
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Information(values: values)));
                        },
                      );
                    },
                    itemCount: successState.students.length)),
            Align(
              alignment: Alignment.bottomRight,
              child: AvatarGlow(
                endRadius: 60,
                glowColor: Colors.blue,
                child: FloatingActionButton(
                  backgroundColor: Colors.blue[200],
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                  onPressed: () {
                    homeBlocBloc.add(EventNavigateIntoAddPage());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
