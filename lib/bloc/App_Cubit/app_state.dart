part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class ChangeCurrentIndexScreen extends AppState {}
class ChangeCurrentIndexSlider extends AppState {}


class GetHomeLoading extends AppState {}
class GetHomeSuccess extends AppState {}
class GetHomeError extends AppState {}


class GetCategoryLoading extends AppState {}
class GetCategorySuccess extends AppState {}
class GetCategoryError extends AppState {}


class GetCategoryProductsLoading extends AppState {}
class GetCategoryProductsSuccess extends AppState {}
class GetCategoryProductsError extends AppState {}


class ChangeFavouriteLoading extends AppState {}
class ChangeFavouriteSuccess extends AppState {}
class ChangeFavouriteError extends AppState {}


class ChangeFavourite extends AppState {}


class GetFavouritesLoading extends AppState {}
class GetFavouritesSuccess extends AppState {}
class GetFavouritesError extends AppState {}


class ChangeCartLoading extends AppState {}
class ChangeCartSuccess extends AppState {}
class ChangeCartError extends AppState {}


class GetCartLoading extends AppState {}
class GetCartSuccess extends AppState {}
class GetCartError extends AppState {}


class SearchLoading extends AppState {}
class SearchSuccess extends AppState {}
class SearchError extends AppState {}