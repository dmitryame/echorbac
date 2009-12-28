class Resource 
  include MongoMapper::Document
  timestamps!  
  
  key :name, String, :required => true, :allow_blank => false, :index => true

  key :client_id, ObjectId, :required => true,  :index => true
  belongs_to :client
    
  key :roles, Array, :index => true  


  #TODO: remove once mongo mapper start to support it
    def resources_roles
      Role.all(:id => roles)
    end

    validate_on_create :name_uniqeue 

private 

    def name_uniqeue
      errors.add :name, "Duplicate name" if Subject.find_by_name_and_client_id(name, client_id) 
    end

end
