
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/search_model/cubit/cubit.dart';
import '../../models/search_model/cubit/states.dart';
import '../../shared/components/components.dart';


class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);

        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      label: "Search",
                      prefix: Icons.search,
                      onSubmit: (String? text) {
                        SearchCubit.get(context).search(text!);
                      }),
                  if (state is SearchLoadingState)...[
                    SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(),
                  ]
                  ,
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics() ,
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).searchModel!.data!.data![index],context,isOldPrice: false),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
