Spree.user_class.class_eval do
  
  after_create :setup_api_key

  def setup_api_key
    generate_spree_api_key!
  end
end
