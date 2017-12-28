class UsersController < Clearance::UsersController

   def index
      @users = User.search(params[:term])
      respond_to do |format|
         format.js {} 
      end
   end
  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    username = user_params.delete(:username)
    term = user_params.delete(:term)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.username = username
      user.term = term
    end
  end

end
