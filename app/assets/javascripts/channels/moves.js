App.moves = App.cable.subscriptions.create('MovesChannel', {  
  received: function(data) {
    $("#moves").removeClass('hidden')
    $("#message").hide()
    return $('#moves').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return "<p> email:" + data.email + ": column:" + data.column + "</p>";
  }
});
