class Private::ConversationsController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => :create

    def create
        @post = Post.find(params[:post_id])
        recipient_id = Post.find(params[:post_id]).user.id
        conversation = Private::Conversation.new(sender_id: current_user.id, 
                                                 recipient_id: recipient_id)
        if conversation.save
          Private::Message.create(user_id: recipient_id, 
                                  conversation_id: conversation.id, 
                                  body: params[:message_body])
          respond_to do |format|
            format.js {render partial: 'posts/show/contact_user/message_form/success.js.erb'}
            format.html {redirect_to root_path};
          end
        else
          respond_to do |format|
            format.js {render partial: 'posts/show/contact_user/message_form/fail.js'}
          end
        end
      end
end
