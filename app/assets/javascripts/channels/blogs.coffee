App.blog = App.cable.subscriptions.create "BlogsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#new_blog").append(data)
