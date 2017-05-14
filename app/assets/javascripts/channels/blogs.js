//= require cable
//= require_self
//= require_tree .

App.blogs = App.cable.subscriptions.create('BlogsChannel', {  
  received: function(data) {
    return $('#blog').append(this.renderSnippet(data));
  },
  renderSnippet: function(data) {
    return "<p> <b>" + data.blog + ": </b>" + data.blog + "</p>";
  }
});

this.App = {};

App.cable = ActionCable.createConsumer('ws://127.0.0.1:28080');