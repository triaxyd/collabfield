class Group::ConversationsController < ApplicationController
  def index
    @conversations = current_user.group_conversations
  end

  def new
    @users = User.where.not(id: current_user.id)
    @conversation = Group::Conversation.new
  end
  def create
    Rails.logger.debug "PARAMS: #{params.inspect}"
    @conversation = create_group_conversation
    if @conversation
      redirect_to group_conversation_path(@conversation)
    else
      flash[:alert] = "Failed to create group conversation"
      redirect_to new_group_conversation_path
    end
  end
  def show
    @conversation = Group::Conversation.find(params[:id])
    @messages = @conversation.messages
    @message = Group::Message.new
  end
  private

  def add_to_conversations
    session[:group_conversations] ||= []
    session[:group_conversations] << @conversation.id
  end

  def already_added?
    session[:group_conversations].include?(@conversation.id)
  end

  def create_group_conversation
    Group::NewConversationService.new({
                                        creator_id: params[:creator_id],
                                        user_ids: params[:group_conversation][:user_ids]
                                      }).call
  end
end
