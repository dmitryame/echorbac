class Client 
  include MongoMapper::Document
  timestamps!  

  key :name, String, :index => true
  
  has_many :subjects, :dependent => :destroy  
  has_many :resources, :dependent => :destroy  
  has_many :roles, :dependent => :destroy  
end
