$(function() {

  //
  // Handle Medium-like header images.
  //
  var imageData = $('.header-image').data();
  if (imageData) {
    var imageUrl = imageData.headerImageUrl;
    var height = imageData.headerImageHeight;
    $('.header-image-bg').css('background-image', 'url(' + imageUrl + ')')
    $('.header-image-bg').css('color', 'white');
    $('.header-image-bg').css('height', height + 'px');
    $('.header-image-bg').css('padding', '10px');
    $('.header-image-bg').css('padding-top', (height - 150) + 'px');

    $('.post-header').addClass('post-header-with-image');
    $('.post-header-content').addClass('post-header-with-image-content');
  }

  //
  // Remove the trailing "index.html" from generated relative urls.
  // XXX: This is a hack.
  //
  $('a').each(function () {
    var e = $(this);
    url = e.attr('href');
    if (url) {
      var re = /^(\..*\/(posts|tags)\/.*\/)index\.html$/;
      var newUrl = url.replace(re, "$1");
      if (url != newUrl) {
        e.attr('href', newUrl);
      }
    }
  });
});
