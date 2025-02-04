class Private::MessagesController < ApplicationController
  before_action :set_conversation

  def index
    @conversation = Private::Conversation.find(params[:conversation_id])
    @messages = @conversation.messages.includes(:user)
  end


  def create
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append("messages", partial: "private/messages/message", locals: { message: @message }) }
        format.html { redirect_to private_messages_path(conversation_id: @conversation.id) }
      end
    else
      flash[:alert] = "Message could not be sent."
      redirect_to private_messages_path(conversation_id: @conversation.id)
    end
  end

  private

  def set_conversation
    if params[:conversation_id].blank?
      flash[:alert] = "Conversation ID missing!"
      redirect_to private_conversations_path and return
    end

    @conversation = Private::Conversation.find_by(id: params[:conversation_id])

    unless @conversation
      flash[:alert] = "Conversation not found."
      redirect_to private_conversations_path and return
    end
  end

  def message_params
    params.require(:private_message).permit(:body)
  end
end
