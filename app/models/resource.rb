class Resource 
  include MongoMapper::Document
  timestamps!  
  
  key :name, String, :index => true

  key :client_id, :index => true
  belongs_to :clients
    
  key :roles, Array, :index => true  


end
