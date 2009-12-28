class Role 
  include MongoMapper::Document
  timestamps!  

  key :name, String, :required => true, :allow_blank => false, :index => true
  key :client_id, ObjectId, :required => true, :index => true
  belongs_to :client
  
  validate_on_create :name_uniqeue 
  
  

  # def subjects
  #   res = Subject.find_by_role(self) #TODO: eventually replace with appropriate assitiation once mondomapper starts supporting it
  #   res = Array.new if res == nil
  # end
  # def resources
  #   puts self.id
  #   res = Resource.all(self.id) #TODO: eventually replace with appropriate assitiation once mondomapper starts supporting it
  #   res = Array.new if res == nil
  # end
  private 
  
    def name_uniqeue
      errors.add :name, "Duplicate name" if Role.find_by_name_and_client_id(name, client_id) 
    end
  
end
