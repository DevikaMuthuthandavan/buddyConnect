$(document).ready(function() {
    console.log("Hello");
    var isLoading = false;
    if ($('.infinite-scroll', this).length > 0) {
        $(parent.window.document).scroll(function() {
            var more_posts_url = $('.pagination a.next_page').attr('href');
            var threshold_passed = $(window).scrollTop() > $(document).height() - $(window).height() - 60;
            console.log(more_posts_url+" "+threshold_passed);
            if (!isLoading && more_posts_url && threshold_passed) {
                isLoading = true;
                $.getScript(more_posts_url).done(function (data,textStatus,jqxhr) {
                    isLoading = false;
                }).fail(function() {
                    isLoading = false;
                });
            }
      });
    }
  });