class Profile 
  include MongoMapper::Document
  timestamps!  

  key :client_id, String
  key :subject_id, String

  belongs_to :client
  belongs_to :subject

end
