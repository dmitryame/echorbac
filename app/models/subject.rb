class Subject
  include MongoMapper::Document
  timestamps!

  key :name, String, :index => true
  key :email, String
  key :password, String
  key :password_confirmation, String

  key :client_id, :index => true
  belongs_to :clients
  
  key :roles, Array, :index => true  

#TODO: remove once mongo mapper start to support it
  def subjects_roles
    Role.all(:id => roles)
  end


end
