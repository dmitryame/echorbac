class Client 
  include MongoMapper::Document
  timestamps!  

  key :name, String, :index => true
end
