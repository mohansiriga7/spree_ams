

require 'spec_helper'

module Spree
  describe Api::V1::UsersController, type: :controller do
    let(:user) { create(:user, spree_api_key: rand.to_s) }

    routes { Spree::Core::Engine.routes }
    render_views

    it 'should return valid response' do
        user_params = {
            email: 'new@example.com', password: 'spree123', password_confirmation: 'spree123'
        }

        api_post :create, user: user_params, token: user.spree_api_key

        #debugger
        res = JSON.parse(response.body)
        debugger
        expect(res['email']).to eq 'new@example.com'                                                                                                   
    end

    xit 'login the user if it already exists (no need for signup)' do
    end
  end
end


