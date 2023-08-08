import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../model/article.dart';
import '../model/article_category.dart';
import '../services/search.dart';
import '../services/section.dart';


final ChangeNotifierProvider<NewsController> newsProvider =
ChangeNotifierProvider<NewsController>((ref) => NewsController());

class NewsController extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  final SectionsService _sectionsEndPointService = SectionsService();
  int _page = 1;
  int _pageSize = 5;
  String _category = "home";
  String _fromDate = DateTime.now().toString();
  String _toDate = DateTime.now().toString();
  String _orderBy = "newest";
  bool _isCategoriesLoading = true;
  List<NewsArticle> _newsList = [];
  List<ArticleCategory> _categoriesList = [];
  PagingController<int, NewsArticle> _pagingController =
  PagingController(firstPageKey: 1);

  void getCategories(Function() onComplete) async {
    List<dynamic> results = await _sectionsEndPointService.getCategories(
            (status) => null, (e) => null);
    List<ArticleCategory> categories = [
      ArticleCategory(id: "home", webTitle: "home")
    ];

    for (var e in results) {
      categories.add(ArticleCategory.fromJson(e));
    }

    _categoriesList.addAll(categories);
    notifyListeners();

    onComplete();
  }

  void getNewsByCategoryPaginated(
      Function(int status) onStatusCodeError,
      Function(Exception e) onException,
      Function(PagingController<int, NewsArticle> pc) onComplete) async {
    _page = 1;

    PagingController<int, NewsArticle> pagingController =
    PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) async {
      List<dynamic> results = await _searchService.getNewsByCategory(
          _page,
          _pageSize,
          _category,
          _fromDate,
          _toDate,
          _orderBy,
              (status) => onStatusCodeError(status),
              (e) => onException(e));

      List<NewsArticle> newsList = [];

      for (var e in results) {
        newsList.add(NewsArticle.fromJson(e));
      }
      _newsList = newsList;
      notifyListeners();
      if (newsList.length < _pageSize) {
        pagingController.appendLastPage(newsList);
      } else {
        _page++;
        pagingController.appendPage(newsList, _page);
      }
    });

    onComplete(pagingController);
  }


  setPage(int page ) {
    _page = page ;
    notifyListeners();
  }
  int get getPage => _page;
  /////////////////
  setPageSize(int pageSize) {
    _pageSize = pageSize;
    notifyListeners();
  }
  int get getPageSize => _pageSize;
  ////////////////

  setCategory(String category) {
    _category = category;
  }
  String get GetCategory => _category;
  ///////////////////
  setFromDate(String fromDate) {
    _fromDate = fromDate;
    notifyListeners();
  }
  String get getFromDate => _fromDate;
  /////////////////////////

  setToDate(String toDate) {
    _toDate = toDate;
    notifyListeners();
  }
  String get getToDate => _toDate;
  ////////////////
  setOrderBy(String orderBy) {
    _orderBy = orderBy;
    notifyListeners();
  }
  String get getorderBy => _orderBy;
  ////////////////////////
  setIsCategoriesLoading(bool isCategoriesLoading) {
    _isCategoriesLoading = isCategoriesLoading;
    notifyListeners();
  }
  bool get getisCategoriesLoading => _isCategoriesLoading;
  //////////////////////////////////////
  setPaginController(PagingController<int, NewsArticle> pagingController) {
    _pagingController =pagingController;
  }
  PagingController<int, NewsArticle> get getPagingController => _pagingController;
  /////////////////////////////////////////////////////////////////////////////////////
  List<NewsArticle> get getNewsList => _newsList;
  List<ArticleCategory> get getCategoriesList => _categoriesList;
}