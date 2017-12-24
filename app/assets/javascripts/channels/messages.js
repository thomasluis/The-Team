// function createMessageChannel() {
//   App.messages = App.cable.subscriptions.create({
//         channel: 'MessagesChannel', chat_id: parseInt($("#message_chat_id").val())
//         },
//         {
//         received: function(data) {
//           $("#messages").removeClass('hidden')
//           return $('#messages').append(this.renderMessage(data));
//         },
//         renderMessage: function(data) {
//     return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
//   },
//       });
// return App.messages;
// }

jQuery(document).on('turbolinks:load', function() {
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
          return $messages.append(data['message']);
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
    return $new_message_form.submit(function(e) {
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
});

// gcloud projects add-iam-policy-binding central-diagram-189014 \
//   --member "serviceAccount:transltr@central-diagram-189014.iam.gserviceaccount.com" \
//   --role "roles/owner"
//
//   gcloud iam service-accounts keys create service-account.json \
//   --iam-account transltr@central-diagram-189014.iam.gserviceaccount.com
