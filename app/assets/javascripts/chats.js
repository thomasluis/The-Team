$(function(){
   $("#target").change(function(){
      var self = $(this)
      $("#message_target_to_msg").val(self.val())
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
