$(function(){
   $("#target").change(function(){
      var self = $(this)
      $.ajax({
          url: $("#chat_message_url").val(),
          type: 'GET',
          contentType: 'application/html',
          data: { target: self.val() },
          success: function(result) {
             $(".message_wrapper").html(result);
          }
      });
   })
})
