import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_3a/data/repository/gift_repo.dart';
import 'package:prueba_3a/eat_view.dart';
import 'package:prueba_3a/matrix_view.dart';
import 'package:prueba_3a/ui/gift_bloc/gift_bloc.dart';

class MultiRepoProvider extends StatefulWidget {
  MultiRepoProvider({Key? key}) : super(key: key);

  @override
  State<MultiRepoProvider> createState() => _MultiRepoProviderState();
}

class _MultiRepoProviderState extends State<MultiRepoProvider> {
  @override
  Widget build(BuildContext context) {
    return  MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => GithyRepo(),
            ),
          ],
          child: BlocProvider(
            create: (context) => GiftBloc(
              RepositoryProvider.of<GithyRepo>(context),
            )..add(LoadGiftEvent()),
            child: EatView(),
          ),
        );
  }
}