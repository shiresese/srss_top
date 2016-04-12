$(document).ready () ->
  $("#cover").fadeOut(500)
  openLink = (link) ->
    (e) ->
      if e.metaKey
        window.open(link)
      else
        $("#cover").fadeIn 500, ()->
          window.location.href = link
  openLinkNewTab = (link) ->
    () ->
      window.open(link)

  getTumblrPosts = (tag, callback) ->
    # return # debug
    domain = "side-se.tumblr.com"
    api_key = "1FLh5aV3GU5wC1ofWdUqxhcX5XkNDLjLh66XypGvSvkErzCwhH"
    option = []
    option.push("tag=" + tag)
    option.push("limit=3")
    option = "&" + option.join "&"
    $.ajax(
      url: "http://api.tumblr.com/v2/blog/"+domain+"/posts?api_key="+api_key + option
      dataType: "jsonp"
    ).done (e, e2) ->
      callback e.response.posts
  getTumblrPosts "info", (posts) =>
    post = posts[0]
    $(".sese-latest-info-title").text(post.title)
    $(".sese-latest-info-body").html(post.body)
    console.log posts
  $(".shire-name").click openLink("./shire")
  $(".shire-latest-info").click openLink("./shire#news")
  $(".sese-name").click openLink("./sese")
  $(".sese-latest-info").click openLink("./sese#info")

window.onpageshow = (event) ->
  if (event.persisted)
    $("#cover").fadeOut(500)
