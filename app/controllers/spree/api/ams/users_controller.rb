module Spree
  module Api
    module Ams
      class UsersController < Spree::Api::V1::UsersController
        include Serializable
        include Requestable
        
        before_action :handle_social, only: :create


        def token
          if @user = Spree.user_class.find_for_database_authentication(login: user_params[:email])
            if @user.valid_password? user_params[:password]

              @user.generate_spree_api_key! unless @user.spree_api_key

              render json: {
                id:    @user.id,
                email: @user.email,
                token: @user.spree_api_key
              }
            else
              # Wrong Password
              render json: {
                error: "Invalid resource. Please fix errors and try again.",
                errors: {
                  password: ["incorrect"]
                }
              }, status: 422
            end
          else
            # User Not Found
            render json: {
              error: "Invalid resource. Please fix errors and try again.",
              errors: {
                email: ["not found"]
              }
            }, status: 422
          end
        end
      end

      def create
        authorize! :create, Spree.user_class
        @user = Spree.user_class.new(user_params)
        @user.apply_omniauth(params[:omniauth]) if params[:omniauth].present?

        if @user.save 
          @user.generate_spree_api_key!
          respond_with(@user.attributes.merge!(token: @user.spree_api_key), status: 201, default_template: :show)
        else
          invalid_resource!(@user)
        end
      end

      def handle_social
          if params[:omniauth].present? && @user = Spree.user_class.find_for_database_authentication(login: params[:omniauth][:email])
            render json: {user:{
                id:    @user.id,
                email: @user.email,
                token: @user.spree_api_key
              }}
          end
      end

    end
  end
end
