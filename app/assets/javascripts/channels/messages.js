App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    $("#message").show()
    return $('#message').text(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return  data.message;
  }
});
