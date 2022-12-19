abstract class ShopAppStates {}

class InitialState extends ShopAppStates {}

class ShopBottomNavState extends ShopAppStates {}

class ShopHomeLoadingState extends ShopAppStates {}

class ShopHomeSuccessState extends ShopAppStates {}

class ShopHomeErrorState extends ShopAppStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopCategoriesLoadingState extends ShopAppStates {}

class ShopCategoriesSuccessState extends ShopAppStates {}

class ShopCategoriesErrorState extends ShopAppStates {
  final String error;

  ShopCategoriesErrorState(this.error);
}

class ShopFavouritesPostLoadingState extends ShopAppStates {}

class ShopFavouritesPostSuccessState extends ShopAppStates {}

class ShopFavouritesPostErrorState extends ShopAppStates {
  final String error;

  ShopFavouritesPostErrorState(this.error);
}

class ShopFavouritesGetLoadingState extends ShopAppStates {}

class ShopFavouritesGetSuccessState extends ShopAppStates {}

class ShopFavouritesGetErrorState extends ShopAppStates {
  final String error;

  ShopFavouritesGetErrorState(this.error);
}

class ShopUserProfileLoadingState extends ShopAppStates {}

class ShopUserProfileSuccessState extends ShopAppStates {}

class ShopUserProfileErrorState extends ShopAppStates {
  final String error;

  ShopUserProfileErrorState(this.error);
}

class ShopUserUpdateProfileLoadingState extends ShopAppStates {}

class ShopUserUpdateProfileSuccessState extends ShopAppStates {}

class ShopUserUpdateProfileErrorState extends ShopAppStates {
  final String error;

  ShopUserUpdateProfileErrorState(this.error);
}

class ShopSearchLoadingState extends ShopAppStates {}

class ShopSearchSuccessState extends ShopAppStates {}

class ShopSearchErrorState extends ShopAppStates {
  final String error;

  ShopSearchErrorState(this.error);
}
