class UsersController < Clearance::UsersController

   def index
      @users = User.search(params[:term])
      respond_to do |format|
         format.js {}
      end
   end

   def new
      # u = User.new
      # u.avatar = params[:file] # Assign a file like this, or

      # like this
      # File.open('somewhere') do |f|
      #    u.avatar = f
      # end

      # u.save!
      # u.avatar.url # => '/url/to/file.png'
      # u.avatar.current_path # => 'path/to/file.png'
      # u.avatar_identifier # => 'file.png'
   end

   private

   def user_from_params
      email = user_params.delete(:email)
      password = user_params.delete(:password)
      username = user_params.delete(:username)
      # avatar = user_params.delete(:avatar)
      # avatar_cache = user_params.delete(:avatar_cache)
      # remove_avatar = user_params.delete(:remove_avatar)
      # native_language = user_params.delete(:native_language)
      # term = user_params.delete(:term)

      Clearance.configuration.user_model.new(user_params).tap do |user|
         user.email = email
         user.password = password
         user.username = username
         # user.avatar = avatar
         # user.avatar_cache = avatar_cache
         # user.remove_avatar = remove_avatar
         # user.native_language = native_language
         # user.term = term
      end
   end

end
