class Role 
  include MongoMapper::Document
  timestamps!  

  key :name, String, :index => true

  def subjects
    res = Subject.find_by_role(self) #TODO: eventually replace with appropriate assitiation once mondomapper starts supporting it
    res = Array.new if res == nil
  end
  def resources
    res = Resource.find_by_role(self) #TODO: eventually replace with appropriate assitiation once mondomapper starts supporting it
    res = Array.new if res == nil
  end
end
