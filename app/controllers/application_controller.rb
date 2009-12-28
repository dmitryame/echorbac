# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password


  # this method (is not an action) is used from different actions and filters as well
  # this method is a core of figuring out if a particulalr subject has access to a particular resource.
  # TODO: optimize performance
  def subject_has_access_to_resource?(subject_id, resource_to_verify)    
    return false unless subject_id 
    @subject = Subject.find(subject_id)
    @subject.subjects_roles.each do |role|
      
      role.resources.each do |resource|
        if resource_to_verify =~ Regexp.new(resource.name) #the resource string will be matched agains regular expression -- very powerful
          return true
        end
      end
    end
    return false
  end


end
