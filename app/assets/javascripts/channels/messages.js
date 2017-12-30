var $messages, $new_message_attachment, $new_message_body, $new_message_form;
$messages = $('#messages');
$new_message_form = $('#new-message');
$new_message_body = $new_message_form.find('#message-body');
$new_message_attachment = $new_message_form.find('#message-attachment');
if ($messages.length > 0) {
 App.chat = App.cable.subscriptions.create({
   channel: "ChatChannel",
   chat_id: document.querySelector("#chat_id").value
 }, {
   connected: function() {},
   disconnected: function() {},
   received: function(data) {
     if (data['message']) {
       $new_message_body.val('');
       // make a jax call to the BE
       // send the message from data[""message]
       // YOU NEED TO SEND THE target: $("#target").val()
       $.ajax({
           url: $("#chat_message_url").val(),
           type: 'GET',
           contentType: 'application/html',
           data: { target: $("#message_target_to_msg").val() },
           success: function(result) {
              $(".messages:visible > ul").html(result);
              var $t = $('.messages');
              $t.animate({"scrollTop": $('.messages')[0].scrollHeight}, "slow");
              $("#message_content").val(null)
              $("#message_content").focus()
           }
       });
     }
   },
   send_message: function(message, file_uri, original_name) {
     return this.perform('send_message', {
       message: message,
       file_uri: file_uri,
       original_name: original_name
     });
   }
 });
 $new_message_form.submit(function(e) {
   var $this, file_name, message_body, reader;
   $this = $(this);
   message_body = $new_message_body.val();
   if ($.trim(message_body).length > 0 || $new_message_attachment.get(0).files.length > 0) {
     if ($new_message_attachment.get(0).files.length > 0) {
       reader = new FileReader();
       file_name = $new_message_attachment.get(0).files[0].name;
       reader.addEventListener("loadend", function() {
         return App.chat.send_message(message_body, reader.result, file_name);
       });
       reader.readAsDataURL($new_message_attachment.get(0).files[0]);
     } else {
       App.chat.send_message(message_body);
     }
   }
   e.preventDefault();
   return false;
 });
}


$("#target").change(function(){
   var self = $(this)
   $("#message_target_to_msg").val(self.val())
   $.ajax({
      url: $("#chat_message_url").val(),
      type: 'GET',
      contentType: 'application/html',
      data: { target: self.val() },
      success: function(result) {
         $(".messages:visible > ul").html(result);
         var $t = $('.messages');
         $t.animate({"scrollTop": $('.messages')[0].scrollHeight}, "slow");
         $("#message_content").val(null)
         $("#message_content").focus()
      }
   });
})

if ($(".list-item").length > 0) {
   $(".list-unstyled a:first").trigger('click');
}
