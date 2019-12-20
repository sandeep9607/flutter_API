class APIs {
  // static const String baseUrl = 'http://reduxblog.herokuapp.com/api/posts';

  static const String get_posts =
      'http://reduxblog.herokuapp.com/api/posts?key=102';

  static const String save_post =
      'http://reduxblog.herokuapp.com/api/posts?key=102';

  static const String delete_post = 'http://reduxblog.herokuapp.com/api/posts/';
}

class MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";
  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";
}
