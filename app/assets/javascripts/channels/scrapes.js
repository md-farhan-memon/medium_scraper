// App.scrapes = App.cable.subscriptions.create('ScrapesChannel', {  
//   received: function(data) {
//     return $('#blog').append(this.renderSnippet(data));
//   },
//   renderSnippet: function(data) {
//     return "<p> <b>" + data.blog + ": </b>" + data.blog + "</p>";
//   }
// });