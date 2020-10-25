class Private::ConversationsController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => :create
    
    def create
        @post = Post.find(params[:post_id])
        recipient_id = Post.find(params[:post_id]).user.id
        @conversation = Private::Conversation.new(sender_id: current_user.id, 
                                                 recipient_id: recipient_id)
        if @conversation.save
          Private::Message.create(user_id: recipient_id, 
                                  conversation_id: @conversation.id, 
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
        add_to_conversations unless already_added?
      end
      
      def close
        @conversation_id = params[:id].to_i
        session[:private_conversations].delete(@conversation_id)
      
        respond_to do |format|
          format.js
          format.html {redirect_to root_path};
        end
      end

      private

        def add_to_conversations
        session[:private_conversations] ||= []
        session[:private_conversations] << @conversation.id
        end

        def already_added?
            session[:private_conversations].include?(@conversation.id)
        end
end
