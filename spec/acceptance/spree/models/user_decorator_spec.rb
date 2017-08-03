RSpec.describe Spree::User, type: :model do
  let(:user) { create(:user) }

  context 'api_key generated' do
    it 'api key should not be nil after create' do
        expect(user.spree_api_key).not_to be_nil
    end
    
  end
end
