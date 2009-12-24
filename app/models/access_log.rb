class AccessLog 
  include MongoMapper::Document
  timestamps!  

  key :client_id, String

  belongs_to :client
end
