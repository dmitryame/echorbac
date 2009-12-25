class Resource 
  include MongoMapper::Document
  timestamps!  
  
  key :name, String, :index => true

  key :client_id, :index => true
  belongs_to :clients
    
  key :roles, Array, :index => true  

  #TODO: remove once mongo mapper start to support it
    def resources_roles
      Role.all(:id => roles)
    end

end
