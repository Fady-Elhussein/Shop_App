import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/cubit/search_cubit/search_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
void search(String text){
  emit(SearchLoadingState());
  DioHelper.postData(
      url: sEARCH,
      token: token,
      data: {
    'text':text,
      }
  ).then((value){
    searchModel=SearchModel.fromJson(value?.data);
    emit(SearchSuccessState());
  }).catchError((onError){
    print(onError.toString());
    emit(SearchErrorState());
  });

}


}
