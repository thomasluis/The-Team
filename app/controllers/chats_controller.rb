require 'securerandom'
class ChatsController < ApplicationController
  before_action :require_login

  def logged_in?
     current_user != nil
  end

  def index
    chats = current_user.chats
    @existing_chats_users = current_user.existing_chats_users
    @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => 15)#.order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:term])
  end

  def create
    @other_user = User.find(params[:other_user])
    @chat = find_chat(@other_user) || Chat.new(identifier: SecureRandom.hex)
    if !@chat.persisted?
      @chat.save
      @chat.subscriptions.create(user_id: current_user.id)
      @chat.subscriptions.create(user_id: @other_user.id)
    end
    @message = Message.new
    @all_languagues =   [  { name: "English", abrv: "en"}, { name: "Spanish", abrv: "es" },
                           { name: "Portuguese", abrv: 'pt' }, { name: "German", abrv: "de"},
                           { name: "Greek", abrv: "el" }, { name: "Haitian Creole", abrv: "ht"},
                           { name: "Hindi", abrv: "hi"}, { name: "Hungarian", abrv: "hu"},
                           { name: "Indonesian", abrv: "id"}, { name: "Irish", abrv: "ga"},
                           { name: "Italian", abrv: "it"}, { name: "Japanese", abrv: "ja"},
                           { name: "Javanese", abrv: "jw"}, { name: "Kannada", abrv: "kn"},
                           { name: "Korean", abrv: "ko"}, { name: "Kurdish", abrv: "ku"},
                           { name: "Latin", abrv: "la"}, { name: "Lithuanian", abrv: "lt" },
                           { name: "French", abrv: "fr" }, { name: "Turkish", abrv: "tr" },
                           { name: "Bengali", abrv: "bn" }, { name: "Swedish", abrv: "sv" },
                           { name: "Chinese", abrv: "zh-CN" }, { name: "French", abrv: "fr" },
                           { name: "Russian", abrv: "ru" }, { name: "Norwegian", abrv: "no" }
                        ]

    respond_to do |format|
       format.js {}
    end
    # redirect_to user_chat_path(current_user, @chat,  :other_user => @other_user.id)
  end
  def show
    @other_user = User.find(params[:other_user])
    @chat = Chat.find_by(id: params[:id])
    @message = Message.new
  end
private
  def find_chat(second_user)
    chats = current_user.chats
    chats.each do |chat|
      chat.subscriptions.each do |s|
        if s.user_id == second_user.id
          return chat
        end
      end
    end
    nil
  end
  def require_login
    redirect_to sign_in_path unless logged_in?
  end
end
