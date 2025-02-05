class Group::MessagesController < ApplicationController
  def create
    @message = Group::Message.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to group_conversation_path(@message.conversation)
    else
      render 'group/conversations/show'
    end
  end

  private

  def message_params
    params.require(:group_message).permit(:content, :conversation_id)
  end
end
