$(function() {
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

    var mediumUrl = $('.medium-url').data().mediumUrl;
    if (mediumUrl) {
      var e = $('.cross-posted-to-medium');
      e.find('a').attr('href', mediumUrl);
      e.show();
    }
  }
});
