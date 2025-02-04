module Private::MessagesHelper
  #not used
  def private_message_date_check(message, previous_message)
    return "" if message.nil? || previous_message.nil?

    if previous_message.created_at.to_date != message.created_at.to_date
      content_tag(:div, message.created_at.strftime("%B %d, %Y"), class: "message-date")
    else
      ""
    end
  end
end