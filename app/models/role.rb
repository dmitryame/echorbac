class Role 
  include MongoMapper::Document
  timestamps!  

  key :name, String, :index => true

end
