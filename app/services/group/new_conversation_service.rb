# frozen_string_literal: true
module Group
  class NewConversationService
    def initialize(params)
      @creator_id = params[:creator_id]
      @user_ids = params[:user_ids] || []
    end

    def call
      creator = User.find(@creator_id)
      users = User.where(id: @user_ids) # Find selected users

      new_group_conversation = Group::Conversation.new(name: generate_group_name(creator, users))

      if new_group_conversation.save
        # Add all selected users to the conversation
        (users + [creator]).each do |user|
          user.group_conversations << new_group_conversation
        end

        # Create an initial message
        create_initial_message(creator, users, new_group_conversation)

        return new_group_conversation
      else
        return nil
      end
    end

    private
    def generate_group_name(creator, users)
      "#{creator.name}, " + users.pluck(:name).join(", ")
    end

    def create_initial_message(creator, users, new_group_conversation)
      Group::Message.create(
        user_id: creator.id,
        content: "Conversation created by #{creator.name}",
        added_new_users: users.map(&:id),
        conversation_id: new_group_conversation.id
      )
    end
  end
end
