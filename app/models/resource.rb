class Resource 
  include MongoMapper::Document
  timestamps!  
  
  key :name, String, :index => true
    
  key :roles, Array, :index => true  

end
