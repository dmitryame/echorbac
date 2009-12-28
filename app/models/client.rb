class Client 
  include MongoMapper::Document
  timestamps!  

  key :name, String, :index => true
  
  many :subjects, :dependent => :destroy  
  many :resources, :dependent => :destroy  
  many :roles, :dependent => :destroy  
end
