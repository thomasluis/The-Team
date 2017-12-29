class UsersController < Clearance::UsersController

   def index
      @users = User.search(params[:term])
      respond_to do |format|
         format.js {}
      end
   end

   def new
      
      @all_languagues = [ { name: "English", abrv: "en"}, { name: "Spanish", abrv: "es" }, { name: "Portuguese", abrv: 'pt' }, {name: "German", abrv: "de"}, { name: "Greek", abrv: "el"}, { name: "Haitian Creole", abrv: "ht"}, {name: "Hindi", abrv: "hi"}, {name: "Hungarian", abrv: "hu"}, {name: "Indonesian", abrv: "id"}, {name: "Irish", abrv: "ga"}, {name: "Italian", abrv: "it"}, {name: "Japanese", abrv: "ja"}, {name: "Javanese", abrv: "jw"}, {name: "Kannada", abrv: "kn"}, {name: "Korean", abrv: "ko"}, {name: "Kurdish", abrv: "ku"}, {name: "Latin", abrv: "la"}, {name: "Lithuanian", abrv: "lt" }, {name: "French", abrv: "fr" }, {name: "Turkish", abrv: "tr" }, {name: "Bengali", abrv: "bn" }, {name: "Swedish", abrv: "sv" }, {name: "Chinese", abrv: "zh-CN" }, {name: "French", abrv: "fr" } ]
   end

   private

   def user_from_params
      email = user_params.delete(:email)
      password = user_params.delete(:password)
      username = user_params.delete(:username)
      native_language = user_params.delete(:native_language)
      # term = user_params.delete(:term)

      Clearance.configuration.user_model.new(user_params).tap do |user|
         user.email = email
         user.password = password
         user.username = username
         user.native_language = native_language
         # user.term = term
      end
   end

end
