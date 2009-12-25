class Subject
  include MongoMapper::Document
  timestamps!
  key :roles, Array, :index => true  

  key :name, String, :index => true
  
end
