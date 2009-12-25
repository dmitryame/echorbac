class Client 
  include MongoMapper::Document
  timestamps!  

  key :name, String, :index => true
  
  has_many :subjects, :dependent => :destroy  
end
