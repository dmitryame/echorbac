class User
  include MongoMapper::Document
  timestamps!
  
  devise :all
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation
end