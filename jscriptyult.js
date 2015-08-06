(function() {

  window.KnomeWidget = (function() {
    var _handleTimeOut, _insertExceptionImage, _insertLoadingImage, _loadImage, _loaded, _mergeOptions, _options, _requestContent, _requestStylesheet, _setTimeOut, _timeOut, _requestUrl, COMPACTED, EXPANDED;
    _options = {
      stylesheet: "http://localhost/knome/assets/widgets/portal.css",
      contentURL: "http://localhost/knome/widgets/portal.js",
      rootElementId: "knome_widget_container",
      timeOut: 10000,
      timeOutImage: "http://localhost/knome/assets/ultimatixwidgeterroricontimedout.png",
      timeOutAltText: "Timed Out",
      loadingImage: "http://localhost/knome/assets/ultimatixwidgeterroricontimedout.png",
      loadingImageText: "Loading ...",
      exceptionImage: "http://localhost/knome/assets/ultimatixwidgeterroricontimedout.png",
      exceptionImageAltText: "Error Occurred"
    };

    COMPACTED = "?type=compacted";
    EXPANDED = "?type=expanded";

    _requestUrl = null;
    _loaded = false;
    _timeOut = null;
    _requestStylesheet = function() {
      var stylesheet;
      stylesheet = document.createElement("link");
      stylesheet.rel = "stylesheet";
      stylesheet.type = "text/css";
      stylesheet.href = _options.stylesheet;
      stylesheet.media = "all";
      return document.lastChild.firstChild.appendChild(stylesheet);
    };
    _requestContent = function() {
      var script;
      script = document.createElement('script');
      script.src = _requestUrl;
      return document.getElementsByTagName('head')[0].appendChild(script);
    };
    _setTimeOut = function() {
      return _timeOut = top.setTimeout(_handleTimeOut, _options.timeOut);
    };
    _loadImage = function(img_src, altText) {
      var container, image;
      container = document.getElementById(_options.rootElementId);
      image = document.createElement("img");
      image.className = "knome-widget-placeholder-image";
      image.src = img_src;
      image.alt = altText;
      container.innerHTML = "";
      return container.appendChild(image);
    };
    _handleTimeOut = function() {
      if (!_loaded) {
        _loadImage(_options.timeOutImage);
      }
      return window.clearTimeout(_timeOut);
    };
    _insertLoadingImage = function() {
      return _loadImage(_options.loadingImage, _options.loadingImageText);
    };
    _insertExceptionImage = function() {
      return _loadImage(_options.exceptionImage, _options.exceptionImageAltText);
    };
    _mergeOptions = function(obj1, obj2) {
      var key, obj3, value;
      obj3 = {};
      for (key in obj1) {
        value = obj1[key];
        obj3[key] = value;
      }
      for (key in obj2) {
        value = obj2[key];
        obj3[key] = value;
      }
      return obj3;
    };
    return {
      loadContent: function(data) {
        var container;
        if (!data) {
          return;
        }
        _loaded = true;
        container = document.getElementById(_options.rootElementId);
        container.innerHTML = data;
        return container.style.display = 'block';
      },
      exceptionOccurred: function() {
        _loaded = true;
        return _insertExceptionImage();
      },
      loadExpandedView: function() {
        _loaded = false;
        _insertLoadingImage();
        _requestUrl = _options.contentURL + EXPANDED;
        _requestContent();
        return _setTimeOut();
      },
      loadCompactedView: function() {
        _loaded = false;
        _insertLoadingImage();
        _requestUrl = _options.contentURL + COMPACTED;
        _requestContent();
        return _setTimeOut();
      },
      init: function(options) {
        if (options == null) {
          options = {};
        }
        _options = _mergeOptions(_options, options);
        _requestStylesheet();
        KnomeWidget.loadExpandedView();
      }
    };
  })();

}).call(this);