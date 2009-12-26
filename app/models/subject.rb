class Subject
  include MongoMapper::Document
  devise :all

  timestamps!

  key :name, String, :index => true
  key :email, String, :index => true
  # key :password, String, :index => true
  # key :password_confirmation, String

  key :client_id, :index => true
  belongs_to :clients
  
  key :roles, Array, :index => true  
#TODO: remove once mongo mapper start to support it
  def subjects_roles
    Role.all(:id => roles)
  end


end
